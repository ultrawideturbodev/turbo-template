import 'package:flutter/material.dart';

import '../enums/custom_orientation.dart';
import '../enums/screen_type.dart';

extension BoxConstraintsExtension on BoxConstraints {
  CustomOrientation get orientation {
    final difference = (maxHeight - maxWidth).abs();
    const landscapeMultiplier = 1;
    const portraitMultiplier = 1;
    final landscapeThreshold = maxHeight * landscapeMultiplier;
    final portraitThreshold = maxWidth * portraitMultiplier;

    if (difference <= landscapeThreshold && difference <= portraitThreshold) {
      return CustomOrientation.square;
    }

    return maxHeight > maxWidth ? CustomOrientation.portrait : CustomOrientation.landscape;
  }

  ScreenType screenType({required double width, required double height}) {
    if (width >= 1024 || height >= 1366) return ScreenType.large;
    if (width >= 768 || height >= 1024) return ScreenType.medium;
    if (width >= 480) return ScreenType.small;
    return ScreenType.extraSmall;
  }
}
