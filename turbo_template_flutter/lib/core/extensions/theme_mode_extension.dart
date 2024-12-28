import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../enums/supported_theme_mode.dart';

extension SupportedThemeModeExtension on SupportedThemeMode {
  SystemUiOverlayStyle systemUiOverlayStyle(BuildContext context) {
    switch (this) {
      case SupportedThemeMode.light:
        return SystemUiOverlayStyle.dark;
      case SupportedThemeMode.dark:
        return SystemUiOverlayStyle.light;
    }
  }
}
