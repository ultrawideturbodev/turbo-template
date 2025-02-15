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
              colorScheme: ColorSchemes.darkZinc().copyWith(
                background: const Color(0xFF09090B),
                border: const Color(0xFF27272A),
                card: const Color(0xFF0D1117),
              ),
              radius: 0.8,
            );
          case TThemeMode.light:
            return ThemeData(
              colorScheme: ColorSchemes.lightZinc().copyWith(
                background: const Color(0xFFFFFFFF),
                border: const Color(0xFFE4E4E7),
                card: const Color(0xFFFAFAFA),
              ),
              radius: 0.8,
            );
        }
    }
  }
}
