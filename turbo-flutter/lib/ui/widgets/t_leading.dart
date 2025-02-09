import 'package:flutter/widgets.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';

class TLeading extends StatelessWidget {
  const TLeading._({
    super.key,
    required this.child,
    required this.leading,
    required this.direction,
    required this.crossAxisAlignment,
    required this.mainAxisAlignment,
    required this.mainAxisSize,
    required this.spacing,
  });

  const TLeading.horizontal({
    super.key,
    required this.child,
    required this.leading,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = kSizesAppPaddingX0p5,
  }) : direction = Axis.horizontal;

  const TLeading.vertical({
    super.key,
    required this.child,
    required this.leading,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = kSizesAppPaddingX0p5,
  }) : direction = Axis.vertical;

  final Axis direction;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final Widget child;
  final Widget leading;
  final double spacing;

  @override
  Widget build(BuildContext context) => Flex(
    crossAxisAlignment: crossAxisAlignment,
    direction: direction,
    mainAxisAlignment: mainAxisAlignment,
    mainAxisSize: mainAxisSize,
    spacing: spacing,
    children: [
      leading,
      child,
    ],
  );
}
