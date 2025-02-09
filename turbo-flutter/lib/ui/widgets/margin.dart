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

  const Margin.left({
    Key? key,
    required this.child,
    this.left = kSizesAppPadding,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
  }) : super(key: key);

  const Margin.right({
    Key? key,
    required this.child,
    this.left = 0,
    this.right = kSizesAppPadding,
    this.top = 0,
    this.bottom = 0,
  }) : super(key: key);

  const Margin.top({
    Key? key,
    required this.child,
    this.left = 0,
    this.right = 0,
    this.top = kSizesAppPadding,
    this.bottom = 0,
  }) : super(key: key);

  const Margin.bottom({
    Key? key,
    required this.child,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = kSizesAppPadding,
  }) : super(key: key);

  const Margin.horizontal({
    Key? key,
    required this.child,
    this.left = kSizesAppPadding,
    this.right = kSizesAppPadding,
    this.top = 0,
    this.bottom = 0,
  }) : super(key: key);

  const Margin.vertical({
    Key? key,
    required this.child,
    this.left = 0,
    this.right = 0,
    this.top = kSizesAppPadding,
    this.bottom = kSizesAppPadding,
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
