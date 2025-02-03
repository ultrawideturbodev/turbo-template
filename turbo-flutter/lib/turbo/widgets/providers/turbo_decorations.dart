part of 'turbo_provider.dart';

class TurboDecorations {
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
