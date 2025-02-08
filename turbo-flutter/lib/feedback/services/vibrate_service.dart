import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:loglytics/loglytics.dart';

class VibrateService with Loglytics {
  VibrateService() {
    initialise();
  }

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static VibrateService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(VibrateService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  Future<void> initialise() async {
    try {
      _canVibrate = !kIsWeb && await Haptics.canVibrate();
    } catch (error, stackTrace) {
      log.error(
        '$error caught while trying to initialise the VibrateService.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  bool? _canVibrate;

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<void> vibrate(HapticsType type) async {
    try {
      if (_canVibrate == false) return;
      await Haptics.vibrate(type);
    } catch (error, _) {
      log.warning(
        '$error caught while trying to vibrate.',
      );
    }
  }
}
