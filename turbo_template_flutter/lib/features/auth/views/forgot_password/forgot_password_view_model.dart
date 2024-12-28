import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:informers/informers.dart';
import 'package:loglytics/loglytics.dart';
import 'package:veto/data/mixins/busy_service_management.dart';
import 'package:veto/data/models/base_view_model.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/forms/form_field_config.dart';
import '../../../../core/globals/g_strings.dart';
import '../../../../core/models/bread_crumb_model.dart';
import '../../../../core/routing/core_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../../enums/forgot_password_origin.dart';
import '../../forms/forgot_password.dart';
import '../../services/user_service.dart';

class ForgotPasswordViewModel extends BaseViewModel<ForgotPasswordOrigin>
    with Loglytics, BusyServiceManagement {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static ForgotPasswordViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(ForgotPasswordViewModel.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _feedbackService = FeedbackService.locate;
  final _firebaseAuth = FirebaseAuth.instance;
  final _forgotPasswordForm = ForgotPasswordForm.locate;
  late final _userService = UserService.locate;
  final _coreRouter = CoreRouter.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> initialise() async {
    try {
      log.info('Initialising ForgotPasswordViewModel.');
      setBusy(true);
      switch (origin) {
        case ForgotPasswordOrigin.core:
          _forgotPasswordForm.email.requestFocus();
          break;
        case ForgotPasswordOrigin.account:
          await _userService.isReady;
          _forgotPasswordForm.email.value = _userService.email;
          onEmailChanged('');
          break;
      }
    } catch (error, stackTrace) {
      log.error(
        '$error caught while initialising ForgotPasswordViewModel.',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
    super.initialise();
    log.info('ForgotPasswordViewModel initialised.');
  }

  @override
  void dispose() {
    log.info('Disposing ForgotPasswordViewModel.');
    sendEmailButtonFocusNode.dispose();
    _forgotPasswordForm.dispose();
    _canSendEmail.dispose();
    super.dispose();
    log.info('ForgotPasswordViewModel disposed.');
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  final _canSendEmail = Informer<bool>(false);
  final sendEmailButtonFocusNode = FocusNode(skipTraversal: true);

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  ForgotPasswordOrigin get origin => arguments;
  ValueListenable<bool> get canSendEmail => _canSendEmail;
  FormFieldConfig<String> get emailField => _forgotPasswordForm.email;
  List<BreadCrumbModel> get breadCrumbModels => [
        BreadCrumbModel(
          label: switch (origin) {
            ForgotPasswordOrigin.account => gStrings.account,
            ForgotPasswordOrigin.core => gStrings.login,
          },
          onPressed: () {
            switch (origin) {
              case ForgotPasswordOrigin.core:
                _coreRouter.goAuthView();
                // TODO(codaveto): Implement account router | 05/10/2024
                break;
              case ForgotPasswordOrigin.account:
                _coreRouter.goAuthView();
                break;
            }
          },
        ),
        BreadCrumbModel(
          label: switch (origin) {
            ForgotPasswordOrigin.account => gStrings.resetPassword,
            ForgotPasswordOrigin.core => gStrings.forgotPassword,
          },
          onPressed: () {},
        ),
      ];

  // 🏗 HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void onEmailChanged(String _) => _canSendEmail.update(_forgotPasswordForm.isValid);

  void onGoBackPressed({required BuildContext context}) => context.pop();

  Future<void> onSendEmailPressed({required BuildContext context}) async {
    try {
      if (_forgotPasswordForm.isValid) {
        log.info('Sending password reset email.');
        unawaited(_firebaseAuth.sendPasswordResetEmail(email: _forgotPasswordForm.email.value!));
        await _feedbackService.showOkDialog(
          context: context,
          title: (strings) => strings.resetPassword,
          message: (strings) => strings.ifRegisteredWeSend(_forgotPasswordForm.email.value!),
        );
        if (context.mounted) {
          context.pop();
        }
        log.info('Password reset email sent.');
      } else {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            _forgotPasswordForm.email.requestFocus();
          },
        );
      }
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while sending password reset email.',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
  }

  void onEmailSubmitted({required BuildContext context}) => context.unfocus();
}
