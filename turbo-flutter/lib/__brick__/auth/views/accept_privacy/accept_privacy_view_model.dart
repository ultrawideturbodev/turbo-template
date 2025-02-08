import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:{{packageName.snakeCase()}}/auth/apis/users_api.dart';
import 'package:{{packageName.snakeCase()}}/auth/services/auth_service.dart';
import 'package:{{packageName.snakeCase()}}/auth/services/auth_step_service.dart';
import 'package:{{packageName.snakeCase()}}/auth/services/user_service.dart';
import 'package:{{packageName.snakeCase()}}/data/constants/k_values.dart';
import 'package:{{packageName.snakeCase()}}/auth/enums/auth_step.dart';
import 'package:{{packageName.snakeCase()}}/auth/enums/step_result.dart';
import 'package:{{packageName.snakeCase()}}/state/exceptions/unexpected_null_exception.dart';
import 'package:{{packageName.snakeCase()}}/data/globals/g_now.dart';
import 'package:{{packageName.snakeCase()}}/localizations/globals/g_strings.dart';
import 'package:{{packageName.snakeCase()}}/routing/routers/core_router.dart';
import 'package:{{packageName.snakeCase()}}/feedback/services/dialog_service.dart';
import 'package:{{packageName.snakeCase()}}/feedback/services/toast_service.dart';
import 'package:{{packageName.snakeCase()}}/http/services/url_launcher_service.dart';
import 'package:{{packageName.snakeCase()}}/home/routers/home_router.dart';
import 'package:veto/data/enums/busy_type.dart';
import 'package:veto/data/mixins/busy_service_management.dart';
import 'package:veto/data/models/base_view_model.dart';

class AcceptPrivacyViewModel extends BaseViewModel with Loglytics, BusyServiceManagement {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static AcceptPrivacyViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(AcceptPrivacyViewModel.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _toastService = ToastService.locate;
  final _authService = AuthService.locate;
  final _authStepService = AuthStepService.locate;
  late final _urlLauncherService = UrlLauncherService.locate;
  late final _coreRouter = CoreRouter.locate;
  late final _homeRouter = HomeRouter.locate;
  final _userService = UserService.locate;
  late final _dialogService = DialogService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<void> onAcceptPressed() async {
    try {
      setBusy(true);
      final userId = _authService.userId;
      if (userId == null) {
        throw const UnexpectedNullException(
          reason: 'userId should not be null when pressing accept in accept privacy view',
        );
      }
      final response = await _userService.updateAcceptedPrivacyAndTermsAt(
        acceptedPrivacyAndTermsAt: gNow,
      );

      await response.when(
        success: (response) async {
          _toastService.showToast(
              context: context!, title: gStrings.privacyPolicyAndTermsOfServiceAccepted);
          final result = await _authStepService.handleAuthStep(
            authStep: AuthStep.acceptPrivacy.next!,
          );
          switch (result) {
            case StepResult.didNavigate:
              break;
            case StepResult.didNothing:
              _homeRouter.goHomeView();
          }
        },
        fail: (response) async => _toastService.showToast(
          context: context!,
          title: gStrings.unableToAcceptPleaseTryAgainLater,
        ),
      );
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while accepting privacy',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
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

  Future<void> onBackPressed() async {
    try {
      final shouldLogout = await _dialogService.showOkCancelDialog(
        context: context!,
        title: gStrings.logout,
        message: gStrings.areYouSureYouWantToLogout,
      );
      if (shouldLogout ?? false) {
        setBusy(true);
        final response = await _authService.logout();

        response.when(
          success: (response) {
            _toastService.showToast(context: context!, title: 'Logged out');
            _coreRouter.goAuthView();
          },
          fail: (response) {
            _toastService.showToast(
              context: context!,
              title: 'We were unable to log you out. Please try again later.',
            );
          },
        );
      }
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while trying to logout!',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
  }
}
