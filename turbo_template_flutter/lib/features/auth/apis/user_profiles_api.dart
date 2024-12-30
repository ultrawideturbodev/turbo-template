import 'package:cloud_firestore_api/data/enums/search_term_type.dart';
import 'package:feedback_response/feedback_response.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/core/abstracts/turbo_api.dart';

import '../../../core/constants/k_keys.dart';
import '../../../core/enums/firestore_collection.dart';
import '../dtos/create_profile_request.dart';
import '../dtos/user_profile_dto.dart';

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
      (await findByIdWithConverter(id: userId)).isSuccess;

  Future<FeedbackResponse<UserProfileDto>> findByUserId({required String userId}) =>
      findByIdWithConverter(id: userId);

  Future<FeedbackResponse<List<UserProfileDto>>> findByUserIds({
    required List<String> userIds,
  }) async {
    final profiles = <UserProfileDto>[];
    for (final userId in userIds) {
      final profileResponse = await findByUserId(userId: userId);
      if (profileResponse.isSuccess) {
        profiles.add(profileResponse.result!);
      }
    }
    return FeedbackResponse.successNone(result: profiles);
  }

  Future<FeedbackResponse<List<UserProfileDto>>> search({required String searchTerm}) async =>
      await findBySearchTermWithConverter(
        searchTerm: searchTerm,
        searchField: kKeysSearchTerms,
        searchTermType: SearchTermType.arrayContains,
      );

  Future<bool> profileExists({required String userId}) => docExists(id: userId);

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<FeedbackResponse> createProfile({
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
