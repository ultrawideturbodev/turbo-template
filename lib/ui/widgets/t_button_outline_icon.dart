import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/ui/config/turbo_button_config.dart';

class TButtonOutlineIcon extends StatelessWidget {
  const TButtonOutlineIcon({
    Key? key,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  factory TButtonOutlineIcon.fromConfig(TButtonIconConfig config) => TButtonOutlineIcon(
        iconData: config.iconData,
        onPressed: config.onPressed,
      );

  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Button.outline(
        child: Icon(iconData),
        onPressed: onPressed,
      );
}
