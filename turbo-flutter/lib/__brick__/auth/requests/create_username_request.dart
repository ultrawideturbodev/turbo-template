import 'package:turbo_firestore_api/abstracts/turbo_writeable.dart';
import 'package:{{packageName.snakeCase()}}/data/constants/k_keys.dart';

class CreateUsernameRequest extends TurboWriteable {
  CreateUsernameRequest({
    required this.userId,
  });

  final String userId;

  @override
  Map<String, dynamic> toJson() => {
        kKeysUserId: userId,
      };
}
