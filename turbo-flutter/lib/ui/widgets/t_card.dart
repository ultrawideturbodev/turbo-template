import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_durations.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/enums/t_device_type.dart';
import 'package:turbo_template/ui/widgets/t_margin.dart';

class TCard extends StatelessWidget {
  const TCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Card(
        duration: kDurationsAnimation,
        child: child,
        borderWidth: 1,
        borderColor: context.colors.cardBorder,
        filled: true,
        fillColor: context.colors.cardBackground,
      );
}

class TCardFlex extends StatelessWidget {
  const TCardFlex({
    super.key,
    required this.deviceType,
    required this.child,
  });

  final TDeviceType deviceType;
  final Widget child;

  @override
  Widget build(BuildContext context) => switch (deviceType) {
        TDeviceType.mobile => TMargin(child: child),
        TDeviceType.tablet || TDeviceType.desktop => TMargin(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: kSizesDialogMaxWidth,
              ),
              child: TCard(child: child),
            ),
          ),
      };
}
