import 'dart:async';

import 'package:feedback_response/feedback_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/core/constants/k_durations.dart';
import 'package:turbo_template/core/enums/auth_step.dart';
import 'package:turbo_template/core/enums/step_result.dart';
import 'package:turbo_template/core/exceptions/unexpected_null_exception.dart';
import 'package:turbo_template/core/extensions/string_extension.dart';
import 'package:turbo_template/core/forms/form_field_config.dart';
import 'package:turbo_template/core/globals/g_vibrate.dart';
import 'package:turbo_template/core/services/feedback_service.dart';
import 'package:turbo_template/core/utils/debouncer.dart';
import 'package:turbo_template/features/auth/apis/user_profiles_api.dart';
import 'package:turbo_template/features/auth/apis/usernames_api.dart';
import 'package:turbo_template/features/auth/forms/create_username_form.dart';
import 'package:turbo_template/features/auth/services/auth_service.dart';
import 'package:turbo_template/features/auth/services/auth_step_service.dart';
import 'package:turbo_template/features/home/routing/home_router.dart';
import 'package:veto/data/mixins/busy_service_management.dart';
import 'package:veto/data/models/base_view_model.dart';

class CreateUsernameViewModel extends BaseViewModel with Loglytics, BusyServiceManagement {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static CreateUsernameViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(CreateUsernameViewModel.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  final _authService = AuthService.locate;
  final _authStepsService = AuthStepService.locate;
  final _createUsernameForm = CreateUsernameForm.locate;
  final _feedbackService = FeedbackService.locate;
  final _profilesApi = UserProfilesApi.locate;
  final _usernamesApi = UsernamesApi.locate;
  final _homeRouter = HomeRouter.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> initialise() async {
    super.initialise();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _createUsernameForm.username.requestFocus();
      },
    );
  }

  @override
  void dispose() {
    _username.dispose();
    _usernameIsAvailable.dispose();
    saveButtonFocusNode.dispose();
    super.dispose();
  }

  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  late final _username = Informer<String>(usernamePlaceholder);
  final _usernameIsAvailable = Informer<bool?>(null);

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  final _debouncer = Debouncer(duration: kDurationsAnimationX0p5);
  final saveButtonFocusNode = FocusNode();

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  FormFieldConfig<String> get usernameField => _createUsernameForm.username;
  String get usernamePlaceholder => 'Stranger'; // TODO(brian): Translate | 28/12/2024
  ValueListenable<String> get username => _username;
  ValueListenable<bool?> get usernameIsAvailable => _usernameIsAvailable;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

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

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<void> save({required BuildContext context}) async {
    if (isBusy) return;
    try {
      setBusy(true);
      final usernameIsAvailable = _usernameIsAvailable.value;
      if (usernameIsAvailable != null && !usernameIsAvailable) {
        unawaited(
          _feedbackService.showOkDialog(
            context: context,
            title: (strings) =>
                'gStrings.unavailable', // TODO(brian): Translate add to INTL | 28/12/2024
            message: (strings) =>
                'gStrings.usernameIsAlreadyTaken', // TODO(brian): Translate add to INTL | 28/12/2024
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
        final createUsernameResponse = await _usernamesApi.runTransaction<FeedbackResponse>(
          (transaction) => transaction.get(_usernamesApi.findDocRef(id: username)).then(
            (doc) async {
              if (doc.exists &&
                  !(await _usernamesApi.isMe(
                    username: username,
                    userId: userId,
                  ))) {
                return FeedbackResponse.error(
                  title: 'gStrings.alreadyInUse',
                  message: 'gStrings.usernameIsAlreadyInUsePleaseChooseADifferentOne',
                );
              } else {
                return _usernamesApi
                    .deleteOldUsernames(
                  userId: userId,
                  transaction: transaction,
                )
                    .then(
                  (response) {
                    if (!response.isSuccess) {
                      return FeedbackResponse.error(
                        title: 'gStrings.deletingFailed',
                        message:
                            'gStrings.somethingWentWrongWhileDeletingOldUsernamesPleaseTryAgain',
                      );
                    }
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
          final createProfileResponse = await _profilesApi.runTransaction<FeedbackResponse>(
            (transaction) => transaction.get(_usernamesApi.findDocRef(id: username)).then(
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
              _feedbackService.showOkDialog(
                context: context,
                title: (strings) => 'gStrings.databaseFailure',
                message: (strings) =>
                    'gStrings.somethingWentWrongWhileTryingToCreateYourProfilePlease',
              ),
            );
          }
        } else {
          unawaited(
            _feedbackService.showResponse(response: createUsernameResponse, context: context),
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

// 🛠 UTIL ---------------------------------------------------------------------------------- \\

// 🧲 FETCHERS ------------------------------------------------------------------------------ \\

// 🪄 MUTATORS ------------------------------------------------------------------------------ \\

// 🏗️ HELPERS ------------------------------------------------------------------------------- \\

// 📍 LOCATOR ------------------------------------------------------------------------------- \\
}
