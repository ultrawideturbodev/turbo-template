import 'package:flutter/widgets.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';

class TWrapping extends StatelessWidget {
  const TWrapping._({
    super.key,
    required this.child,
    required this.leading,
    required this.trailing,
    required this.direction,
    required this.crossAxisAlignment,
    required this.mainAxisAlignment,
    required this.mainAxisSize,
    required this.spacing,
  });

  const TWrapping.horizontal({
    super.key,
    required this.child,
    required this.leading,
    required this.trailing,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = kSizesAppPaddingX0p5,
  }) : direction = Axis.horizontal;

  const TWrapping.vertical({
    super.key,
    required this.child,
    required this.leading,
    required this.trailing,
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
  final Widget trailing;
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
          trailing,
        ],
      );
}
