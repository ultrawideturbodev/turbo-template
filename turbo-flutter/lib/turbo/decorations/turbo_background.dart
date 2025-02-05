import 'package:flutter/painting.dart';

extension TurboBackgroundExtension on TurboBackground {
  Color? get pBackgroundColor {
    switch (this) {
      case TurboColorBackground():
        return (this as TurboColorBackground).backgroundColor;
      case TurboLinearGradient():
      case TurboRadialGradient():
        return null;
    }
  }

  LinearGradient? get pLinearGradient {
    switch (this) {
      case TurboColorBackground():
      case TurboRadialGradient():
        return null;
      case TurboLinearGradient():
        final bg = this as TurboLinearGradient;
        return bg.linearGradient as LinearGradient;
    }
  }

  RadialGradient? get pRadialGradient {
    switch (this) {
      case TurboColorBackground():
      case TurboLinearGradient():
        return null;
      case TurboRadialGradient():
        final bg = this as TurboRadialGradient;
        return bg.radialGradient as RadialGradient;
    }
  }
}

sealed class TurboBackground {}

class TurboColorBackground extends TurboBackground {
  TurboColorBackground({required this.backgroundColor});

  final Color backgroundColor;
}

class TurboLinearGradient extends TurboBackground {
  TurboLinearGradient({
    this.linearGradient,
  });

  final LinearGradient? linearGradient;
}

class TurboRadialGradient extends TurboBackground {
  TurboRadialGradient({
    this.radialGradient,
  });

  final RadialGradient? radialGradient;
}
