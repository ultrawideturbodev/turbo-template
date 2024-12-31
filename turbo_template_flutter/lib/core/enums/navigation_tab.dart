import 'package:flutter/material.dart';

import '../globals/g_strings.dart';

enum NavigationTab {
  home,
  settings,
  ;

  static const defaultValue = NavigationTab.home;

  int get branchIndex {
    switch (this) {
      case NavigationTab.home:
        return 0;
      case NavigationTab.settings:
        return 1;
    }
  }

  String get label {
    switch (this) {
      case NavigationTab.home:
        return gStrings.home;
      case NavigationTab.settings:
        return gStrings.settings;
    }
  }

  IconData get icon {
    switch (this) {
      case NavigationTab.home:
        return Icons.home_rounded;
      case NavigationTab.settings:
        return Icons.work_rounded;
    }
  }

  bool get isActors => this == NavigationTab.home;
  bool get isActivities => this == NavigationTab.settings;
}
