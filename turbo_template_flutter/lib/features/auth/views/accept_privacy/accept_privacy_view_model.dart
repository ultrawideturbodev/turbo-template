import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/core/constants/k_values.dart';
import 'package:turbo_template/core/enums/auth_step.dart';
import 'package:turbo_template/core/enums/step_result.dart';
import 'package:turbo_template/core/exceptions/unexpected_null_exception.dart';
import 'package:turbo_template/core/extensions/feedback_response_extension.dart';
import 'package:turbo_template/core/globals/g_now.dart';
import 'package:turbo_template/core/globals/g_strings.dart';
import 'package:turbo_template/core/routing/core_router.dart';
import 'package:turbo_template/core/services/feedback_service.dart';
import 'package:turbo_template/core/services/url_launcher_service.dart';
import 'package:turbo_template/features/auth/apis/users_api.dart';
import 'package:turbo_template/features/auth/services/auth_service.dart';
import 'package:turbo_template/features/auth/services/auth_step_service.dart';
import 'package:turbo_template/features/auth/services/user_service.dart';
import 'package:turbo_template/features/home/routing/home_router.dart';
import 'package:veto/data/enums/busy_type.dart';
import 'package:veto/data/mixins/busy_service_management.dart';
import 'package:veto/data/models/base_view_model.dart';

class AcceptPrivacyViewModel extends BaseViewModel with Loglytics, BusyServiceManagement {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static AcceptPrivacyViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(AcceptPrivacyViewModel.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _authService = AuthService.locate;
  final _authStepService = AuthStepService.locate;
  final _userService = UserService.locate;
  late final _feedbackService = FeedbackService.locate;
  late final _urlLauncherService = UrlLauncherService.locate;
  late final _coreRouter = CoreRouter.locate;
  final _homeRouter = HomeRouter.locate;

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
      final response = await _userService.updateAcceptedPrivacy(
        acceptedPrivacyAndTermsAt: gNow,
      );
      response.showIf(
        context: context,
        ifSuccessTitle: gStrings.privacyPolicyAndTermsOfServiceAccepted,
        ifErrorTitle: gStrings.unableToAcceptPleaseTryAgainLater,
      );
      if (response.isSuccess) {
        final result = await _authStepService.handleAuthStep(
          authStep: AuthStep.acceptPrivacy.next!,
        );
        switch (result) {
          case StepResult.didNavigate:
            break;
          case StepResult.didNothing:
            _homeRouter.goHomeView();
        }
      }
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
      final shouldLogout = await _feedbackService.showOkCancelDialog(
        title: (strings) => strings.logout,
        message: (strings) => strings.areYouSureYouWantToLogout,
      );
      if (shouldLogout ?? false) {
        setBusy(true);
        final response = await _authService.logout();
        response.showIf(
          context: context,
          ifSuccessTitle: 'Logged out',
          ifErrorTitle: 'Unable to log you out, please try again later.',
        );
        if (response.isSuccess) {
          _coreRouter.goAuthView();
        }
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
