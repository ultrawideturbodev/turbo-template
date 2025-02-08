import 'package:flutter/widgets.dart';
import 'package:{{packageName.snakeCase()}}/animations/widgets/turbo_button_animation.dart';
import 'package:{{packageName.snakeCase()}}/feedback/globals/g_vibrate.dart';

class TurboButton extends StatelessWidget {
  const TurboButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.scaleEnd = 0.95,
    this.opacityEnd = 0.8,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final double scaleEnd;
  final double opacityEnd;

  @override
  Widget build(BuildContext context) => TurboButtonAnimation(
        scaleEnd: scaleEnd,
        opacityEnd: opacityEnd,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: child,
            onTapDown: (_) => gVibrateSelection(),
            onTapUp: (_) => onPressed?.call(),
          ),
        ),
      );
}
