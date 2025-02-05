part of 'turbo_provider.dart';

class TurboDecorations {
  const TurboDecorations({
    required this.deviceType,
    required this.themeMode,
    required this.theme,
    required this.colors,
  });

  final TurboDeviceType deviceType;
  final TurboThemeMode themeMode;
  final TurboTheme theme;
  final TurboColors colors;

  List<BoxShadow> get cardShadow {
    return [
      const BoxShadow(
        color: Color(0x0C000000),
        blurRadius: 2,
        offset: Offset(0, 1),
        spreadRadius: 0,
      ),
    ];
  }

  TurboBackground get scaffoldBackground {
    switch (themeMode) {
      case TurboThemeMode.dark:
        return TurboRadialGradient(
          radialGradient: const RadialGradient(
            colors: [
              Color(0xff1e1d1d),
              Color(0xff000000),
            ],
            stops: [0, 1],
            center: Alignment(0.0, -0.2),
          ),
        );
      case TurboThemeMode.light:
        return TurboLinearGradient(
          linearGradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFFB4B4ED),
              Color(0xFFE5E6F8),
              Color(0xFFFFFFFF),
              Color(0xFFD5D5F5),
            ],
            stops: [0.0, 0.3, 0.6, 1.0],
          ),
        );
    }
  }
}
