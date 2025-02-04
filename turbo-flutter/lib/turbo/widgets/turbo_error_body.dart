import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/typedefs/context_def.dart';
import 'package:turbo_template/turbo/widgets/svg_message.dart';

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
