import 'dart:async';

import 'package:feedback_response/feedback_response.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';

import '../constants/k_sizes.dart';
import '../exceptions/unexpected_null_exception.dart';
import '../exceptions/unexpected_state_exception.dart';
import '../globals/g_strings.dart';
import '../routing/base_router.dart';
import '../typedefs/string_builder.dart';
import '../widgets/custom_bottom_sheet.dart';
import 'notification_service.dart';
import 'sheet_service.dart';

class FeedbackService with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static FeedbackService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(FeedbackService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  DisposableBuildContext? _innerDisposableContext;

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  BuildContext? get innerRouterContext => _innerDisposableContext?.context;

  BuildContext? get _tryFetchNavigatorContext {
    log.info('Try fetching navigator context..');
    final context = BaseRouter.rootNavigatorKey.currentContext;
    if (context == null) log.warning('Navigator context was null, not showing feedback!');
    return context;
  }

  // 🏗 HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void showOkSomethingWentWrongDialog({
    BuildContext? context,
  }) {
    try {
      showOkDialog(
        context: context,
        title: (strings) => strings.somethingWentWrong,
        message: (strings) => strings.somethingWentWrongPleaseTryAgainLater,
        feedbackLevel: FeedbackLevel.error,
      );
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while trying to show something went wrong dialog',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void updateInnerContext({
    required DisposableBuildContext disposableBuildContext,
  }) {
    _innerDisposableContext = disposableBuildContext;
    log.info('Updated inner context');
  }

  void tryShowFutureResponse({
    required Future<FeedbackResponse> futureResponse,
    BuildContext? context,
  }) =>
      futureResponse.then(
        (response) => showResponse(
          response: response,
          context: context,
        ),
      );
  Future<void> showResponse({
    required FeedbackResponse response,
    BuildContext? context,
  }) async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        try {
          final localContext = _localContextWithErrorHandling(context);
          final title = response.title;
          final message = response.message;
          if (title == null) {
            log.warning('Title was null. Assuming this is intended behaviour, returning!');
            return;
          }
          switch (response.feedbackType) {
            case FeedbackType.none:
              break;
            case FeedbackType.dialog:
              if (message == null) {
                log.warning('Message was null. Assuming this is intended behaviour, returning!');
                return;
              }
              await showOkDialog(
                context: localContext,
                title: (_) => title,
                message: (_) => message,
                feedbackLevel: response.feedbackLevel,
              );
              break;
            case FeedbackType.snackbar:
              if (message == null) {
                log.warning('Message was null. Assuming this is intended behaviour, returning!');
                return;
              }
              await showSnackbar(
                title: title,
                message: message,
                feedbackLevel: response.feedbackLevel,
              );
              break;
            case FeedbackType.bottomSheet:
              await SheetService.locate.showCustomBottomSheet(
                context: context,
                customBottomSheet: CustomBottomSheet(
                  feedbackLevel: response.feedbackLevel,
                  title: title,
                  message: message,
                ),
              );
              break;
            case FeedbackType.notification:
              await NotificationService.locate.showNotification(
                context: localContext,
                title: title,
                message: message,
                feedbackLevel: response.feedbackLevel,
              );
              break;
          }
        } catch (error) {
          log.error('Something went wrong showing a service response notification', error: error);
          log.error('FeedbackResponse: $response');
        }
      },
    );
  }

  Future<SnackBarClosedReason?> showSnackbar({
    required String title,
    required String message,
    FeedbackLevel feedbackLevel = FeedbackLevel.info,
  }) async {
// TODO(codaveto): Implement | 18/04/2024
    throw UnimplementedError();
  }

  Future<bool?> showOkCancelDialog({
    FeedbackLevel feedbackLevel = FeedbackLevel.info,
    StringBuilder? message,
    StringBuilder? okButtonText,
    StringBuilder? cancelButtonText,
    StringBuilder? title,
    WidgetBuilder? content,
    bool barrierDismissible = true,
    BuildContext? context,
  }) async {
    final localContext = _localContextWithErrorHandling(context);
    return showDialog<bool?>(
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      context: localContext,
      useSafeArea: false,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: GestureDetector(
                onTap: () {}, // Prevents closing when clicking inside dialog
                child: const Padding(
                  padding: EdgeInsets.all(kSizesAppPadding),
                  child: Text('wtf'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showOkDialog({
    FeedbackLevel feedbackLevel = FeedbackLevel.info,
    StringBuilder? message,
    StringBuilder? okButtonText,
    StringBuilder? title,
    WidgetBuilder? content,
    bool barrierDismissible = true,
    BuildContext? context,
  }) async {
    final localContext = _localContextWithErrorHandling(context);
    return showDialog<bool?>(
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      context: localContext,
      useSafeArea: false,
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: GestureDetector(
              onTap: () {}, // Prevents closing when clicking inside dialog
              child: const Padding(
                padding: EdgeInsets.all(kSizesAppPadding),
                child: Text('wtf'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showUnknownError({
    BuildContext? context,
  }) async {
    try {
      await showOkDialog(
        context: context,
        title: (strings) => gStrings.unknownError,
        message: (strings) => gStrings.anUnknownErrorOccurredPleaseTryAgainLater,
        feedbackLevel: FeedbackLevel.error,
      );
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while trying to show something went wrong dialog',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  BuildContext _localContextWithErrorHandling(BuildContext? context) {
    final localContext = (context?.mounted ?? false) ? context : _tryFetchNavigatorContext;
    if (localContext == null) {
      throw const UnexpectedNullException(
        reason: 'localContext should not be null when showing something went wrong dialog',
      );
    }
    if (!localContext.mounted) {
      throw const UnexpectedStateException(
        reason: 'localContext should be mounted when showing something went wrong dialog',
      );
    }
    return localContext;
  }
}
