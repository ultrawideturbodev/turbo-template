import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/config/turbo_button_config.dart';
import 'package:turbo_template/turbo/constants/k_durations.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/widgets/t_gap.dart';

sealed class TurboCardType {}

class TurboChildCard extends TurboCardType {
  TurboChildCard({
    required this.child,
  });

  final Widget child;
}

class TurboCtaCard extends TurboCardType {
  TurboCtaCard({
    required this.title,
    required this.subtitle,
    required this.onPrimaryPressed,
    this.onSecondaryPressed,
  });

  final String title;
  final String subtitle;
  final TurboTextButtonConfig onPrimaryPressed;
  final TurboTextButtonConfig? onSecondaryPressed;
}

class TurboCard extends StatelessWidget {
  const TurboCard({Key? key, required this.type}) : super(key: key);

  final TurboCardType type;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      duration: kDurationsAnimation,
      child: switch (type) {
        TurboChildCard(child: final c) => c,
        TurboCtaCard(
          title: final title,
          subtitle: final subtitle,
          onPrimaryPressed: final onPrimaryPressed,
          onSecondaryPressed: final onSecondaryPressed,
        ) =>
          Column(
            children: [
              Text(title, style: context.texts.cardTitle),
              const TGap.subtitle(),
              Text(subtitle, style: context.texts.subtitle),
              const TGap.element(),
              Row(
                children: [
                  if (onSecondaryPressed != null) ...[
                    Expanded(
                      child: Button.secondary(
                        child: Text(onSecondaryPressed.text),
                        onPressed: onSecondaryPressed.onPressed,
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
          ),
      },
      borderWidth: 1,
      borderColor: context.colors.cardBorder,
    );
    return card;
  }
}
