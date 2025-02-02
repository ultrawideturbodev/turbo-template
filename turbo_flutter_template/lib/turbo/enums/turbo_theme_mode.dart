import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TurboThemeMode {
  dark,
  light,
  ;

  SystemUiOverlayStyle systemUiOverlayStyle(BuildContext context) {
    switch (this) {
      case TurboThemeMode.light:
        return SystemUiOverlayStyle.dark;
      case TurboThemeMode.dark:
        return SystemUiOverlayStyle.light;
    }
  }

  static const TurboThemeMode defaultValue = TurboThemeMode.dark;

  ThemeMode get toMaterialThemeMode {
    switch (this) {
      case TurboThemeMode.dark:
        return ThemeMode.dark;
      case TurboThemeMode.light:
        return ThemeMode.light;
    }
  }
}
