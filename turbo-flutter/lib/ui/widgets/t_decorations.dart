part of 't_provider.dart';

class TDecorations {
  const TDecorations({
    required this.deviceType,
    required this.themeMode,
    required this.theme,
    required this.colors,
  });

  final TDeviceType deviceType;
  final TThemeMode themeMode;
  final TTheme theme;
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

  TBackgroundConfig get scaffoldBackground => TBackgroundColor(
        backgroundColor: colors.scheme.background,
      );
}
