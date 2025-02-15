import 'package:flutter/widgets.dart';
import 'package:turbo_template/animations/widgets/t_button_animation.dart';
import 'package:turbo_template/feedback/globals/g_vibrate.dart';

class TButton extends StatelessWidget {
  const TButton({
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
  Widget build(BuildContext context) => TButtonAnimation(
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
