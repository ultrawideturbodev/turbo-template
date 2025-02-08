import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/local_storage/services/local_storage_service.dart';
import 'package:turbo_template/ui/enums/turbo_theme.dart';
import 'package:turbo_template/ui/enums/turbo_theme_mode.dart';

// TODO(brian): Implement default system theme mode | 05/02/2025
class ThemeService with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static ThemeService Function() get lazyLocate => () => GetIt.I.get();
  static ThemeService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(
        ThemeService.new,
      );

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _localStorageService = LocalStorageService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  late final _themeMode = Informer<TurboThemeMode>(TurboThemeMode.defaultValue);
  late final _theme = Informer<TurboTheme>(TurboTheme.defaultValue);

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  ThemeData get darkTheme => _theme.value.themeData(themeMode: TurboThemeMode.dark);
  ThemeData get lightTheme => _theme.value.themeData(themeMode: TurboThemeMode.light);
  TurboTheme get theme => _theme.value;
  TurboThemeMode get themeMode => _themeMode.value;
  ValueListenable<TurboTheme> get themeListenable => _theme;
  ValueListenable<TurboThemeMode> get themeModeListenable => _themeMode;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void updateTheme({required TurboTheme theme}) {
    log.info('Updating theme..');
    _localStorageService.updateTheme(theme: theme);
    _theme.update(theme);
    log.info('Theme update!');
  }

  Future<void> switchThemeMode() async {
    log.info('Switching theme mode..');
    if (_themeMode.value == TurboThemeMode.light) {
      await _localStorageService.updateThemeMode(themeMode: TurboThemeMode.dark);
      _themeMode.update(TurboThemeMode.dark);
    } else {
      await _localStorageService.updateThemeMode(themeMode: TurboThemeMode.light);
      _themeMode.update(TurboThemeMode.light);
    }
    log.info('Theme mode switched!');
  }
}
