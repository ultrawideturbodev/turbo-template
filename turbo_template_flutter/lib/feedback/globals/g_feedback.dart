import 'package:flutter/material.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/core/services/notification_service.dart';
import 'package:turbo_template/feedback/services/response_service.dart';

void gShowNotification({
  BuildContext? context,
  required String title,
}) =>
    NotificationService.locate.showNotification(
      context: context,
      title: title,
      message: null,
    );

void gShowResponse({
  required TurboResponse response,
  BuildContext? context,
}) =>
    ResponseService.locate.showResponse(
      context: context,
      response: response,
    );
// TODO(GPT-AGENT): replace all string builders with regular String
void gTryShowFutureResponse({
  required Future<TurboResponse> futureResponse,
  BuildContext? context,
}) =>
    ResponseService.locate.tryShowFutureResponse(
      context: context,
      futureResponse: futureResponse,
    );

void gShowOkDialog({
  String? message,
  String? okButtonText,
  String? title,
  WidgetBuilder? content,
  bool barrierDismissible = true,
  BuildContext? context,
}) =>
    DialogService.locate.showOkDialog(
      context: context,
      message: message,
      okButtonText: okButtonText,
      title: title,
      content: content,
      barrierDismissible: barrierDismissible,
    );

Future<bool?> gShowOkCancelDialog({
  String? message,
  String? okButtonText,
  String? cancelButtonText,
  String? title,
  WidgetBuilder? content,
  bool barrierDismissible = true,
  BuildContext? context,
}) =>
    DialogService.locate.showOkCancelDialog(
      context: context,
      message: message,
      okButtonText: okButtonText,
      cancelButtonText: cancelButtonText,
      title: title,
      content: content,
      barrierDismissible: barrierDismissible,
    );
