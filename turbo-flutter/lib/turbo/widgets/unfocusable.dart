import 'package:flutter/widgets.dart';

class Unfocusable extends StatelessWidget {
  const Unfocusable({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          onTap?.call();
          FocusScope.of(context).unfocus();
        },
        child: child,
      );
}
