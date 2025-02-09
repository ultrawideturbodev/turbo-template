import 'package:flutter/widgets.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/enums/turbo_device_type.dart';

class DeviceTypeBuilder extends StatelessWidget {
  const DeviceTypeBuilder({
    Key? key,
    required this.child,
    required this.onDesktop,
    required this.onMobile,
    this.onTablet,
    this.deviceType,
  }) : super(key: key);

  final Widget Function(BuildContext context, TurboDeviceType deviceType, Widget child) onDesktop;
  final Widget Function(BuildContext context, TurboDeviceType deviceType, Widget child) onMobile;
  final Widget Function(BuildContext context, TurboDeviceType deviceType, Widget child)? onTablet;
  final Widget child;
  final TurboDeviceType? deviceType;

  @override
  Widget build(BuildContext context) {
    final deviceType = this.deviceType ?? context.data.deviceType;
    switch (deviceType) {
      case TurboDeviceType.mobile:
        return onMobile(context, deviceType, child);
      case TurboDeviceType.tablet:
        return onTablet?.call(context, deviceType, child) ?? onDesktop(context, deviceType, child);
      case TurboDeviceType.desktop:
        return onDesktop(context, deviceType, child);
    }
  }
}
