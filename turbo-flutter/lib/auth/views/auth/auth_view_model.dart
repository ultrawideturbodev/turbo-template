import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:informers/informers.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/auth/enums/auth_view_mode.dart';
import 'package:turbo_template/auth/enums/step_result.dart';
import 'package:turbo_template/auth/forms/login_form.dart';
import 'package:turbo_template/auth/forms/register_form.dart';
import 'package:turbo_template/auth/services/auth_service.dart';
import 'package:turbo_template/auth/services/auth_step_service.dart';
import 'package:turbo_template/auth/services/email_service.dart';
import 'package:turbo_template/data/constants/k_durations.dart';
import 'package:turbo_template/data/constants/k_values.dart';
import 'package:turbo_template/data/extensions/duration_extension.dart';
import 'package:turbo_template/data/globals/g_now.dart';
import 'package:turbo_template/feedback/services/toast_service.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/home/routers/home_router.dart';
import 'package:turbo_template/http/services/url_launcher_service.dart';
import 'package:turbo_template/local_storage/services/local_storage_service.dart';
import 'package:turbo_template/routing/routers/core_router.dart';
import 'package:turbo_template/state/utils/min_duration_completer.dart';
import 'package:turbo_template/state/utils/mutex.dart';
import 'package:veto/veto.dart';

class AuthViewModel extends BaseViewModel with Loglytics, BusyServiceManagement {
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _toastService = ToastService.locate;
  final _urlLauncherService = UrlLauncherService.locate;
  final _emailService = EmailService.locate;
  final _authService = AuthService.locate;
  final _localStorageService = LocalStorageService.locate;
  final _authStepService = AuthStepService.locate;
  final _homeRouter = HomeRouter.locate;
  final _coreRouter = CoreRouter.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> initialise() async {
    await _authService.isReady;
    if (_authService.hasAuth.value) {
      await _authStepService.isReady;
      final result = await _authStepService.handleAuthStep();
      switch (result) {
        case StepResult.didNavigate:
          break;
        case StepResult.didNothing:
          _homeRouter.goHomeView();
          return;
      }
      log.info('Startup step handled!');
    }
    _authViewMode.addListener(_onAuthViewModeChanged);
    _showAgreeToPrivacyCheckBox.addListener(_onShowAgreePrivacyCheckbox);
    _onAuthViewModeChanged();
    _onShowAgreePrivacyCheckbox();
    super.initialise();
  }

