import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/routing/services/base_router_service.dart';

class SheetService with Loglytics {
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final BaseRouterService _baseRouter = BaseRouterService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<T?> showCustomBottomSheet<T>({
    required BuildContext context,
    required Widget customBottomSheet,
    OverlayPosition position = OverlayPosition.bottom,
  }) async {
    try {
      return openSheet<T>(
        context: context,
        position: position,
        builder: (context) => customBottomSheet,
      );
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while showing custom bottom sheet',
        error: error,
        stackTrace: stackTrace,
      );
    }
    return null;
  }

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static SheetService get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(() => SheetService());
}
