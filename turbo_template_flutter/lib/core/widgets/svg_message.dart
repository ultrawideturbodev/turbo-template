import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:turbo_template/core/typedefs/context_def.dart';

class SvgMessage extends StatelessWidget {
  const SvgMessage({
    super.key,
    required this.svg,
    required this.message,
    this.onCtaPressed,
    this.ctaText,
  });

  final String svg;
  final String message;
  final String? ctaText;
  final ContextDef? onCtaPressed;

  @override
  Widget build(BuildContext context) {
    final hasCta = ctaText != null && onCtaPressed != null;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          svg,
          width: 120,
        ).slideBottomUpWithFade(
          begin: 0.2,
          duration: kDurationsAnimation,
        ),
        const Gap(16),
        Text(
          message,
          style: context.texts.svgMessage,
          textAlign: TextAlign.center,
        ).slideBottomUpWithFade(
          delay: kDurationsAnimation,
          duration: kDurationsAnimation,
          begin: 0.2,
        ),
        if (hasCta) ...[
          const Gap(16),
          TuButton.primary(
            text: ctaText!,
            onPressed: () => onCtaPressed!(context),
          ).slideBottomUpWithFade(
            delay: kDurationsAnimationX2,
            duration: kDurationsAnimation,
            begin: 0.2,
          ),
        ],
      ],
    );
  }
}
