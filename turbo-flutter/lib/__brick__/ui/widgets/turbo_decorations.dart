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

  TBackgroundType get scaffoldBackground => TColorBackground(
        backgroundColor: colors.scheme.background,
      );
}
