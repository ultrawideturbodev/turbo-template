import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../enums/custom_orientation.dart';
import '../enums/device_type.dart';
import '../enums/screen_type.dart';

class ResponsiveData {
  const ResponsiveData({
    required this.constraints,
    required this.maxWidth,
    required this.maxHeight,
    required this.orientation,
    required this.screenType,
  });

  final BoxConstraints constraints;
  final double maxWidth;
  final double maxHeight;
  final CustomOrientation orientation;
  final ScreenType screenType;

  bool get isExtraSmall => screenType == ScreenType.extraSmall;
  bool get isSmall => screenType == ScreenType.small;
  bool get isMedium => screenType == ScreenType.medium;
  bool get isLarge => screenType == ScreenType.large;

  DeviceType get deviceType => screenType.deviceType;

  bool get isPortrait => orientation == CustomOrientation.portrait;
  bool get isLandscape => orientation == CustomOrientation.landscape;
  bool get isSquare => orientation == CustomOrientation.square;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isMobile => deviceType == DeviceType.mobile;

  void printDesignWidthAndHeight() {
    if (kDebugMode) {
      print('''


screenWidthInDesign: $maxWidth,
screenHeightInDesign: $maxHeight,
''');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponsiveData &&
          runtimeType == other.runtimeType &&
          constraints == other.constraints &&
          maxWidth == other.maxWidth &&
          maxHeight == other.maxHeight &&
          orientation == other.orientation &&
          screenType == other.screenType;

  @override
  int get hashCode =>
      constraints.hashCode ^
      maxWidth.hashCode ^
      maxHeight.hashCode ^
      orientation.hashCode ^
      screenType.hashCode;
}
