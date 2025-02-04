import 'package:feedback_response/feedback_response.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../services/feedback_service.dart';
import '../typedefs/string_builder.dart';

Future<bool?> gShowOkCancelDialog({
  FeedbackLevel feedbackLevel = FeedbackLevel.info,
  StringBuilder? message,
  StringBuilder? okText,
  StringBuilder? cancelText,
  StringBuilder? title,
  WidgetBuilder? content,
  bool barrierDismissible = true,
  BuildContext? context,
}) =>
    FeedbackService.locate.showOkCancelDialog(
      context: context,
      title: title,
      content: content,
      message: message,
      okText: okText,
      cancelText: cancelText,
      feedbackLevel: feedbackLevel,
      barrierDismissible: barrierDismissible,
    );
