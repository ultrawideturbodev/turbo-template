import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/constants/k_durations.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';

class TurboCard extends StatelessWidget {
  const TurboCard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Card(
        duration: kDurationsAnimation,
        padding: context.sizes.cardPadding,
        child: child,
        borderWidth: 1,
        borderColor: context.colors.cardBorder,
      );
}
