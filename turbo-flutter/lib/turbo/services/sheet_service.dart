import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';

import '../extensions/context_extension.dart';
import '../routing/base_router.dart';

class SheetService with Loglytics {
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final BaseRouter _baseRouter = BaseRouter.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<T?> showCustomBottomSheet<T>({
    BuildContext? context,
    required Widget customBottomSheet,
  }) async {
    try {
      final localContext = context ?? _baseRouter.context;
      return showModalBottomSheet<T>(
        context: localContext,
        backgroundColor: localContext.t.colors.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32),
          ),
        ),
        useSafeArea: true,
        elevation: 0,
        isScrollControlled: true,
        barrierColor: Colors.black87,
        isDismissible: true,
        constraints: const BoxConstraints(maxHeight: double.infinity),
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
