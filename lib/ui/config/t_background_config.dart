import 'package:flutter/painting.dart';

extension TBackgroundExtension on TBackgroundConfig {
  Color? get pBackgroundColor {
    switch (this) {
      case TBackgroundColor():
        return (this as TBackgroundColor).backgroundColor;
      case TBackgroundLinear():
      case TBackgroundRadial():
        return null;
    }
  }

  LinearGradient? get pLinearGradient {
    switch (this) {
      case TBackgroundColor():
      case TBackgroundRadial():
        return null;
      case TBackgroundLinear():
        final bg = this as TBackgroundLinear;
        return bg.linearGradient as LinearGradient;
    }
  }

  RadialGradient? get pRadialGradient {
    switch (this) {
      case TBackgroundColor():
      case TBackgroundLinear():
        return null;
      case TBackgroundRadial():
        final bg = this as TBackgroundRadial;
        return bg.radialGradient as RadialGradient;
    }
  }
}

sealed class TBackgroundConfig {}

class TBackgroundColor extends TBackgroundConfig {
  TBackgroundColor({required this.backgroundColor});

  final Color backgroundColor;
}

class TBackgroundLinear extends TBackgroundConfig {
  TBackgroundLinear({
    this.linearGradient,
  });

  final LinearGradient? linearGradient;
}

class TBackgroundRadial extends TBackgroundConfig {
  TBackgroundRadial({
    this.radialGradient,
  });

  final RadialGradient? radialGradient;
}
