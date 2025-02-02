import 'package:feedback_response/feedback_response.dart';
import 'package:flutter/material.dart';

import '../services/feedback_service.dart';
import '../typedefs/string_builder.dart';

Future<bool?> gShowOkCancelDialog({
  FeedbackLevel feedbackLevel = FeedbackLevel.info,
  StringBuilder? message,
  StringBuilder? okButtonText,
  StringBuilder? cancelButtonText,
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
      okButtonText: okButtonText,
      cancelButtonText: cancelButtonText,
      feedbackLevel: feedbackLevel,
      barrierDismissible: barrierDismissible,
    );
