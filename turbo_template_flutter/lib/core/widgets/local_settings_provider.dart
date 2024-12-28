import 'package:flutter/material.dart';

import '../enums/supported_language.dart';
import '../enums/supported_theme_mode.dart';

class LocalSettingsProvider extends InheritedWidget {
  const LocalSettingsProvider({
    required super.child,
    required this.supportedThemeMode,
    required this.supportedLanguage,
    super.key,
  });

  final SupportedThemeMode supportedThemeMode;
  final SupportedLanguage supportedLanguage;

  static LocalSettingsProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LocalSettingsProvider>()!;

  @override
  bool updateShouldNotify(LocalSettingsProvider oldWidget) =>
      supportedThemeMode != oldWidget.supportedThemeMode;
}
