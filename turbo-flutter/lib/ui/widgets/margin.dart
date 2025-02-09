import 'package:flutter/widgets.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';

class Margin extends StatelessWidget {
  const Margin({
    Key? key,
    required this.child,
    this.bottom = kSizesAppPadding,
    this.left = kSizesAppPadding,
    this.right = kSizesAppPadding,
    this.top = kSizesAppPadding,
  }) : super(key: key);

  final Widget child;

  final double bottom;
  final double left;
  final double right;
  final double top;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          bottom: bottom,
          left: left,
          right: right,
          top: top,
        ),
        child: child,
      );
}
