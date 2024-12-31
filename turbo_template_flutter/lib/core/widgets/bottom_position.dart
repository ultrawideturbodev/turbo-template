import 'package:flutter/widgets.dart';
import 'package:turbo_template/core/constants/k_sizes.dart';
import 'package:turbo_template/core/extensions/context_extension.dart';

class BottomPositioned extends StatelessWidget {
  const BottomPositioned({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Positioned(
        bottom: context.tSizes.bottomSafeAreaWithMinimum + kSizesAppPadding,
        left: kSizesAppPadding,
        right: kSizesAppPadding,
        child: child,
      );
}
