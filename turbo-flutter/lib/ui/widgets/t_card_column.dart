import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/config/turbo_button_config.dart';
import 'package:turbo_template/ui/widgets/t_gap.dart';

class TCardColumn extends StatelessWidget {
  const TCardColumn({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPrimaryPressed,
    this.onSecondaryPressed,
  });

  final String title;
  final String subtitle;
  final TButtonTextConfig onPrimaryPressed;
  final TButtonTextConfig? onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    final hasSecondary = onSecondaryPressed != null;
    return Column(
      children: [
        Text(title, style: context.texts.cardTitle),
        const TGap.subtitle(),
        Text(subtitle, style: context.texts.subtitle),
        const TGap.element(),
        Row(
          children: [
            if (hasSecondary) ...[
              Expanded(
                child: Button.secondary(
                  child: Text(onSecondaryPressed!.text),
                  onPressed: onSecondaryPressed!.onPressed,
                ),
              ),
              const TGap.element(),
            ],
            Expanded(
              child: Button.primary(
                child: Text(onPrimaryPressed.text),
                onPressed: onPrimaryPressed.onPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
