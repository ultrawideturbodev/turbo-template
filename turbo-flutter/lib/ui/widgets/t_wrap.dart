import 'package:flutter/widgets.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';

class TWrap extends StatelessWidget {
  const TWrap({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: kSizesElementGap,
      runSpacing: kSizesElementGap * 0.75,
      children: children,
    );
  }
}
