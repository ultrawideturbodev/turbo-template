import 'package:shadcn_flutter/shadcn_flutter.dart';

enum TurboTheme {
  darkBlue,
  darkViolet,
  darkZinc,
  lightBlue,
  lightViolet,
  lightZinc,
  ;

  ThemeData get themeData {
    switch (this) {
      case TurboTheme.darkViolet:
        return ThemeData(
          colorScheme: ColorSchemes.darkViolet(),
          radius: 0.8,
          surfaceOpacity: 0.5,
          surfaceBlur: 5,
        );
      case TurboTheme.lightViolet:
        return ThemeData(
          colorScheme: ColorSchemes.lightViolet(),
          radius: 0.8,
          surfaceOpacity: 0.5,
          surfaceBlur: 5,
        );
      case TurboTheme.lightBlue:
        return ThemeData(
          colorScheme: ColorSchemes.lightBlue(),
          radius: 0.8,
          surfaceOpacity: 0.5,
          surfaceBlur: 5,
        );
      case TurboTheme.darkBlue:
        return ThemeData(
          colorScheme: ColorSchemes.darkBlue(),
          radius: 0.8,
          surfaceOpacity: 0.5,
          surfaceBlur: 5,
        );
      case TurboTheme.darkZinc:
        return ThemeData(
          colorScheme: ColorSchemes.darkZinc(),
          radius: 0.8,
          surfaceOpacity: 0.5,
          surfaceBlur: 5,
        );
      case TurboTheme.lightZinc:
        return ThemeData(
          colorScheme: ColorSchemes.lightZinc(),
          radius: 0.8,
          surfaceOpacity: 0.5,
          surfaceBlur: 5,
        );
    }
  }
}
