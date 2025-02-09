import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/ui/enums/turbo_device_type.dart';
import 'package:turbo_template/ui/enums/turbo_theme_mode.dart';
import 'package:turbo_template/ui/widgets/turbo_card.dart';

enum TurboTheme {
  blue,
  violet,
  zinc,
  ;

  static const defaultValue = TurboTheme.zinc;

  ThemeData themeData({
    required TurboThemeMode themeMode,
    required TurboDeviceType deviceType,
  }) {
    switch (this) {
      case TurboTheme.blue:
        switch (themeMode) {
          case TurboThemeMode.dark:
            return ThemeData(
              colorScheme: ColorSchemes.darkBlue(),
              radius: 0.8,
            );
          case TurboThemeMode.light:
            return ThemeData(
              colorScheme: ColorSchemes.lightBlue(),
              radius: 0.8,
            );
        }
      case TurboTheme.violet:
        switch (themeMode) {
          case TurboThemeMode.dark:
            return ThemeData(
              colorScheme: ColorSchemes.darkViolet(),
              radius: 0.8,
            );
          case TurboThemeMode.light:
            return ThemeData(
              colorScheme: ColorSchemes.lightViolet(),
              radius: 0.8,
            );
        }
      case TurboTheme.zinc:
        switch (themeMode) {
          case TurboThemeMode.dark:
            return ThemeData(
              colorScheme: ColorSchemes.darkZinc(),
              radius: 0.8,
            );
          case TurboThemeMode.light:
            return ThemeData(
              colorScheme: ColorSchemes.lightZinc().copyWith(
                background: switch (deviceType) {
                  TurboDeviceType.mobile => Colors.white,
                  TurboDeviceType.tablet || TurboDeviceType.desktop => const Color(0xFFFBFBFB),
                },
              ),
              radius: 0.8,
            );
        }
    }
  }
}
