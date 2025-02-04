import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/local_storage/services/local_storage_service.dart';
import 'package:turbo_template/turbo/enums/turbo_theme_mode.dart';


class ThemeService with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static ThemeService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(ThemeService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _localStorageService = LocalStorageService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  late final _themeMode = Informer<TurboThemeMode>(TurboThemeMode.defaultValue);

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  ValueListenable<TurboThemeMode> get themeMode => _themeMode;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void switchTheme() {
    log.info('Switching theme..');
    if (_themeMode.value == TurboThemeMode.light) {
      _localStorageService.updateThemeMode(themeMode: TurboThemeMode.dark);
      _themeMode.update(TurboThemeMode.dark);
    } else {
      _localStorageService.updateThemeMode(themeMode: TurboThemeMode.light);
      _themeMode.update(TurboThemeMode.light);
    }
    log.info('Theme switched!');
  }
}
