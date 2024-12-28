import 'package:feedback_response/feedback_response.dart';
import 'package:flutter/material.dart';

import '../services/feedback_service.dart';

extension FeedbackResponseExtension on FeedbackResponse {
  FeedbackResponse<T> asFeedbackTypeNone<T>() => copyWith(feedbackType: FeedbackType.none);
  FeedbackResponse<T> asSuccess<T>({
    String? title,
    String? message,
    FeedbackType feedbackType = FeedbackType.notification,
    T? result,
  }) =>
      copyWith(
        feedbackType: feedbackType,
        feedbackLevel: FeedbackLevel.success,
        title: title,
        message: message,
        result: result,
      );

  FeedbackResponse<T> asError<T>({
    String? title,
    String? message,
    FeedbackType feedbackType = FeedbackType.dialog,
    T? result,
  }) =>
      copyWith(
        feedbackType: feedbackType,
        feedbackLevel: FeedbackLevel.error,
        title: title,
        message: message,
        result: result,
      );

  void show({
    required BuildContext? context,
  }) =>
      FeedbackService.locate.showResponse(
        response: this,
        context: context,
      );

  void showIf({
    required BuildContext? context,
    String? ifSuccessTitle,
    String? ifSuccessMessage,
    FeedbackType ifSuccessFeedbackType = FeedbackType.notification,
    required String? ifErrorTitle,
    String? ifErrorMessage,
    FeedbackType ifErrorFeedbackType = FeedbackType.dialog,
  }) =>
      FeedbackService.locate.showResponse(
        response: copyWith(
          ifSuccessTitle: ifSuccessTitle,
          ifErrorTitle: ifErrorTitle,
          ifSuccessMessage: ifSuccessMessage,
          ifErrorMessage: ifErrorMessage,
          feedbackType: isSuccess ? ifSuccessFeedbackType : ifErrorFeedbackType,
        ),
        context: context,
      );
}
