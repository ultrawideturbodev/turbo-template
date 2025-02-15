import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:informers/informers.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';
import 'package:turbo_template/feedback/services/dialog_service.dart';
import 'package:veto/data/mixins/busy_service_management.dart';
import 'package:veto/data/models/base_view_model.dart';

import '../../forms/forgot_password.dart';

class ForgotPasswordViewModel extends BaseViewModel with Loglytics, BusyServiceManagement {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static ForgotPasswordViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(ForgotPasswordViewModel.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _dialogService = DialogService.locate;
  final _firebaseAuth = FirebaseAuth.instance;
  final _forgotPasswordForm = ForgotPasswordForm.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> initialise() async {
    try {
      log.info('Initialising ForgotPasswordViewModel.');
      setBusy(true);
      _forgotPasswordForm.email.requestFocus();
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

  ValueListenable<bool> get canSendEmail => _canSendEmail;
  TFieldConfig<String> get emailField => _forgotPasswordForm.email;

  // 🏗 HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void onEmailChanged(String _) => _canSendEmail.update(_forgotPasswordForm.isValid);

  void onGoBackPressed({required BuildContext context}) => context.pop();

  Future<void> onSendEmailPressed({required BuildContext context}) async {
    try {
      if (_forgotPasswordForm.isValid) {
        log.info('Sending password reset email.');
        unawaited(_firebaseAuth.sendPasswordResetEmail(email: _forgotPasswordForm.email.value!));
        await _dialogService.showOkDialog(
          context: context,
          title: gStrings.resetPassword,
          message: gStrings.ifRegisteredWeSend(_forgotPasswordForm.email.value!),
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
