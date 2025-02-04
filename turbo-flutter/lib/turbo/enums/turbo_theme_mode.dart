import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

enum TurboThemeMode {
  dark,
  light,
  ;

  SystemUiOverlayStyle get systemUiOverlayStyle {
    switch (this) {
      case TurboThemeMode.light:
        return SystemUiOverlayStyle.dark;
      case TurboThemeMode.dark:
        return SystemUiOverlayStyle.light;
    }
  }

  ThemeMode get themeMode {
    switch (this) {
      case TurboThemeMode.light:
        return ThemeMode.light;
      case TurboThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  static const TurboThemeMode defaultValue = TurboThemeMode.light;
}
