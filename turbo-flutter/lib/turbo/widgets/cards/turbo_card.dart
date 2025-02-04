import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';

class TurboCard extends StatelessWidget {
  const TurboCard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Card(
        padding: context.t.decorations.cardPadding,
        child: child,
        borderWidth: 1,
        borderColor: context.t.colors.cardBorder,
        boxShadow: context.t.decorations.cardShadow,
      );
}
