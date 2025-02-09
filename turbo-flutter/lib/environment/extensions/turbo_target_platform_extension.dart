import 'package:flutter/cupertino.dart';
import 'package:turbo_template/ui/enums/turbo_device.dart';
import 'package:turbo_template/ui/enums/t_device_type.dart';

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

  TDeviceType get defaultDeviceType {
    switch (this) {
      case TargetPlatform.android:
        return TDeviceType.mobile;
      case TargetPlatform.iOS:
        return TDeviceType.mobile;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return TDeviceType.desktop;
    }
  }

  double get defaultWidthInDesign => defaultDevice.width;

  double get defaultHeightInDesign => defaultDevice.height;
}
