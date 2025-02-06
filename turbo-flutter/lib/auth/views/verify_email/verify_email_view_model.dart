import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informers.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/auth/services/auth_service.dart';
import 'package:turbo_template/auth/services/auth_step_service.dart';
import 'package:turbo_template/home/routing/home_router.dart';
import 'package:turbo_template/settings/services/settings_service.dart';
import 'package:turbo_template/turbo/enums/auth_step.dart';
import 'package:turbo_template/turbo/globals/g_now.dart';
import 'package:turbo_template/turbo/globals/g_strings.dart';
import 'package:turbo_template/turbo/services/dialog_service.dart';
import 'package:turbo_template/turbo/services/toast_service.dart';
import 'package:veto/data/mixins/busy_service_management.dart';
import 'package:veto/data/models/base_view_model.dart';

class VerifyEmailViewModel extends BaseViewModel with Loglytics, BusyServiceManagement {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static VerifyEmailViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(VerifyEmailViewModel.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _dialogService = DialogService.locate;
  final _authService = AuthService.locate;
  final _authStepService = AuthStepService.locate;
  final _toastService = ToastService.locate;
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
          _toastService.showToast(
            context: context,
            title: 'Email verified',
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
            _dialogService.showOkDialog(
              context: context,
              title: gStrings.emailNotYetVerified,
              message: gStrings.weHaveResentTheVerificationEmailPleaseCheckYourInbox,
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
