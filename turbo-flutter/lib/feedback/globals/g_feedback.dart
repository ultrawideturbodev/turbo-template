import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/turbo/services/notification_service.dart';
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
  String? okText,
  String? title,
  WidgetBuilder? content,
  bool barrierDismissible = true,
  BuildContext? context,
}) =>
    ResponseService.locate.showOkDialog(
      context: context,
      message: message,
      okText: okText,
      title: title,
      content: content,
      barrierDismissible: barrierDismissible,
    );

Future<bool?> gShowOkCancelDialog({
  String? message,
  String? okText,
  String? cancelText,
  String? title,
  WidgetBuilder? content,
  bool barrierDismissible = true,
  BuildContext? context,
}) =>
    ResponseService.locate.showOkCancelDialog(
      context: context,
      message: message,
      okText: okText,
      cancelText: cancelText,
      title: title,
      content: content,
      barrierDismissible: barrierDismissible,
    );
