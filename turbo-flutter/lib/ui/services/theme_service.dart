import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/local_storage/services/local_storage_service.dart';
import 'package:turbo_template/ui/enums/t_device_type.dart';
import 'package:turbo_template/ui/enums/t_theme.dart';
import 'package:turbo_template/ui/enums/t_theme_mode.dart';

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

  late final _themeMode = Informer<TThemeMode>(TThemeMode.defaultValue);
  late final _theme = Informer<TTheme>(TTheme.defaultValue);

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  ThemeData darkTheme({required TDeviceType deviceType}) => _theme.value.themeData(
        themeMode: TThemeMode.dark,
        deviceType: deviceType,
      );
  ThemeData lightTheme({required TDeviceType deviceType}) => _theme.value.themeData(
        themeMode: TThemeMode.light,
        deviceType: deviceType,
      );
  TTheme get theme => _theme.value;
  TThemeMode get themeMode => _themeMode.value;
  ValueListenable<TTheme> get themeListenable => _theme;
  ValueListenable<TThemeMode> get themeModeListenable => _themeMode;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void updateTheme({required TTheme theme}) {
    log.info('Updating theme..');
    _localStorageService.updateTheme(theme: theme);
    _theme.update(theme);
    log.info('Theme update!');
  }

  Future<void> switchThemeMode() async {
    log.info('Switching theme mode..');
    if (_themeMode.value == TThemeMode.light) {
      await _localStorageService.updateThemeMode(themeMode: TThemeMode.dark);
      _themeMode.update(TThemeMode.dark);
    } else {
      await _localStorageService.updateThemeMode(themeMode: TThemeMode.light);
      _themeMode.update(TThemeMode.light);
    }
    log.info('Theme mode switched!');
  }
}
