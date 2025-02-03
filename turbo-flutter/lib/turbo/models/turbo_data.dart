import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:turbo_template/turbo/enums/turbo_device_type.dart';
import 'package:turbo_template/turbo/enums/turbo_orientation.dart';

class TurboData {
  const TurboData({
    required this.currentWidth,
    required this.currentHeight,
    required this.orientation,
    required this.deviceType,
    required this.media,
  });

  final double currentWidth;
  final double currentHeight;
  final TurboOrientation orientation;
  final TurboDeviceType deviceType;
  final MediaQueryData media;

  bool get isPortrait => orientation == TurboOrientation.portrait;
  bool get isLandscape => orientation == TurboOrientation.landscape;
  bool get isSquare => orientation == TurboOrientation.square;
  bool get isTablet => deviceType == TurboDeviceType.tablet;
  bool get isMobile => deviceType == TurboDeviceType.mobile;

  TurboData copyWith({
    double? currentWidth,
    double? currentHeight,
    TurboOrientation? orientation,
    TurboDeviceType? deviceType,
    MediaQueryData? media,
  }) =>
      TurboData(
        currentWidth: currentWidth ?? this.currentWidth,
        currentHeight: currentHeight ?? this.currentHeight,
        orientation: orientation ?? this.orientation,
        deviceType: deviceType ?? this.deviceType,
        media: media ?? this.media,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TurboData &&
          runtimeType == other.runtimeType &&
          currentWidth == other.currentWidth &&
          currentHeight == other.currentHeight &&
          orientation == other.orientation &&
          deviceType == other.deviceType &&
          media == other.media;

  @override
  int get hashCode =>
      currentWidth.hashCode ^
      currentHeight.hashCode ^
      orientation.hashCode ^
      deviceType.hashCode ^
      media.hashCode;

  double get bottomSafeArea => media.viewPadding.bottom;
  double get bottomSafeAreaWithMinimum => max(bottomSafeArea, 16);
  double get bottomViewInsets => media.viewInsets.bottom;
  double get height => media.size.height;
  double get topSafeArea => media.viewPadding.top;
  double get topViewInsets => media.viewInsets.top;
  double get width => media.size.width;
}
