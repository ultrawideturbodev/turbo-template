import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';

import 'release_scale_button.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    this.onPressed,
    this.size = 24,
    super.key,
  });

  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) => ReleaseScaleButton(
        child: Icon(
          Icons.arrow_back_rounded,
          size: size,
        ),
        onPressed: onPressed ?? context.tryPop,
      );
}