  @override
  void dispose() {
    _authViewMode.removeListener(_onAuthViewModeChanged);
    _showAgreeToPrivacyCheckBox.removeListener(_onShowAgreePrivacyCheckbox);
    loginButtonFocusNode.dispose();
    registerButtonFocusNode.dispose();
    super.dispose();
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  final FocusNode loginButtonFocusNode = FocusNode();
  final FocusNode registerButtonFocusNode = FocusNode();
  final _authViewMode = Informer<AuthViewMode>(AuthViewMode.defaultValue);
  final _showAgreeToPrivacyCheckBox = Informer<bool>(false);
  final _loginForm = LoginForm.locate;
  final _registerForm = RegisterForm.locate;

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  final _mutex = Mutex();
  final _animationDurationCompleter = MinDurationCompleter(kDurationsAnimation);

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  bool canPop({required BuildContext context}) => context.canPop();

  DateTime? get acceptedPrivacyAndTermsAt =>
      (_registerForm.agreePrivacy.value ?? false) ? gNow : null;

  ValueListenable<bool> get showAgreeToPrivacyCheckBox => _showAgreeToPrivacyCheckBox;
  ValueListenable<AuthViewMode> get authViewMode => _authViewMode;

  TFieldConfig<String> get emailField {
    switch (_authViewMode.value) {
      case AuthViewMode.login:
        return _loginForm.email;
      case AuthViewMode.register:
        return _registerForm.email;
    }
  }

  TFieldConfig<String> get passwordField {
    switch (_authViewMode.value) {
      case AuthViewMode.login:
        return _loginForm.password;
      case AuthViewMode.register:
        return _registerForm.password;
    }
  }

  TFieldConfig<String> get confirmPasswordField => _registerForm.confirmPassword;
  TFieldConfig<bool> get agreePrivacyField => _registerForm.agreePrivacy;

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void _onShowAgreePrivacyCheckbox() =>
      _registerForm.agreePrivacy.focusNode.skipTraversal = !_showAgreeToPrivacyCheckBox.value;

  void _onAuthViewModeChanged() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        switch (_authViewMode.value) {
          case AuthViewMode.login:
            loginButtonFocusNode.skipTraversal = false;
            _registerForm.confirmPassword.focusNode.skipTraversal = true;
            break;
          case AuthViewMode.register:
            loginButtonFocusNode.skipTraversal = true;
            _registerForm.confirmPassword.focusNode.skipTraversal = false;
            break;
        }
      },
    );
  }

  void onPrivacyPolicyPressed() {
    try {
      setBusy(isBusy, busyType: BusyType.indicatorBackdropIgnorePointer);
      _urlLauncherService.tryLaunchUrl(url: kValuesPrivacyPolicyUrl);
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while trying to launch privacy policy url!',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
  }

  void onTermsOfServicePressed() {
    try {
      setBusy(isBusy, busyType: BusyType.indicatorBackdropIgnorePointer);
      _urlLauncherService.tryLaunchUrl(url: kValuesTermsOfServiceUrl);
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while trying to launch terms of service url!',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> onLoginPressed({required AuthViewMode authViewMode}) async {
    if (isBusy) {
      return;
    }
    await _mutex.lockAndRun(
      run: (unlock) async {
        try {
          switch (authViewMode) {
            case AuthViewMode.login:
              if (_loginForm.isValid) {
                setBusy(true, busyType: BusyType.indicatorBackdropIgnorePointer);

                final email = _loginForm.email.value!;
                final password = _loginForm.password.value!;
                final authResponse = await _emailService.login(
                  email: email,
                  password: password,
                );

                authResponse.when(
                  success: (response) {
                    _toastService.showToast(
                      context: context!,
                      title: 'Logged in',
                    );
                  },
                  fail: (response) {
                    _toastService.showToast(
                      context: context!,
                      title: 'Failed to log in',
                      subtitle: response.message,
                    );
                  },
                );

                if (authResponse.isSuccess) {
                  await _tryCreateUserDocAndNextView(
                    userId: authResponse.result.uid,
                    email: email,
                  );
                } else {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      _loginForm.password.requestFocus();
                    },
                  );
                }
              } else {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    if (_loginForm.email.isNotValid) {
                      _loginForm.email.requestFocus();
                    } else if (_loginForm.password.isNotValid) {
                      _loginForm.password.requestFocus();
                    }
                  },
                );
              }
              break;
            case AuthViewMode.register:
              _animationDurationCompleter.start();
              _authViewMode.update(AuthViewMode.login);

              if (_loginForm.email.valueTrimIsEmpty) {
                _loginForm.email.value = _registerForm.email.value;
              }
              if (_loginForm.password.valueTrimIsEmpty) {
                _loginForm.password.value = _registerForm.password.value;
              }

              await _animationDurationCompleter.future;
              break;
          }
        } catch (error, stackTrace) {
          log.error(
            'Exception caught while trying to register!',
            error: error,
            stackTrace: stackTrace,
          );
        } finally {
          unlock();
          setBusy(false);
          _restoreFocus();
        }
      },
    );
  }

  Future<void> onRegisterPressed({
    required AuthViewMode authViewMode,
  }) async =>
      await _mutex.lockAndRun(
        run: (unlock) async {
          try {
            switch (authViewMode) {
              case AuthViewMode.login:
                _registerForm.email.initialValue = _loginForm.email.value;
                _registerForm.password.initialValue = _loginForm.password.value;
                _animationDurationCompleter.start();
                _authViewMode.update(AuthViewMode.register);
                await _animationDurationCompleter.future;
                break;
              case AuthViewMode.register:
                try {
                  if (_registerForm.isValid) {
                    setBusy(true, busyType: BusyType.indicatorBackdropIgnorePointer);

                    final email = _registerForm.email.value!;
                    final password = _registerForm.password.value!;
                    final authResponse = await _emailService.register(
                      email: email,
                      password: password,
                    );
                    final userId = authResponse.result?.uid;
                    if (userId != null) {
                      await _tryCreateUserDocAndNextView(
                        userId: userId,
                        email: email,
                      );
                    }
                    authResponse.when(
                      success: (response) {
                        _toastService.showToast(context: context!, title: 'Account created');
                      },
                      fail: (response) {
                        _toastService.showToast(
                          context: context!,
                          title: 'Account creation failed',
                          subtitle: response.message,
                        );
                      },
                    );
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        if (_registerForm.email.isNotValid) {
                          _registerForm.email.requestFocus();
                        } else if (_registerForm.password.isNotValid) {
                          _registerForm.password.requestFocus();
                        } else if (_registerForm.confirmPassword.isNotValid) {
                          _registerForm.confirmPassword.requestFocus();
                        } else if (_registerForm.agreePrivacy.isNotValid) {
                          _registerForm.agreePrivacy.requestFocus();
                        }
                      },
                    );
                  }
                } catch (error, stackTrace) {
                  log.error(
                    'Unexpected ${error.runtimeType} caught while registering with email',
                    error: error,
                    stackTrace: stackTrace,
                  );
                }
                break;
            }
          } catch (error, stackTrace) {
            log.error(
              'Exception caught while trying to register!',
              error: error,
              stackTrace: stackTrace,
            );
          } finally {
            unlock();
            setBusy(false);
            _restoreFocus();
          }
        },
      );

  Future<void> _tryCreateUserDocAndNextView({
    required String userId,
    required String email,
  }) async {
    await _authService.isReady;
    await _localStorageService.isReady;
    await _authStepService.isReady;
    final result = await _authStepService.handleAuthStep(
      acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt,
    );
    switch (result) {
      case StepResult.didNavigate:
        break;
      case StepResult.didNothing:
        _homeRouter.goHomeView();
        break;
    }
  }

  void onForgotPasswordPressed() => _coreRouter.pushForgotPasswordView().then(
        (_) {
          if (isMounted) {
            _restoreFocus();
          }
        },
      );

  void _restoreFocus() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (!kIsWeb) {
          await kDurationsAnimation.asFuture;
        }
        switch (authViewMode.value) {
          case AuthViewMode.login:
            if (_loginForm.email.valueTrimIsEmpty) {
              _loginForm.email.requestFocus();
            } else if (_loginForm.password.valueTrimIsEmpty) {
              _loginForm.password.requestFocus();
            } else {
              loginButtonFocusNode.requestFocus();
            }
          case AuthViewMode.register:
            if (_registerForm.email.valueTrimIsEmpty) {
              _registerForm.email.requestFocus();
            } else if (_registerForm.password.valueTrimIsEmpty) {
              _registerForm.password.requestFocus();
            } else if (_registerForm.confirmPassword.valueTrimIsEmpty) {
              _registerForm.confirmPassword.requestFocus();
            } else {
              registerButtonFocusNode.requestFocus();
            }
        }
      },
    );
  }

  // 🏗 HELPERS ---------------------------dis---------------------------------------------------- \\
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  void onConfirmPasswordChanged(String value) =>
      _showAgreeToPrivacyCheckBox.update(value.isNotEmpty);

  void onEmailSubmitted(String value) {
    switch (_authViewMode.value) {
      case AuthViewMode.login:
        if (_loginForm.email.isValid) {
          _loginForm.password.requestFocus();
        }
        break;
      case AuthViewMode.register:
        if (_registerForm.email.isValid) {
          _registerForm.password.requestFocus();
        }
        break;
    }
  }

  void onPasswordSubmitted({
    required String value,
    required BuildContext context,
  }) {
    switch (_authViewMode.value) {
      case AuthViewMode.login:
        if (_loginForm.password.isValid) {
          onLoginPressed(
            authViewMode: _authViewMode.value,
          );
        }
        break;
      case AuthViewMode.register:
        if (_registerForm.password.isValid) {
          _registerForm.confirmPassword.requestFocus();
        }
        break;
    }
  }

  void onConfirmPasswordSubmitted(String value) {
    if (_registerForm.confirmPassword.isValid) {
      _registerForm.agreePrivacy.requestFocus();
    }
  }

  static AuthViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(AuthViewModel.new);

  void onAppleAuthPressed() {}

  void onGoogleAuthPressed() {}
}
