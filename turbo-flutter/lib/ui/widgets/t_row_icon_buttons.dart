import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/ui/config/turbo_button_config.dart';
import 'package:turbo_template/ui/widgets/t_row.dart';

class TRowIconButtons extends StatelessWidget {
  const TRowIconButtons({
    Key? key,
    required this.buttons,
  }) : super(key: key);

  final List<TButtonIconConfig> buttons;

  @override
  Widget build(BuildContext context) => TRow(
        children: [
          for (final config in buttons) ...[
            Button.outline(child: Icon(config.iconData), onPressed: config.onPressed),
          ],
        ],
      );
}
