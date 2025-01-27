import 'package:turbo_firestore_api/abstracts/turbo_writeable.dart';

import 'user_profile_dto.dart';

class CreateProfileRequest extends TurboWriteable {
  CreateProfileRequest({
    required this.profileDto,
  });

  final UserProfileDto profileDto;

  @override
  Map<String, dynamic> toJson() => profileDto.toJson();
}
