import 'package:shadcn_flutter/shadcn_flutter.dart';

enum TurboTheme {
  darkViolet,
  lightViolet,
  lightBlue,
  darkBlue,
  ;

  ThemeData get themeData {
    switch (this) {
      case TurboTheme.darkViolet:
        return ThemeData(
          colorScheme: ColorSchemes.darkViolet(),
          radius: 0.6,
          surfaceOpacity: 0.5,
          surfaceBlur: 5,
        );
      case TurboTheme.lightViolet:
        return ThemeData(
          colorScheme: ColorSchemes.lightViolet(),
          radius: 0.6,
          surfaceOpacity: 0.5,
          surfaceBlur: 5,
        );
      case TurboTheme.lightBlue:
        return ThemeData(
          colorScheme: ColorSchemes.lightBlue(),
          radius: 0.6,
          surfaceOpacity: 0.5,
          surfaceBlur: 5,
        );
      case TurboTheme.darkBlue:
        return ThemeData(
          colorScheme: ColorSchemes.darkBlue(),
          radius: 0.6,
          surfaceOpacity: 0.5,
          surfaceBlur: 5,
        );
    }
  }
}
