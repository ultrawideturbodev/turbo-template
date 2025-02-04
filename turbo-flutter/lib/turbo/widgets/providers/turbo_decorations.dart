part of 'turbo_provider.dart';

class TurboDecorations {
  const TurboDecorations({
    required this.deviceType,
    required this.themeMode,
  });

  final TurboDeviceType deviceType;
  final TurboThemeMode themeMode;

  BlurStyle get blurStyle => BlurStyle.solid;
  EdgeInsets get cardPadding => const EdgeInsets.all(kSizesCardPadding);

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

  LinearGradient get gradientBackground {
    return const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xFFB4B4ED),
        Color(0xFFE5E6F8),
        Color(0xFFFFFFFF),
        Color(0xFFFFFFFF),
        Color(0xFFD5D5F5),
        Color(0xFFB4B4ED),
      ],
      stops: [0.0, 0.22, 0.4, 0.6, 0.75, 1.0],
    );
  }
}

class _CardDecorations {}
