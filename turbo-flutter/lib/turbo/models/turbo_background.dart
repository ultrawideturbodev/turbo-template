import 'package:flutter/painting.dart';

extension TurboBackgroundExtension on TurboBackground {
  Color? get backgroundColor {
    switch (this) {
      case TurboColorBackground():
        return (this as TurboColorBackground).backgroundColor;
      case TurboGradientBackground():
        return (this as TurboGradientBackground).backgroundColor;
    }
  }

  LinearGradient? get linearGradient {
    switch (this) {
      case TurboColorBackground():
        return null;
      case TurboGradientBackground():
        final bg = this as TurboGradientBackground;
        return LinearGradient(
          colors: bg.colors,
          begin: bg.begin,
          end: bg.end,
        );
    }
  }

  RadialGradient? get radialGradient {
    switch (this) {
      case TurboColorBackground():
        return null;
      case TurboGradientBackground():
        final bg = this as TurboGradientBackground;
        return RadialGradient(
          colors: bg.colors,
          center: bg.center,
          radius: bg.radius,
        );
    }
  }
}

sealed class TurboBackground {}

class TurboColorBackground extends TurboBackground {
  TurboColorBackground({required this.backgroundColor});

  final Color backgroundColor;
}

class TurboGradientBackground extends TurboBackground {
  TurboGradientBackground({
    required this.colors,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    this.center = Alignment.center,
    this.radius = 0.8,
    this.backgroundColor,
  });

  final Color? backgroundColor;
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final AlignmentGeometry center;
  final double radius;
}
