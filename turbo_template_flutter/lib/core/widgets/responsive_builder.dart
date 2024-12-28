import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/k_sizes.dart';
import '../extensions/box_constraints_extension.dart';
import '../utils/responsive_data.dart';
import '../utils/responsive_tools.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.builder,
    this.child,
    this.screenWidthInDesign,
    this.screenHeightInDesign,
  });

  final Widget Function(
    BuildContext context,
    Widget? child,
    ResponsiveTools rTools,
    ResponsiveData rData,
  ) builder;

  final Widget? child;

  final double? screenWidthInDesign;
  final double? screenHeightInDesign;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          return builder(
            context,
            child,
            ResponsiveTools(
              screenWidthInDesign: screenWidthInDesign ?? kSizesPrototypeWidth,
              screenHeightInDesign: screenHeightInDesign ?? kSizesPrototypeHeight,
              context: context,
            ),
            ResponsiveData(
              constraints: constraints,
              maxWidth: constraints.maxWidth,
              maxHeight: constraints.maxHeight,
              orientation: constraints.orientation,
              screenType: constraints.screenType(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              ),
            ),
          );
        },
      );
}
