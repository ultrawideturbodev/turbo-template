import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shad;
import 'package:turbo_template/ui/config/turbo_button_config.dart';
import 'package:turbo_template/state/globals/g_context.dart';
import 'package:turbo_template/localizations/globals/g_strings.dart';

class ToastService with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static ToastService Function() get lazyLocate => () => GetIt.I.get();
  static ToastService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(
        ToastService.new,
      );

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  Future<void> showSomethingWentWrongToast({
    required shad.BuildContext context,
  }) async =>
      showToast(
        context: context,
        title: gStrings.somethingWentWrong,
        subtitle: gStrings.somethingWentWrongPleaseTryAgainLater,
      );

  Future<void> showUnknownErrorToast({
    required shad.BuildContext context,
  }) async =>
      showToast(
        context: context,
        title: gStrings.unknownError,
        subtitle: gStrings.anUnknownErrorOccurredPleaseTryAgainLater,
      );

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void showToast({
    required shad.BuildContext? context,
    required String title,
    String? subtitle,
    TButtonTextConfig? config,
  }) {
    final pContext = context ?? gContext;
    if (pContext == null) {
      log.warning('Context is null, cannot show toast');
      return;
    }
    shad.showToast(
      context: pContext,
      showDuration: Duration(),
      location: shad.ToastLocation.topLeft,
      builder: (context, overlay) => shad.SurfaceCard(
        child: shad.Basic(
          title: shad.Text(title),
          subtitle: subtitle != null ? shad.Text(subtitle) : null,
          trailing: config != null
              ? shad.Button.primary(
                  onPressed: config.onPressed,
                  child: shad.Text(config.text),
                )
              : null,
          trailingAlignment: shad.Alignment.center,
        ),
      ),
    );
  }
}
