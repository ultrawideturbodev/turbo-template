import 'package:flutter/widgets.dart';

import '../constants/k_sizes.dart';

class HoPadding extends StatelessWidget {
  const HoPadding({
    Key? key,
    this.padding = kSizesAppPadding,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: padding,
        ),
        child: child,
      );
}
