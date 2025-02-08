import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/state/globals/g_context.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';

class DialogService with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static DialogService Function() get lazyLocate => () => GetIt.I.get<DialogService>();
  static DialogService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(DialogService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  Future<void> showSomethingWentWrongDialog({
    required BuildContext? context,
  }) async =>
      showOkDialog(
        context: context,
        title: gStrings.somethingWentWrong,
        message: gStrings.somethingWentWrongPleaseTryAgainLater,
      );

  Future<void> showUnknownErrorDialog({
    required BuildContext? context,
  }) async =>
      showOkDialog(
        context: context,
        title: gStrings.unknownError,
        message: gStrings.anUnknownErrorOccurredPleaseTryAgainLater,
      );

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<bool?> showOkDialog({
    String? okText,
    required BuildContext? context,
    required String title,
    required String message,
  }) async {
    final pContext = context ?? gContext;
    if (pContext == null) {
      log.warning('Context is null, cannot show toast');
      return null;
    }
    return showDialog<bool?>(
      context: pContext,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          Button.primary(
            onPressed: () => context.pop(true),
            child: Text(okText ?? gStrings.ok),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOkCancelDialog({
    String? cancelText,
    String? okText,
    required BuildContext? context,
    required String title,
    required String message,
  }) async {
    final pContext = context ?? gContext;
    if (pContext == null) {
      log.warning('Context is null, cannot show toast');
      return null;
    }
    return showDialog<bool?>(
      context: pContext,
      builder: (context) => AlertDialog(
        barrierColor: const Color(0x42000000),
        title: Text(title),
        content: Text(message),
        actions: [
          Button.secondary(
            onPressed: () => context.pop(false),
            child: Text(cancelText ?? gStrings.cancel),
          ),
          const Spacer(),
          Button.primary(
            onPressed: () => context.pop(true),
            child: Text(okText ?? gStrings.ok),
          ),
        ],
      ).intrinsic(),
    );
  }
}
