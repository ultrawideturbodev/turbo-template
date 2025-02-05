import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/enums/turbo_theme_mode.dart';

enum TurboTheme {
  blue,
  violet,
  zinc,
  ;

  static const defaultValue = TurboTheme.zinc;

  ThemeData themeData({required TurboThemeMode themeMode}) {
    switch (this) {
      case TurboTheme.blue:
        switch (themeMode) {
          case TurboThemeMode.dark:
            return ThemeData(
              colorScheme: ColorSchemes.darkBlue(),
              radius: 0.8,
              surfaceOpacity: 0.5,
              surfaceBlur: 5,
            );
          case TurboThemeMode.light:
            return ThemeData(
              colorScheme: ColorSchemes.lightBlue(),
              radius: 0.8,
              surfaceOpacity: 0.5,
              surfaceBlur: 5,
            );
        }
      case TurboTheme.violet:
        switch (themeMode) {
          case TurboThemeMode.dark:
            return ThemeData(
              colorScheme: ColorSchemes.darkViolet(),
              radius: 0.8,
              surfaceOpacity: 0.5,
              surfaceBlur: 5,
            );
          case TurboThemeMode.light:
            return ThemeData(
              colorScheme: ColorSchemes.lightViolet(),
              radius: 0.8,
              surfaceOpacity: 0.5,
              surfaceBlur: 5,
            );
        }
      case TurboTheme.zinc:
        switch (themeMode) {
          case TurboThemeMode.dark:
            return ThemeData(
              colorScheme: ColorSchemes.darkZinc(),
              radius: 0.8,
              surfaceOpacity: 0.5,
              surfaceBlur: 5,
            );
          case TurboThemeMode.light:
            return ThemeData(
              colorScheme: ColorSchemes.lightZinc(),
              radius: 0.8,
              surfaceOpacity: 0.5,
              surfaceBlur: 5,
            );
        }
    }
  }
}
