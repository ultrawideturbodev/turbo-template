import 'package:flutter/widgets.dart';

import '../../data/constants/k_sizes.dart';

class RightPadding extends StatelessWidget {
  const RightPadding({
    Key? key,
    required this.child,
    this.bottom = 0,
    this.left = 0,
    this.right = kSizesAppPadding,
    this.top = 0,
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
