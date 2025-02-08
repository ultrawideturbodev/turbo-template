import 'package:flutter/widgets.dart';

import '../../data/constants/k_durations.dart';
import '../../data/constants/k_sizes.dart';

class AnimatedEnabled extends StatelessWidget {
  const AnimatedEnabled({
    required this.isEnabled,
    required this.child,
    this.animationDuration = kDurationsAnimation,
    this.disabledOpacity = kSizesOpacityDisabled,
    Key? key,
  }) : super(key: key);

  final bool isEnabled;
  final Widget child;
  final Duration animationDuration;
  final double disabledOpacity;

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
        opacity: isEnabled ? 1 : disabledOpacity,
        duration: animationDuration,
        curve: Curves.easeInOut,
        child: IgnorePointer(
          ignoring: !isEnabled,
          child: child,
        ),
      );
}
