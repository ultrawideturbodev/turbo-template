import 'package:flutter/foundation.dart';

import 'device_type.dart';

enum ScreenType {
  extraSmall,
  small,
  medium,
  large;

  DeviceType get deviceType {
    switch (this) {
      case ScreenType.extraSmall:
      case ScreenType.small:
        return DeviceType.mobile;
      case ScreenType.medium:
      case ScreenType.large:
        if (kIsWeb) return DeviceType.web;
        return DeviceType.tablet;
    }
  }
}
