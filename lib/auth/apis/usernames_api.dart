import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/data/constants/k_keys.dart';
import 'package:turbo_template/state/exceptions/unexpected_result_exception.dart';
import 'package:turbo_template/auth/dtos/username_dto.dart';
import 'package:turbo_template/auth/requests/create_username_request.dart';
import 'package:turbo_template/firebase/firestore/apis/turbo_api.dart';
import 'package:turbo_template/firebase/firestore/enums/firestore_collection.dart';

class UsernamesApi extends TurboApi<UsernameDto> with Loglytics {
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
      final response = await listByQueryWithConverter(
        collectionReferenceQuery: (collectionReference) =>
            collectionReference.where(kKeysUserId, isEqualTo: userId),
        whereDescription: '$kKeysUserId isEqual to $userId',
      );

      return await response.whenSuccess<String?>(
        (response) async {
          final result = response.result;
          if ((result.length) > 1) {
            log.error(
              'Users can only have 1 username',
              error: UnexpectedResultException(
                result: result,
                reason: 'User can only have 1 username, ids: ${result.map((e) => e.id).toList()}',
              ),
              stackTrace: StackTrace.current,
            );
            await deleteOldUsernames(userId: userId);
            return null;
          }
          return result.firstOrNull?.id;
        },
      );
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
      (await getByIdWithConverter(id: username)).when(
        success: (response) => response.result.userId == userId,
        fail: (response) => false,
      );

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<TurboResponse> deleteOldUsernames({
    required String userId,
    Transaction? transaction,
  }) async {
    try {
      final response = await listByQueryWithConverter(
        collectionReferenceQuery: (collectionReference) =>
            collectionReference.where(kKeysUserId, isEqualTo: userId),
        whereDescription: '$kKeysUserId isEqual to $userId',
      );

      await response.whenSuccess(
        (response) async {
          for (final oldUsername in response.result) {
            if (transaction == null) {
              await deleteDoc(id: oldUsername.id);
            } else {
              final response = await deleteDoc(id: oldUsername.id, transaction: transaction);
              response.throwWhenFail();
            }
          }
        },
      );
      return response;
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while deleting old usernames',
        error: error,
        stackTrace: stackTrace,
      );
      return TurboResponse.fail(error: error);
    }
  }

  Future<TurboResponse> createUsername({
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
