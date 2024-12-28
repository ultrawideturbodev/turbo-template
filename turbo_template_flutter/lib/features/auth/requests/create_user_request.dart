import 'package:cloud_firestore_api/abstracts/writeable.dart';

import '../dtos/user_dto.dart';

class CreateUserRequest extends Writeable {
  CreateUserRequest({
    required this.userDto,
  });

  final UserDto userDto;

  @override
  Map<String, dynamic> toJson() => userDto.toJson();
}
