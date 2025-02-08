import 'package:flutter/cupertino.dart';
import 'package:{{packageName.snakeCase()}}/ui/enums/turbo_device.dart';
import 'package:{{packageName.snakeCase()}}/ui/enums/turbo_device_type.dart';

extension TurboTargetPlatformExtensionExtension on TargetPlatform {
  TurboDevice get defaultDevice {
    switch (this) {
      case TargetPlatform.android:
        return TurboDevice.androidCompact;
      case TargetPlatform.iOS:
        return TurboDevice.iPhone16Pro;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return TurboDevice.desktop;
    }
  }

  TurboDeviceType get defaultDeviceType {
    switch (this) {
      case TargetPlatform.android:
        return TurboDeviceType.mobile;
      case TargetPlatform.iOS:
        return TurboDeviceType.mobile;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return TurboDeviceType.desktop;
    }
  }

  double get defaultWidthInDesign => defaultDevice.width;

  double get defaultHeightInDesign => defaultDevice.height;
}
