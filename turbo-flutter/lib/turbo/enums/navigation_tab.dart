import 'package:shadcn_flutter/shadcn_flutter.dart';

enum NavigationTab {
  home,
  placeholder,
  ;

  static const defaultValue = NavigationTab.home;

  bool get isHome => this == NavigationTab.home;
  bool get isPlaceholder => this == NavigationTab.placeholder;

  String get label {
    switch (this) {
      case NavigationTab.home:
        return 'Home';
      case NavigationTab.placeholder:
        return 'Placeholder';
    }
  }

  IconData get icon {
    switch (this) {
      case NavigationTab.home:
        return Icons.home_rounded;
      case NavigationTab.placeholder:
        return Icons.bolt_rounded;
    }
  }
}
