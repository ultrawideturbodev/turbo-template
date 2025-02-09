import 'package:shadcn_flutter/shadcn_flutter.dart';

class TScaffold extends StatelessWidget {
  const TScaffold({
    Key? key,
    required this.child,
    this.headers = const [],
    this.footers = const [],
  }) : super(key: key);

  final Widget child;

  final List<Widget> headers;
  final List<Widget> footers;

  @override
  Widget build(BuildContext context) {
    final safeChild = SafeArea(child: child, bottom: false);
    return Scaffold(
      headers: headers,
      footers: footers,
      child: safeChild,
      floatingFooter: true,
    );
  }
}
