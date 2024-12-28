import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';

import '../enums/supported_theme_mode.dart';
import 'local_storage_service.dart';

class ThemeService with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static ThemeService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(ThemeService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _localStorageService = LocalStorageService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  late final _themeMode = Informer<SupportedThemeMode>(SupportedThemeMode.light);

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  ValueListenable<SupportedThemeMode> get themeMode => _themeMode;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void switchTheme() {
    log.info('Switching theme..');
    if (_themeMode.value == SupportedThemeMode.light) {
      _localStorageService.updateThemeMode(themeMode: SupportedThemeMode.dark);
      _themeMode.update(SupportedThemeMode.dark);
    } else {
      _localStorageService.updateThemeMode(themeMode: SupportedThemeMode.light);
      _themeMode.update(SupportedThemeMode.light);
    }
    log.info('Theme switched!');
  }
}
