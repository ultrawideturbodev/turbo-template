import 'package:shadcn_flutter/shadcn_flutter.dart';

class TrailingIcon extends StatelessWidget {
  const TrailingIcon(
    this.iconData, {
    Key? key,
    this.color,
    this.size = 16,
  }) : super(key: key);

  final Color? color;
  final IconData iconData;
  final double size;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: 4,
        ),
        child: Icon(
          iconData,
          size: size,
          color: color,
        ),
      );
}
