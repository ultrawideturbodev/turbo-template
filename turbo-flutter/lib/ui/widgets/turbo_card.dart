import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_durations.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/abstracts/turbo_button_type.dart';
import 'package:turbo_template/ui/enums/turbo_device_type.dart';
import 'package:turbo_template/ui/widgets/margin.dart';
import 'package:turbo_template/ui/widgets/turbo_gap.dart';

class TurboCard extends StatelessWidget {
  const TurboCard({super.key, required this.type});

  final TCardType type;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      duration: kDurationsAnimation,
      child: TurboCardChild(type: type),
      borderWidth: 1,
      borderColor: context.colors.cardBorder,
    );
    return card;
  }
}

class TurboCardChild extends StatelessWidget {
  const TurboCardChild({
    Key? key,
    required this.type,
  }) : super(key: key);

  final TCardType type;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
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
    };
  }
}

class TurboDeviceTypeCard extends StatelessWidget {
  const TurboDeviceTypeCard({
    super.key,
    required this.type,
    required this.deviceType,
  });

  final TurboDeviceType deviceType;
  final TCardType type;

  @override
  Widget build(BuildContext context) => switch (deviceType) {
    TurboDeviceType.mobile => Margin(child: TurboCardChild(type: type)),
    TurboDeviceType.tablet || TurboDeviceType.desktop => Margin(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: kSizesDialogMaxWidth,
        ),
        child: TurboCard(type: type),
      ),
    ),
  };
}

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
