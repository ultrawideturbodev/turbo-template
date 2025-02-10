import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_firestore_api/apis/turbo_firestore_api.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/auth/apis/user_profiles_api.dart';
import 'package:turbo_template/auth/apis/usernames_api.dart';
import 'package:turbo_template/auth/enums/auth_step.dart';
import 'package:turbo_template/auth/enums/step_result.dart';
import 'package:turbo_template/auth/forms/create_username_form.dart';
import 'package:turbo_template/auth/services/auth_service.dart';
import 'package:turbo_template/auth/services/auth_step_service.dart';
import 'package:turbo_template/data/constants/k_durations.dart';
import 'package:turbo_template/data/extensions/string_extension.dart';
import 'package:turbo_template/feedback/globals/g_vibrate.dart';
import 'package:turbo_template/feedback/services/dialog_service.dart';
import 'package:turbo_template/forms/config/t_field_config.dart';
import 'package:turbo_template/home/routers/home_router.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';
import 'package:turbo_template/state/exceptions/unexpected_null_exception.dart';
import 'package:turbo_template/state/utils/debouncer.dart';
import 'package:veto/data/mixins/busy_service_management.dart';
import 'package:veto/data/models/base_view_model.dart';

/// Manages the username creation process during user onboarding.
///
/// Provides functionality for:
/// * Username validation and availability checking
/// * Real-time feedback
/// * Firestore document creation
/// * Navigation flow
///
/// ```dart
/// final model = CreateUsernameViewModel.locate;
/// model.onUserNameChanged('newUsername');
/// await model.save(context: context);
/// ```
class CreateUsernameViewModel extends BaseViewModel with Loglytics, BusyServiceManagement {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  /// Returns the singleton instance.
  static CreateUsernameViewModel get locate => GetIt.I.get();

