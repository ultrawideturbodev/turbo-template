import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/ui/enums/t_device_type.dart';

enum NavigationTab {
  home,
  placeholder,
  settings,
  ;

  static List<NavigationTab> navigationTabs({required TDeviceType deviceType}) {
    switch (deviceType) {
      case TDeviceType.mobile:
        return [NavigationTab.home, NavigationTab.placeholder];
      case TDeviceType.tablet:
      case TDeviceType.desktop:
        return values;
    }
  }

  static const defaultValue = NavigationTab.home;

  bool get isHome => this == NavigationTab.home;
  bool get isPlaceholder => this == NavigationTab.placeholder;
  bool get isSettings => this == NavigationTab.settings;

  String get label {
    switch (this) {
      case NavigationTab.home:
        return 'Home';
      case NavigationTab.placeholder:
        return 'Placeholder';
      case NavigationTab.settings:
        return 'Settings';
    }
  }

  IconData get icon {
    switch (this) {
      case NavigationTab.home:
        return Icons.home_rounded;
      case NavigationTab.placeholder:
        return Icons.bolt_rounded;
      case NavigationTab.settings:
        return Icons.settings;
    }
  }
}
