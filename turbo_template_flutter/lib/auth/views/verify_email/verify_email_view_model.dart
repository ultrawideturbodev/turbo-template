import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informers.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/core/enums/auth_step.dart';
import 'package:turbo_template/core/globals/g_now.dart';
import 'package:turbo_template/core/services/feedback_service.dart';
import 'package:turbo_template/core/services/notification_service.dart';
import 'package:turbo_template/auth/services/auth_service.dart';
import 'package:turbo_template/auth/services/auth_step_service.dart';
import 'package:turbo_template/home/routing/home_router.dart';
import 'package:turbo_template/settings/services/settings_service.dart';
import 'package:veto/data/mixins/busy_service_management.dart';
import 'package:veto/data/models/base_view_model.dart';

class VerifyEmailViewModel extends BaseViewModel with Loglytics, BusyServiceManagement {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static VerifyEmailViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(VerifyEmailViewModel.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _authService = AuthService.locate;
  final _authStepService = AuthStepService.locate;
  final _feedbackService = FeedbackService.locate;
  final _notificationService = NotificationService.locate;
  final _settingsService = SettingsService.locate;
  final _homeRouter = HomeRouter.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> initialise() async {
    log.info('Initialising VerifyEmailViewModel..');
    super.initialise();
    log.info('VerifyEmailViewModel initialised!');
  }

  @override
  void dispose() {
    log.info('Disposing VerifyEmailViewModel..');
    _canCheckStatus.dispose();
    _timer?.cancel();
    super.dispose();
    log.info('VerifyEmailViewModel disposed!');
  }

  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  final _canCheckStatus = Informer<bool>(true);
  Timer? _timer;

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  ValueListenable<bool> get canCheckStatus => _canCheckStatus;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  void _startCanLogicAndTimer() {
    _canCheckStatus.update(false);
    _timer?.cancel();
    _timer = Timer(
      const Duration(seconds: 10),
      () async {
        _canCheckStatus.update(true);
        _timer = null;
      },
    );
  }

  void _resend() {
    _authService.sendVerifyEmailEmail();
  }

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<void> onSendEmailPressed({required BuildContext context}) async {
    try {
      if (_canCheckStatus.value) {
        setBusy(true);
        _startCanLogicAndTimer();
        log.info('Checking verified email status..');
        final hasVerifiedEmail = _authService.hasVerifiedEmail;
        if (await hasVerifiedEmail) {
          log.info('Email verified');
          unawaited(
            _notificationService.showNotification(
              context: null,
              title: 'gStrings.emailVerified', // TODO(brian): Translate add to INTL | 28/12/2024
              message: 'gStrings.thankYouAndWelcomeToRoomy',
            ),
          );
          log.info('Updating startup step..');
          unawaited(
            _authStepService.updateStepHappenedAndHandleNextStep(
              authStep: AuthStep.verifyEmail,
            ),
          );
        } else {
          log.info('Email not yet verified');
          _resend();
          unawaited(
            _feedbackService.showOkDialog(
              context: context,
              title: (strings) => 'gStrings.emailNotYetVerified',
              message: (strings) => 'gStrings.weHaveResentTheVerificationEmailPleaseCheckYourInbox',
            ),
          );
        }
      }
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while checking verified email status.',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> onSkipPressed() async {
    unawaited(
      _settingsService.updateSkippedVerifyEmailDate(
        skippedVerifyEmailDate: gNow,
      ),
    );
    _homeRouter.goHomeView();
  }
}
