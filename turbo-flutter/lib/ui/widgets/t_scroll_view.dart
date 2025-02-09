import 'package:flutter/widgets.dart';

class TScrollView extends StatelessWidget {
  const TScrollView({
    Key? key,
    required this.child,
    this.scrollController,
  }) : super(key: key);

  final Widget child;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    controller: scrollController,
    physics: const BouncingScrollPhysics(),
    child: child,
  );
}
