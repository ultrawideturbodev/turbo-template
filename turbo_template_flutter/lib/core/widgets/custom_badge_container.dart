import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';

class CustomBadgeContainer extends StatelessWidget {
  const CustomBadgeContainer({
    Key? key,
    this.height,
    this.width,
    this.color = Colors.red,
    required this.child,
    this.shape = BoxShape.circle,
    this.borderRadius,
    this.boxShadow = const [],
  }) : super(key: key);

  final double? height;
  final double? width;
  final Color color;
  final Widget child;
  final BoxShape shape;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: context.colors.background),
          boxShadow: boxShadow ?? context.ui.cardShadow,
          shape: shape,
          color: color,
        ),
        child: child,
      );
}
