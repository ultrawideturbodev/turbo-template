import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon(
    this.iconData, {
    this.size = 16,
    Key? key,
  }) : super(key: key);

  final IconData iconData;
  final double size;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          right: 4,
        ),
        child: Icon(
          iconData,
          size: size,
        ),
      );
}
