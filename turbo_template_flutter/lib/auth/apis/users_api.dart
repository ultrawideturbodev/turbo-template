import 'package:get_it/get_it.dart';
import 'package:turbo_template/auth/dtos/user_dto.dart';
import 'package:turbo_template/firestore/apis/turbo_api.dart';
import 'package:turbo_template/firestore/enums/firestore_collection.dart';

class UsersApi extends TurboApi<UserDto> {
  UsersApi()
      : super(
          firestoreCollection: FirestoreCollection.users,
        );

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static UsersApi get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(UsersApi.new);

// 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
// 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
// 👂 LISTENERS ----------------------------------------------------------------------------- \\
// ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
// 🎩 STATE --------------------------------------------------------------------------------- \\
// 🛠 UTIL ---------------------------------------------------------------------------------- \\
// 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  Future<bool> userExists({required String userId}) => docExists(id: userId);

// 🏗️ HELPERS ------------------------------------------------------------------------------- \\
// 🪄 MUTATORS ------------------------------------------------------------------------------ \\
}
