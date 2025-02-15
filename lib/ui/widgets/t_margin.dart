import 'package:flutter/widgets.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';

class TMargin extends StatelessWidget {
  const TMargin({
    Key? key,
    required this.child,
    this.bottom = kSizesAppPadding,
    this.left = kSizesAppPadding,
    this.right = kSizesAppPadding,
    this.top = kSizesAppPadding,
  }) : super(key: key);

  const TMargin.only({
    Key? key,
    required this.child,
    this.bottom = 0,
    this.left = 0,
    this.right = 0,
    this.top = 0,
  }) : super(key: key);

  const TMargin.left({
    Key? key,
    required this.child,
    this.left = kSizesAppPadding,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
  }) : super(key: key);

  const TMargin.right({
    Key? key,
    required this.child,
    this.left = 0,
    this.right = kSizesAppPadding,
    this.top = 0,
    this.bottom = 0,
  }) : super(key: key);

  const TMargin.top({
    Key? key,
    required this.child,
    this.left = 0,
    this.right = 0,
    this.top = kSizesAppPadding,
    this.bottom = 0,
  }) : super(key: key);

  const TMargin.bottom({
    Key? key,
    required this.child,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = kSizesAppPadding,
  }) : super(key: key);

  const TMargin.horizontal({
    Key? key,
    required this.child,
    this.left = kSizesAppPadding,
    this.right = kSizesAppPadding,
    this.top = 0,
    this.bottom = 0,
  }) : super(key: key);

  const TMargin.vertical({
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
