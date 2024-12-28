import 'package:feedback_response/feedback_response.dart';
import 'package:get_it/get_it.dart';

import '../../../core/abstracts/tu_api.dart';
import '../../../core/enums/firestore_collection.dart';
import '../dtos/user_dto.dart';
import '../requests/create_user_request.dart';

class UsersApi extends TuApi<UserDto> {
  UsersApi()
      : super(
          firestoreCollection: FirestoreCollection.users,
        );

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  Future<bool> userExists({required String userId}) => docExists(id: userId);

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<FeedbackResponse> createUser({
    required String userId,
    required String email,
    required DateTime? acceptedPrivacyAndTermsAt,
    required DateTime trialEnd,
  }) async =>
      createDoc(
        writeable: CreateUserRequest(
          userDto: UserDto.defaultValue(
            acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt,
            userId: userId,
            email: email,
          ),
        ),
        id: userId,
      );

  static UsersApi get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(UsersApi.new);
}
