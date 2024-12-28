import 'package:flutter/material.dart';

enum SupportedThemeMode {
  dark,
  light,
  ;

  static const defaultValue = SupportedThemeMode.light;

  ThemeMode get toThemeMode {
    switch (this) {
      case SupportedThemeMode.dark:
        return ThemeMode.dark;
      case SupportedThemeMode.light:
        return ThemeMode.light;
    }
  }
}
