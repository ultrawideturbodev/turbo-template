import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/ui/enums/t_device_type.dart';
import 'package:turbo_template/ui/enums/t_theme_mode.dart';
import 'package:turbo_template/ui/widgets/t_card.dart';

enum TTheme {
  blue,
  violet,
  zinc,
  ;

  static const defaultValue = TTheme.zinc;

  ThemeData themeData({
    required TThemeMode themeMode,
    required TDeviceType deviceType,
  }) {
    switch (this) {
      case TTheme.blue:
        switch (themeMode) {
          case TThemeMode.dark:
            return ThemeData(
              colorScheme: ColorSchemes.darkBlue(),
              radius: 0.8,
            );
          case TThemeMode.light:
            return ThemeData(
              colorScheme: ColorSchemes.lightBlue(),
              radius: 0.8,
            );
        }
      case TTheme.violet:
        switch (themeMode) {
          case TThemeMode.dark:
            return ThemeData(
              colorScheme: ColorSchemes.darkViolet(),
              radius: 0.8,
            );
          case TThemeMode.light:
            return ThemeData(
              colorScheme: ColorSchemes.lightViolet(),
              radius: 0.8,
            );
        }
      case TTheme.zinc:
        switch (themeMode) {
          case TThemeMode.dark:
            return ThemeData(
              colorScheme: ColorSchemes.darkZinc(),
              radius: 0.8,
            );
          case TThemeMode.light:
            return ThemeData(
              colorScheme: ColorSchemes.lightZinc().copyWith(
                background: switch (deviceType) {
                  TDeviceType.mobile => Colors.white,
                  TDeviceType.tablet || TDeviceType.desktop => const Color(0xFFFBFBFB),
                },
              ),
              radius: 0.8,
            );
        }
    }
  }
}
