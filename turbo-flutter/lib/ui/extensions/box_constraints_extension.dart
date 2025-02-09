import 'package:flutter/widgets.dart';
import 'package:turbo_template/ui/config/turbo_breakpoint_config.dart';
import 'package:turbo_template/ui/enums/t_device_type.dart';
import 'package:turbo_template/ui/enums/turbo_orientation.dart';

extension BoxConstraintsExtension on BoxConstraints {
  TurboOrientation get turboOrientation {
    final difference = (maxHeight - maxWidth).abs();
    const landscapeMultiplier = 1;
    const portraitMultiplier = 1;
    final landscapeThreshold = maxHeight * landscapeMultiplier;
    final portraitThreshold = maxWidth * portraitMultiplier;

    if (difference <= landscapeThreshold && difference <= portraitThreshold) {
      return TurboOrientation.square;
    }

    return maxHeight > maxWidth ? TurboOrientation.portrait : TurboOrientation.landscape;
  }

  TDeviceType turboDeviceType({
    required TBreakpointConfig breakpointConfig,
  }) {
    if (maxWidth >= breakpointConfig.desktopBreakpointWidth ||
        maxHeight >= breakpointConfig.desktopBreakpointHeight) {
      return TDeviceType.desktop;
    }
    if (maxWidth >= breakpointConfig.tabletBreakpointWidth ||
        maxHeight >= breakpointConfig.tabletBreakpointHeight) {
      return TDeviceType.tablet;
    }
    return TDeviceType.mobile;
  }
}
