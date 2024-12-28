import 'package:flutter/material.dart';

import '../globals/g_strings.dart';

enum NavigationTab {
  home,
  ;

  static const defaultValue = NavigationTab.home;

  int get branchIndex {
    switch (this) {
      case NavigationTab.home:
        return 0;
    }
  }

  String get label {
    switch (this) {
      case NavigationTab.home:
        return gStrings.home;
    }
  }

  IconData get icon {
    switch (this) {
      case NavigationTab.home:
        return Icons.home_rounded;
    }
  }

  bool get isHome => this == NavigationTab.home;
}
