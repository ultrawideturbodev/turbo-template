import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

enum TThemeMode {
  dark,
  light,
  ;

  SystemUiOverlayStyle get systemUiOverlayStyle {
    switch (this) {
      case TThemeMode.light:
        return SystemUiOverlayStyle.dark;
      case TThemeMode.dark:
        return SystemUiOverlayStyle.light;
    }
  }

  ThemeMode get themeMode {
    switch (this) {
      case TThemeMode.light:
        return ThemeMode.light;
      case TThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  static const TThemeMode defaultValue = TThemeMode.light;
}
