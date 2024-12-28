import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_response/feedback_response.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';

import '../../../core/abstracts/tu_api.dart';
import '../../../core/constants/k_keys.dart';
import '../../../core/enums/firestore_collection.dart';
import '../../../core/exceptions/unexpected_result_exception.dart';
import '../dtos/username_dto.dart';
import '../requests/create_username_request.dart';

class UsernamesApi extends TuApi<UsernameDto> with Loglytics {
  UsernamesApi()
      : super(
          firestoreCollection: FirestoreCollection.usernames,
        );

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static UsernamesApi get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(UsernamesApi.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  Future<String?> fetchUsername({required String userId}) async {
    try {
      final response = await findByQueryWithConverter(
        collectionReferenceQuery: (collectionReference) =>
            collectionReference.where(kKeysUserId, isEqualTo: userId),
        whereDescription: '$kKeysUserId isEqual to $userId',
      );
      final result = response.result;
      if ((result?.length ?? 0) > 1) {
        log.error(
          'Users can only have 1 username',
          error: UnexpectedResultException(
            result: result,
            reason: 'User can only have 1 username, ids: ${result?.map((e) => e.id).toList()}',
          ),
          stackTrace: StackTrace.current,
        );
        await deleteOldUsernames(userId: userId);
        return null;
      }
      return result?.firstOrNull?.id;
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while checking if user has username',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<bool> usernameIsAvailable({
    required String username,
    required String userId,
  }) async {
    try {
      final usernameIsAvailable = !(await docExists(id: username));
      if (!usernameIsAvailable) {
        return await isMe(
          username: username,
          userId: userId,
        );
      }
      return usernameIsAvailable;
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while checking if username is available',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<bool> isMe({required String username, required String userId}) async =>
      (await findByIdWithConverter(id: username)).result?.userId == userId;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<FeedbackResponse> deleteOldUsernames({
    required String userId,
    Transaction? transaction,
  }) async {
    try {
      final response = await findByQueryWithConverter(
        collectionReferenceQuery: (collectionReference) =>
            collectionReference.where(kKeysUserId, isEqualTo: userId),
        whereDescription: '$kKeysUserId isEqual to $userId',
      );
      if (response.isSuccess) {
        for (final oldUsername in response.result!) {
          if (transaction == null) {
            await deleteDoc(id: oldUsername.id);
          } else {
            transaction.delete(oldUsername.documentReference);
          }
        }
      }
      return response;
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while deleting old usernames',
        error: error,
        stackTrace: stackTrace,
      );
      return FeedbackResponse.errorNone();
    }
  }

  Future<FeedbackResponse> createUsername({
    required String username,
    required String userId,
    required Transaction transaction,
  }) async =>
      createDoc(
        id: username,
        transaction: transaction,
        writeable: CreateUsernameRequest(
          userId: userId,
        ),
      );
}
