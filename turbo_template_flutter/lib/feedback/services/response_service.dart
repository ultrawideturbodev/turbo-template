import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/core/constants/k_sizes.dart';
import 'package:turbo_template/core/routing/base_router.dart';
import 'package:turbo_template/core/widgets/tu_ok_dialog.dart';

class ResponseService with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static ResponseService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(ResponseService.new);

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
    required Future<TurboResponse> futureResponse,
    BuildContext? context,
  }) =>
      futureResponse.then(
            (response) => showResponse(
          response: response,
          context: context,
        ),
      );
  Future<void> showResponse({
    required TurboResponse response,
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
          await NotificationService.locate.showNotification(
            context: localContext,
            title: title,
            message: message,
          );
        } catch (error) {
          log.error('Something went wrong showing a service response notification', error: error);
          log.error('TurboResponse: $response');
        }
      },
    );
  }

  Future<bool?> showOkCancelDialog({
    StringBuilder? message,
    StringBuilder? okButtonText,
    StringBuilder? cancelButtonText,
    StringBuilder? title,
    WidgetBuilder? content,
    bool barrierDismissible = true,
    BuildContext? context,
    RmyButtonType okButtonType = RmyButtonType.okButtonDefault,
    RmyButtonType cancelButtonType = RmyButtonType.cancelButtonDefault,
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
                child: Padding(
                  padding: const EdgeInsets.all(kSizesAppPadding),
                  child: TuOkCancelDialog(
                    cancelButtonType: cancelButtonType,
                    okButtonType: okButtonType,
                    cancelButtonText: cancelButtonText?.call(gStrings) ?? gStrings.cancel,
                    content: content,
                    message: message?.call(gStrings),
                    okButtonText: okButtonText?.call(gStrings) ?? gStrings.ok,
                    title: title?.call(gStrings),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showOkDialog({
    String? message,
    String? okButtonText,
    String? title,
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
              child: Padding(
                padding: const EdgeInsets.all(kSizesAppPadding),
                child: TuOkDialog(
                  content: content,
                  message: message?.call(gStrings),
                  okButtonText: okButtonText?.call(gStrings) ?? gStrings.ok,
                  title: title?.call(gStrings),
                ),
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
