import 'package:flutter/material.dart';
import 'package:turbo_template/core/typedefs/context_def.dart';
import 'package:turbo_template/core/widgets/svg_message.dart';

class TurboErrorBody extends StatelessWidget {
  const TurboErrorBody({
    Key? key,
    required this.svg,
    required this.message,
    this.ctaText,
    this.onCtaPressed,
  }) : super(key: key);

  final String message;
  final String svg;
  final String? ctaText;
  final ContextDef? onCtaPressed;

  @override
  Widget build(BuildContext context) => Center(
    child: SvgMessage(
      svg: svg,
      message: message,
      ctaText: ctaText,
      onCtaPressed: onCtaPressed,
    ),
  );
}