  /// Registers this view model with the service locator.
  static void registerFactory() => GetIt.I.registerFactory(CreateUsernameViewModel.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  late final _dialogService = DialogService.locate;
  final _authService = AuthService.locate;
  final _authStepsService = AuthStepService.locate;
  final _createUsernameForm = CreateUsernameForm.locate;
  final _profilesApi = UserProfilesApi.locate;
  final _usernamesApi = UsernamesApi.locate;
  final _homeRouter = HomeRouter.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  /// Sets up the initial state and focus.
  @override
  Future<void> initialise() async {
    super.initialise();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _createUsernameForm.username.requestFocus();
      },
    );
  }

  /// Releases resources held by this view model.
  @override
  void dispose() {
    _username.dispose();
    _usernameIsAvailable.dispose();
    saveButtonFocusNode.dispose();
    super.dispose();
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  /// The current username value.
  late final _username = Informer<String>(usernamePlaceholder);

  /// Whether the current username can be used.
  ///
  /// Values:
  /// * `null` - Not yet checked or invalid
  /// * `true` - Username is available
  /// * `false` - Username is taken or invalid
  final _usernameIsAvailable = Informer<bool?>(null);

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  /// Prevents rapid-fire availability checks.
  final _debouncer = Debouncer(duration: kDurationsAnimationX0p5);

  /// Controls focus for the save action button.
  final saveButtonFocusNode = FocusNode();

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  /// Returns the form field configuration for username input.
  TFieldConfig<String> get usernameField => _createUsernameForm.username;

  /// Returns the default username placeholder text.
  String get usernamePlaceholder => gStrings.stranger;

  /// Returns a stream of username changes.
  ValueListenable<String> get username => _username;

  /// Returns a stream of username availability status changes.
  ValueListenable<bool?> get usernameIsAvailable => _usernameIsAvailable;

  bool get usernameIsValid => usernameField.isValidSilent;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  /// Verifies if the current username is available for use.
  ///
  /// [userId] The ID of the current user.
  ///
  /// Updates the [_usernameIsAvailable] state and provides haptic feedback
  /// based on the result.
  void _tryUpdateUsernameAvailability({required String userId}) => _debouncer.run(
        () async {
          final iUsernameIsAvailable = _usernameIsAvailable.value;
          final username = _username.value;
          if (username == usernamePlaceholder ||
              username.isEmpty ||
              username.length < 3 ||
              username.length > 30) {
            _usernameIsAvailable.update(null);
          } else if (!username.isValidUsername) {
            _usernameIsAvailable.update(false);
          } else {
            final usernameIsAvailable = await _usernamesApi.usernameIsAvailable(
              username: username,
              userId: userId,
            );
            _usernameIsAvailable.update(usernameIsAvailable);
          }
          if (iUsernameIsAvailable != _usernameIsAvailable.value) {
            switch (_usernameIsAvailable.value) {
              case null:
                break;
              case true:
                gVibrateSuccess();
              case false:
                gVibrateError();
                break;
            }
          }
        },
      );

  /// Creates a new username for the current user.
  ///
  /// [context] The build context for showing feedback dialogs.
  ///
  /// Throws an [UnexpectedNullException] if [userId] is null.
  ///
  /// The process:
  /// 1. Validates the username
  /// 2. Creates Firestore documents
  /// 3. Updates authentication state
  /// 4. Navigates to the next screen
  Future<void> save({required BuildContext context}) async {
    if (isBusy) return;
    try {
      setBusy(true);
      final usernameIsAvailable = _usernameIsAvailable.value;
      if (usernameIsAvailable != null && !usernameIsAvailable) {
        unawaited(
          _dialogService.showOkDialog(
            context: context,
            title: gStrings.unavailable,
            message: gStrings.usernameIsAlreadyTaken,
          ),
        );
        return;
      }
      final userId = _authService.userId;
      if (userId == null) {
        throw const UnexpectedNullException(
          reason: 'userId should not be null when saving username',
        );
      }
      if (_createUsernameForm.isValid) {
        final username = _username.value;
        final createUsernameResponse = await _usernamesApi.runTransaction<TurboResponse>(
          (transaction) => transaction.get(_usernamesApi.getDocRefById(id: username)).then(
            (doc) async {
              if (doc.exists &&
                  !(await _usernamesApi.isMe(
                    username: username,
                    userId: userId,
                  ))) {
                return TurboResponse.failAsBool(
                  title: gStrings.alreadyInUse,
                  message: gStrings.usernameIsAlreadyInUsePleaseChooseADifferentOne,
                );
              } else {
                return _usernamesApi
                    .deleteOldUsernames(
                  userId: userId,
                  transaction: transaction,
                )
                    .then(
                  (response) {
                    response.throwWhenFail();
                    return _usernamesApi.createUsername(
                      username: username,
                      userId: userId,
                      transaction: transaction,
                    );
                  },
                );
              }
            },
          ),
        );
        if (createUsernameResponse.isSuccess) {
          _authStepsService.tryUpdateStepHappened(
            authStep: AuthStep.createUsernameDoc,
          );
          final createProfileResponse = await _profilesApi.runTransaction<TurboResponse>(
            (transaction) => transaction.get(_usernamesApi.getDocRefById(id: username)).then(
                  (doc) async => await _profilesApi.createProfile(
                    userId: userId,
                    username: doc.id,
                  ),
                ),
          );
          if (createProfileResponse.isSuccess) {
            final result = await _authStepsService.updateStepHappenedAndHandleNextStep(
              authStep: AuthStep.createProfileDoc,
            );
            switch (result) {
              case StepResult.didNavigate:
                break;
              case StepResult.didNothing:
                _homeRouter.goHomeView();
            }
          } else {
            unawaited(
              _dialogService.showOkDialog(
                context: context,
                title: gStrings.databaseFailure,
                message: gStrings.somethingWentWrongWhileTryingToCreateYourProfilePlease,
              ),
            );
          }
        } else {
          unawaited(
            _dialogService.showSomethingWentWrongDialog(context: context),
          );
        }
      }
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while saving username',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
  }

  /// Updates the username value and checks availability.
  ///
  /// [value] The new username to validate.
  ///
  /// Throws an [UnexpectedNullException] if [userId] is null during validation.
  void onUserNameChanged(String value) {
    try {
      final usernameNaked = value.naked;
      if (usernameNaked.isNotEmpty) {
        _username.update('$usernameNaked');
      } else {
        _username.update(usernamePlaceholder);
      }
      final userId = _authService.userId;
      if (userId == null) {
        throw const UnexpectedNullException(
          reason: 'userId should not be null when creating user name and updating availability',
        );
      }
      _tryUpdateUsernameAvailability(userId: userId);
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while updating username availability',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
