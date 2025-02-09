import 'package:flutter/widgets.dart';
import 'package:turbo_template/ui/widgets/margin.dart';

class BottomSafeArea extends StatelessWidget {
  const BottomSafeArea({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Margin(child: child));
  }
}
