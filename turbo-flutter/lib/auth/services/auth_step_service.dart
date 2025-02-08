import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/auth/apis/user_profiles_api.dart';
import 'package:turbo_template/auth/apis/usernames_api.dart';
import 'package:turbo_template/auth/apis/users_api.dart';
import 'package:turbo_template/auth/dtos/user_dto.dart';
import 'package:turbo_template/auth/routing/auth_step_router.dart';
import 'package:turbo_template/auth/services/auth_service.dart';
import 'package:turbo_template/auth/services/user_service.dart';
import 'package:turbo_template/firebase/firestore/enums/firestore_collection.dart';
import 'package:turbo_template/local_storage/services/local_storage_service.dart';
import 'package:turbo_template/settings/apis/settings_api.dart';
import 'package:turbo_template/settings/dtos/settings_dto.dart';
import 'package:turbo_template/settings/services/settings_service.dart';
import 'package:turbo_template/state/abstracts/initialisable.dart';
import 'package:turbo_template/auth/enums/auth_step.dart';
import 'package:turbo_template/auth/enums/step_result.dart';
import 'package:turbo_template/state/exceptions/unexpected_null_exception.dart';
import 'package:turbo_template/state/exceptions/unexpected_state_exception.dart';
import 'package:turbo_template/data/extensions/date_time_extension.dart';
import 'package:turbo_template/data/globals/g_user_id.dart';

