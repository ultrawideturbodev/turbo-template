import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({
    required this.iconData,
    required this.child,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.size,
    Key? key,
  }) : super(key: key);

  final IconData iconData;
  final double? size;
  final Widget child;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Icon(
            iconData,
          ),
          Expanded(child: child),
        ],
      );
}
