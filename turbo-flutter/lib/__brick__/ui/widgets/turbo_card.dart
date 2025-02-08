import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:{{packageName.snakeCase()}}/ui/abstracts/turbo_button_type.dart';
import 'package:{{packageName.snakeCase()}}/data/constants/k_durations.dart';
import 'package:{{packageName.snakeCase()}}/state/extensions/context_extension.dart';
import 'package:{{packageName.snakeCase()}}/ui/widgets/turbo_gap.dart';

sealed class TCardType {}

class TChildCard extends TCardType {
  TChildCard({
    required this.child,
  });

  final Widget child;
}

class TCtaCard extends TCardType {
  TCtaCard({
    required this.title,
    required this.subtitle,
    required this.onPrimaryPressed,
    this.onSecondaryPressed,
  });

  final String title;
  final String subtitle;
  final TTextButton onPrimaryPressed;
  final TTextButton? onSecondaryPressed;
}

class TurboCard extends StatelessWidget {
  const TurboCard({Key? key, required this.type}) : super(key: key);

  final TCardType type;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      duration: kDurationsAnimation,
      child: switch (type) {
        TChildCard(child: final c) => c,
        TCtaCard(
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
