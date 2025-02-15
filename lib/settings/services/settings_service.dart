import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:turbo_firestore_api/turbo_firestore_api.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/data/constants/k_keys.dart';
import 'package:turbo_template/state/typedefs/lazy_locator_def.dart';
import 'package:turbo_template/settings/apis/settings_api.dart';
import 'package:turbo_template/settings/dtos/settings_dto.dart';

class SettingsService extends TurboDocumentService<SettingsDto, SettingsApi> {
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
  LazyLocatorDef<SettingsDto> get initialValueLocator => () => SettingsDto.create(
        vars: turboVars(),
      );

  @override
  Stream<SettingsDto?> Function(User user) get stream => (user) => api
      .streamByQueryWithConverter(
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
  bool get hasSettings => doc.value != null;
  DateTime? get skippedVerifyEmailDate => doc.value?.skippedVerifyEmailDate;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<TurboResponse> updateSkippedVerifyEmailDate({
    required DateTime skippedVerifyEmailDate,
  }) =>
      updateDoc(
        id: id!,
        doc: (current, vars) => current!.copyWith(
          skippedVerifyEmailDate: skippedVerifyEmailDate,
        ),
        remoteUpdateRequestBuilder: (doc) => doc.asUpdateSkippedVerifyEmailDateRequest,
      );

  Future<TurboResponse> createSettings({
    required CreateDocDef<SettingsDto> doc,
  }) async =>
      createDoc(
        doc: doc,
      );
}
