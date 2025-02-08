import 'package:flutter/painting.dart';

extension TBackgroundExtension on TBackgroundType {
  Color? get pBackgroundColor {
    switch (this) {
      case TColorBackground():
        return (this as TColorBackground).backgroundColor;
      case TLinearBackground():
      case TRadialBackground():
        return null;
    }
  }

  LinearGradient? get pLinearGradient {
    switch (this) {
      case TColorBackground():
      case TRadialBackground():
        return null;
      case TLinearBackground():
        final bg = this as TLinearBackground;
        return bg.linearGradient as LinearGradient;
    }
  }

  RadialGradient? get pRadialGradient {
    switch (this) {
      case TColorBackground():
      case TLinearBackground():
        return null;
      case TRadialBackground():
        final bg = this as TRadialBackground;
        return bg.radialGradient as RadialGradient;
    }
  }
}

sealed class TBackgroundType {}

class TColorBackground extends TBackgroundType {
  TColorBackground({required this.backgroundColor});

  final Color backgroundColor;
}

class TLinearBackground extends TBackgroundType {
  TLinearBackground({
    this.linearGradient,
  });

  final LinearGradient? linearGradient;
}

class TRadialBackground extends TBackgroundType {
  TRadialBackground({
    this.radialGradient,
  });

  final RadialGradient? radialGradient;
}
