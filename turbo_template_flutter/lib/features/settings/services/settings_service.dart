import 'package:feedback_response/feedback_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:turbo_template/core/abstracts/document_service.dart';
import 'package:turbo_template/core/constants/k_keys.dart';
import 'package:turbo_template/core/typedefs/lazy_locator.dart';
import 'package:turbo_template/features/settings/apis/settings_api.dart';
import 'package:turbo_template/features/settings/dtos/settings_dto.dart';

import '../../../core/globals/g_user_id.dart';

class SettingsService extends DocumentService<SettingsDto, SettingsApi> {
  SettingsService()
      : super(
          api: SettingsApi.locate,
        );

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static SettingsService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(SettingsService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\

  @override
  Future<void> Function(User user)? get onAuth => (user) async {
        final settingsDto = doc.value;
        if (settingsDto == null || settingsDto.isLocalDefault) {
          updateLocalSettingsWithId(
            userId: user.uid,
            settingsDto: initialValueLocator!(),
          );
        }
      };

  @override
  LazyLocator<SettingsDto>? get initialValueLocator => () => SettingsDto.defaultDto(
        userId: gUserId,
      );

  @override
  Stream<SettingsDto?> Function(User user) get stream => (user) => api
      .findStreamByQueryWithConverter(
        whereDescription: '$kKeysUserId equals ${user.uid}',
        collectionReferenceQuery: (collectionReference) => collectionReference.where(
          kKeysUserId,
          isEqualTo: user.uid,
        ),
      )
      .map(
        (event) => event.firstOrNull,
      );

  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  SettingsDto get settingsDto => doc.value!;
  bool get hasSettings => hasDoc;
  DateTime? get skippedVerifyEmailDate => doc.value?.skippedVerifyEmailDate;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void updateLocalSettingsWithId({
    required String userId,
    required SettingsDto settingsDto,
  }) =>
      updateLocalDoc(
        doc: settingsDto.copyWith(
          userId: userId,
        ),
      );

  Future<FeedbackResponse> updateSkippedVerifyEmailDate({
    required DateTime skippedVerifyEmailDate,
  }) =>
      updateDoc(
        doc: settingsDto.copyWith(
          skippedVerifyEmailDate: skippedVerifyEmailDate,
        ),
        remoteUpdateRequestBuilder: (doc) => doc.asUpdateSkippedVerifyEmailDateRequest,
      );

  Future<FeedbackResponse> createSettings({
    required SettingsDto settingsDto,
  }) async =>
      createDoc(
        doc: settingsDto,
      );
}
