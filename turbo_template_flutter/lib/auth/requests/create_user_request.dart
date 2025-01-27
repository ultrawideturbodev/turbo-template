
import 'package:turbo_firestore_api/abstracts/turbo_writeable.dart';
import 'package:turbo_template/auth/dtos/user_dto.dart';

class CreateUserRequest extends TurboWriteable {
  CreateUserRequest({
    required this.userDto,
  });

  final UserDto userDto;

  @override
  Map<String, dynamic> toJson() => userDto.toJson();
}
