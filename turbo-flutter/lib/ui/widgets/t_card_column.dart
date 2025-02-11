import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/config/turbo_button_config.dart';
import 'package:turbo_template/ui/widgets/t_column.dart';
import 'package:turbo_template/ui/widgets/t_gap.dart';
import 'package:turbo_template/ui/widgets/t_row.dart';

class TCardColumn extends StatelessWidget {
  const TCardColumn({
    super.key,
    required this.title,
    required this.subtitle,
    this.children = const [],
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.trailingTitle,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final TButtonTextConfig? onPrimaryPressed;
  final TButtonTextConfig? onSecondaryPressed;
  final Widget? trailingTitle;

  @override
  Widget build(BuildContext context) {
    final hasSecondary = onSecondaryPressed != null;
    final hasPrimary = onPrimaryPressed != null;
    return TColumn(
      spacing: 0,
      children: [
        TRow(
          spacing: 0,
          children: [
            Expanded(
              child: TColumn(
                spacing: 0,
                children: [
                  Text(title, style: context.texts.cardTitle),
                  const TGap.subtitle(),
                  Text(subtitle, style: context.texts.subtitle),
                  if (children.isNotEmpty || hasSecondary || hasPrimary) const TGap.element(),
                ],
              ),
            ),
            if (trailingTitle != null) ...[
              const TGap.element(),
              trailingTitle!,
            ],
          ],
        ),
        if (children.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
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
            if (hasPrimary)
              Expanded(
                child: Button.primary(
                  child: Text(onPrimaryPressed!.text),
                  onPressed: onPrimaryPressed!.onPressed,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