class AuthStepService extends Initialisable with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static AuthStepService get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(AuthStepService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _authService = AuthService.locate;
  final _localStorageService = LocalStorageService.locate;
  final _userService = UserService.locate;
  final _usersApi = UsersApi.locate;
  late final _authStepRouter = AuthStepRouter.locate;
  late final _profilesApi = UserProfilesApi.locate;
  late final _settingsApi = SettingsApi.locate;
  late final _usernamesApi = UsernamesApi.locate;
  late final _settingsService = SettingsService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> initialise() async {
    try {
      await FirestoreCollection.isReady;
      super.initialise();
    } catch (error, stackTrace) {
      log.error(
        '$error caught while initialising AuthStepService',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<StepResult> updateStepHappenedAndHandleNextStep({
    required AuthStep authStep,
  }) async =>
      await _manageNextStep(
        authStep: authStep,
      );

  void tryUpdateStepHappened({
    required AuthStep authStep,
  }) {
    log.debug('Updating startup step happened: $authStep');
    _localStorageService.updateAuthStepHappened(
      authStep: authStep,
    );
  }

  /// Returns true if handled and thus navigated somewhere
  Future<StepResult> handleAuthStep({
    AuthStep authStep = AuthStep.first,
    DateTime? acceptedPrivacyAndTermsAt,
  }) async {
    try {
      log.info('Handling startup step: $authStep');
      switch (authStep) {
        case AuthStep.createUserDoc:
          return await _manageCreateUserDoc(
            authStep,
            acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt,
          );
        case AuthStep.acceptPrivacy:
          return await _manageAcceptPrivacy(authStep);
        case AuthStep.createUsernameDoc:
          return await _manageCreateUsernameDoc(authStep);
        case AuthStep.createProfileDoc:
          return await _manageCreateProfileDoc(authStep);
        case AuthStep.verifyEmail:
          return await _manageVerifyEmail(authStep);
        case AuthStep.createSettingsDoc:
          return await _manageCreateSettingsDoc(authStep);
      }
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while trying handling the next startup step',
        error: error,
        stackTrace: stackTrace,
      );
      return StepResult.didNothing;
    }
  }

  // 🏗 HELPERS ------------------------------------------------------------------------------- \\

  Future<StepResult> _manageVerifyEmail(AuthStep authStep) async {
    final didNotVerifyEmail = _localStorageService.didNotHappen(
      authStep: authStep,
    );
    if (didNotVerifyEmail &&
        (_settingsService.skippedVerifyEmailDate?.isMoreThanHoursAgo(24) ?? true)) {
      log.debug('User did not verify email per local storage service, verifying email.');
      final hasVerifiedEmail = _authService.hasVerifiedEmail;
      if (await hasVerifiedEmail) {
        log.debug('User already verified email per auth service, continuing.');
        return await _manageNextStep(authStep: authStep);
      } else {
        log.debug('User did not verify email per auth service, navigating to verify email view.');
        _authStepRouter.goVerifyEmailView();
        return StepResult.didNavigate;
      }
    } else {
      log.debug('User skipped or already verified email per local storage service, continuing.');
      return await _manageNextStep(authStep: authStep);
    }
  }

  Future<StepResult> _manageCreateSettingsDoc(AuthStep authStep) async {
    final didNotCreateSettingsDoc = _localStorageService.didNotHappen(
      authStep: authStep,
    );
    if (didNotCreateSettingsDoc) {
      log.debug(
        'User did not create settings doc per local storage service, creating settings doc.',
      );
      final userId = gUserIdNotNull(when: 'creating settings document');
      final hasSettings = await _settingsApi.hasSettings(userId: userId);
      if (hasSettings) {
        log.debug('User already has a settings per firestore, continuing.');
        return await _manageNextStep(authStep: authStep);
      } else {
        log.debug('User does not have a settings per firestore, creating settings doc.');
        final response = await _settingsService.createSettings(
          doc: (vars) => SettingsDto.create(
            vars: vars,
          ),
        );
        if (response.isSuccess) {
          log.debug('Successfully created settings document.');
          return await _manageNextStep(authStep: authStep);
        } else {
          log.debug('Failed to create settings document.');
          throw const UnexpectedStateException(
            reason: 'User can not continue without creating a settings document.',
          );
        }
      }
    } else {
      log.debug('User already created profile doc per local storage service, continuing.');
      return await _manageNextStep(authStep: authStep);
    }
  }

  Future<StepResult> _manageCreateProfileDoc(AuthStep authStep) async {
    final didNotCreateProfileDoc = _localStorageService.didNotHappen(
      authStep: authStep,
    );
    if (didNotCreateProfileDoc) {
      log.debug('User did not create profile doc per local storage service, creating profile doc.');
      final userId = gUserIdNotNull(when: 'creating profile document');
      final hasProfile = await _profilesApi.profileExists(userId: userId);
      if (hasProfile) {
        log.debug('User already has a profile per firestore, continuing.');
        return await _manageNextStep(authStep: authStep);
      } else {
        log.debug('User does not have a profile per firestore, creating profile doc.');
        final username = await _usernamesApi.fetchUsername(userId: userId);
        if (username == null) {
          throw const UnexpectedNullException(
            reason: 'username should not be null when creating profile doc in startup step service',
          );
        }
        final response = await _profilesApi.createProfile(
          userId: userId,
          username: username,
        );
        if (response.isSuccess) {
          log.debug('Successfully created profile document with username: $username');
          return await _manageNextStep(authStep: authStep);
        } else {
          log.debug('Failed to create profile document.');
          throw const UnexpectedStateException(
            reason: 'User can not continue without creating a profile document.',
          );
        }
      }
    } else {
      log.debug('User already created profile doc per local storage service, continuing.');
      return await _manageNextStep(authStep: authStep);
    }
  }

  Future<StepResult> _manageCreateUsernameDoc(AuthStep authStep) async {
    final didNotCreateUsernameDoc = _localStorageService.didNotHappen(
      authStep: authStep,
    );
    if (didNotCreateUsernameDoc) {
      log.debug(
        'User did not create username doc per local storage service, creating username doc.',
      );
      final userId = gUserIdNotNull(when: 'creating username doc');
      final hasUsername = (await _usernamesApi.fetchUsername(userId: userId)) != null;
      if (hasUsername) {
        log.debug('User already has a username per firestore, continuing.');
        return await _manageNextStep(authStep: authStep);
      } else {
        log.debug(
          'User does not have a username per firestore, navigating to create username view.',
        );
        _authStepRouter.goCreateUsernameView();
        return StepResult.didNavigate;
      }
    } else {
      log.debug('User already created username doc per local storage service, continuing.');
      return await _manageNextStep(authStep: authStep);
    }
  }

  Future<StepResult> _manageAcceptPrivacy(
    AuthStep authStep, {
    DateTime? acceptedPrivacyAndTermsAt,
  }) async {
    final didNotAcceptPrivacy = _localStorageService.didNotHappen(
      authStep: authStep,
    );
    if (didNotAcceptPrivacy) {
      log.debug('User did not accept privacy per local storage service, accepting privacy.');
      final localAcceptedPrivacyAndTermsAt =
          acceptedPrivacyAndTermsAt ?? _userService.acceptedPrivacyAndTermsAt;
      if (localAcceptedPrivacyAndTermsAt == null) {
        log.debug(
          'acceptedPrivacyAndTermsAt is null when accepting privacy in startup step service, navigating to accept privacy view',
        );
        _authStepRouter.goAcceptPrivacyView();
        return StepResult.didNavigate;
      } else {
        log.debug('User already accepted privacy per user service, continuing.');
        return await _manageNextStep(authStep: authStep);
      }
    } else {
      log.debug('User already accepted privacy per local storage service, continuing.');
      return await _manageNextStep(authStep: authStep);
    }
  }

  Future<StepResult> _manageCreateUserDoc(
    AuthStep authStep, {
    DateTime? acceptedPrivacyAndTermsAt,
  }) async {
    final didNotCreatedUserDoc = _localStorageService.didNotHappen(
      authStep: authStep,
    );
    if (didNotCreatedUserDoc) {
      log.debug('User did not create user doc per local storage service, creating user doc.');
      final userId = gUserIdNotNull(
        when: 'creating user doc in startup step service',
      );
      final hasUserDocument = await _usersApi.userExists(userId: userId);
      if (!hasUserDocument) {
        log.debug('User does not have a user document per firestore, creating user document.');
        final email = _authService.email;
        if (email == null) {
          throw const UnexpectedNullException(
            reason: 'email should not be null when creating user doc in startup step service',
          );
        }
        final response = await _userService.createUser(
          doc: (vars) => UserDto.create(
            vars: vars,
            email: email,
            acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt,
            trialEnd: null,
          ),
        );
        if (response.isSuccess) {
          log.debug('Successfully created user document.');
          return await _manageNextStep(authStep: authStep);
        } else {
          throw const UnexpectedStateException(
            reason: 'User can not continue without creating a user document.',
          );
        }
      } else {
        log.debug('User already has a user document per firestore, continuing.');
        return await _manageNextStep(authStep: authStep);
      }
    } else {
      log.debug('User already created user doc per local storage service, continuing.');
      return await _manageNextStep(authStep: authStep);
    }
  }

  Future<StepResult> _manageNextStep({
    required AuthStep authStep,
  }) async {
    log.debug('Handling next step for $authStep..');
    final nextStep = _updateStepHappenedAndGetNextStep(
      authStep: authStep,
    );
    log.debug('Next step is $nextStep.');
    if (nextStep != null) {
      return await handleAuthStep(
        authStep: nextStep,
      );
    } else {
      // returning false means it did not handle any steps and we can continue
      return StepResult.didNothing;
    }
  }

  AuthStep? _updateStepHappenedAndGetNextStep({
    required AuthStep authStep,
  }) {
    tryUpdateStepHappened(authStep: authStep);
    return authStep.next;
  }
}
