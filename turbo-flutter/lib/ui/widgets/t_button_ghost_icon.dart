import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/ui/config/turbo_button_config.dart';

class TButtonGhostIcon extends StatelessWidget {
  const TButtonGhostIcon({
    Key? key,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  factory TButtonGhostIcon.fromConfig(TButtonIconConfig config) => TButtonGhostIcon(
    iconData: config.iconData,
    onPressed: config.onPressed,
  );

  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Button.ghost(
    child: Icon(iconData),
    onPressed: onPressed,
  );
}
