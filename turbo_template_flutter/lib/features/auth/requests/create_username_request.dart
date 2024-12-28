import 'package:cloud_firestore_api/abstracts/writeable.dart';
import 'package:feedback_response/feedback_response.dart';

import '../../../core/constants/k_keys.dart';

class CreateUsernameRequest extends Writeable {
  CreateUsernameRequest({
    required this.userId,
  });

  final String userId;

  @override
  FeedbackResponse isValidResponse() => FeedbackResponse.successNone();

  @override
  Map<String, dynamic> toJson() => {
        kKeysUserId: userId,
      };
}
