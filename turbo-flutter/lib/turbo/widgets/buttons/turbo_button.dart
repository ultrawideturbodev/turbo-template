import 'package:flutter/widgets.dart';
import 'package:turbo_template/animations/widgets/turbo_button_animation.dart';
import 'package:turbo_template/turbo/globals/g_vibrate.dart';

class TurboButton extends StatelessWidget {
  const TurboButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => TurboButtonAnimation(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: child,
            onTapDown: (_) => gVibrateSelection(),
            onTapUp: (_) => onPressed(),
          ),
        ),
      );
}
