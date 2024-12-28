import 'package:flutter/material.dart';

import 'hover_animation.dart';
import 'release_scale_button.dart';
import 'scale_button.dart';

class HoverButton extends StatelessWidget {
  const HoverButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.tweenEnd = ScaleButton.tweenEndDefault,
    this.borderRadius = 32,
    this.padding = 8,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final double tweenEnd;
  final double borderRadius;
  final double padding;

  @override
  Widget build(BuildContext context) => HoverAnimation(
        borderRadius: BorderRadius.circular(borderRadius),
        child: ReleaseScaleButton(
          tweenEnd: tweenEnd,
          padding: EdgeInsets.all(padding),
          child: child,
          onPressed: onPressed,
        ),
      );
}
