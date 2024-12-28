import 'package:cloud_firestore_api/abstracts/writeable.dart';
import 'package:feedback_response/feedback_response.dart';

import 'user_profile_dto.dart';

class CreateProfileRequest extends Writeable {
  CreateProfileRequest({
    required this.profileDto,
  });

  final UserProfileDto profileDto;

  @override
  FeedbackResponse isValidResponse() => FeedbackResponse.successNone();

  @override
  Map<String, dynamic> toJson() => profileDto.toJson();
}
