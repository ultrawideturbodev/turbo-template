import 'package:flutter/painting.dart';

extension TurboBackgroundExtension on TurboBackground {
  Color? get pBackgroundColor {
    switch (this) {
      case TurboColorBackground():
        return (this as TurboColorBackground).backgroundColor;
      case TurboGradientBackground():
        return null;
    }
  }

  LinearGradient? get pLinearGradient {
    switch (this) {
      case TurboColorBackground():
        return null;
      case TurboGradientBackground():
        final bg = this as TurboGradientBackground;
        return bg.gradient as LinearGradient;
    }
  }

  RadialGradient? get pRadialGradient {
    switch (this) {
      case TurboColorBackground():
        return null;
      case TurboGradientBackground():
        final bg = this as TurboGradientBackground;
        return bg.gradient as RadialGradient;
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
    this.gradient,
  });

  final Gradient? gradient;
}
