import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/exceptions/unexpected_null_exception.dart';
import 'package:turbo_template/turbo/exceptions/unexpected_state_exception.dart';
import 'package:turbo_template/turbo/globals/g_strings.dart';
import 'package:turbo_template/turbo/routing/base_router.dart';
import 'package:turbo_template/turbo/services/notification_service.dart';

class ResponseService with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static ResponseService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(ResponseService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

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
        title: gStrings.somethingWentWrong,
        message: gStrings.somethingWentWrongPleaseTryAgainLater,
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
    String? message,
    String? okButtonText,
    String? cancelButtonText,
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
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
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
        title: gStrings.unknownError,
        message: gStrings.anUnknownErrorOccurredPleaseTryAgainLater,
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
