import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_firestore_api/enums/turbo_search_term_type.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/data/constants/k_keys.dart';
import 'package:turbo_template/auth/dtos/create_profile_request.dart';
import 'package:turbo_template/auth/dtos/user_profile_dto.dart';
import 'package:turbo_template/firebase/firestore/apis/turbo_api.dart';
import 'package:turbo_template/firebase/firestore/enums/firestore_collection.dart';

class UserProfilesApi extends TurboApi<UserProfileDto> with Loglytics {
  UserProfilesApi()
      : super(
          firestoreCollection: FirestoreCollection.userProfiles,
        );

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static UserProfilesApi get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(UserProfilesApi.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  Future<bool> hasProfile({
    required String userId,
  }) async =>
      (await getByIdWithConverter(id: userId)).isSuccess;

  Future<TurboResponse<UserProfileDto>> findByUserId({required String userId}) =>
      getByIdWithConverter(id: userId);

  Future<TurboResponse<List<UserProfileDto>>> findByUserIds({
    required List<String> userIds,
  }) async {
    final profiles = <UserProfileDto>[];
    for (final userId in userIds) {
      final profileResponse = await findByUserId(userId: userId);
      if (profileResponse.isSuccess) {
        profiles.add(profileResponse.result);
      }
    }
    return TurboResponse.success(result: profiles);
  }

  Future<TurboResponse<List<UserProfileDto>>> search({required String searchTerm}) async =>
      await listBySearchTermWithConverter(
        searchTerm: searchTerm,
        searchField: kKeysSearchTerms,
        searchTermType: TurboSearchTermType.arrayContains,
      );

  Future<bool> profileExists({required String userId}) => docExists(id: userId);

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<TurboResponse> createProfile({
    required String userId,
    required String username,
  }) async =>
      createDoc(
        writeable: CreateProfileRequest(
          profileDto: UserProfileDto.defaultValue(
            userId: userId,
            username: username,
          ),
        ),
        id: userId,
      );
}
