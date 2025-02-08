import 'package:shadcn_flutter/shadcn_flutter.dart';

class TurboScaffold extends StatelessWidget {
  const TurboScaffold({
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
    final safeChild = SafeArea(child: child);
    return Scaffold(
      headers: headers,
      footers: footers,
      child: safeChild,
    );
  }
}
