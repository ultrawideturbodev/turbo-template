import 'package:flutter/material.dart';

import '../utils/responsive_data.dart';
import '../utils/responsive_tools.dart';

class ResponsiveToolsProvider extends InheritedWidget {
  const ResponsiveToolsProvider({
    super.key,
    required this.rTools,
    required this.rData,
    required super.child,
  });

  final ResponsiveTools rTools;
  final ResponsiveData rData;

  static ResponsiveToolsProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ResponsiveToolsProvider>()!;

  @override
  bool updateShouldNotify(ResponsiveToolsProvider oldWidget) =>
      rTools != oldWidget.rTools || rData != oldWidget.rData;
}
