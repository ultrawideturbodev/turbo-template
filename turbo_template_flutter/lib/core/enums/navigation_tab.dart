import 'package:flutter/material.dart';

enum NavigationTab {
  home,
  theSecond,
  theActionButton,
  theThird,
  theFourth,
  ;

  static const defaultValue = NavigationTab.home;

  bool get isHome => this == NavigationTab.home;
  bool get isTheSecond => this == NavigationTab.theSecond;
  bool get isTheActionButton => this == NavigationTab.theActionButton;
  bool get isTheThird => this == NavigationTab.theThird;
  bool get isTheFourth => this == NavigationTab.theFourth;

  String get label {
    switch (this) {
      case NavigationTab.home:
        return 'Home';
      case NavigationTab.theSecond:
        return 'Schedule';
      case NavigationTab.theActionButton:
        return 'Quickie';
      case NavigationTab.theThird:
        return 'Tools';
      case NavigationTab.theFourth:
        return 'Workspace';
    }
  }

  IconData get icon {
    switch (this) {
      case NavigationTab.home:
        return Icons.home_rounded;
      case NavigationTab.theSecond:
        return Icons.view_agenda_rounded;
      case NavigationTab.theActionButton:
        return Icons.bolt_rounded;
      case NavigationTab.theThird:
        return Icons.account_tree_rounded;
      case NavigationTab.theFourth:
        return Icons.format_list_bulleted_rounded;
    }
  }

}
