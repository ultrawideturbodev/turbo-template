import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/decorations/turbo_background.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';

class TurboScaffold extends StatelessWidget {
  const TurboScaffold({
    Key? key,
    this.background,
    required this.child,
    this.headers = const [],
    this.footers = const [],
  }) : super(key: key);

  final TurboBackground? background;
  final Widget child;

  final List<Widget> headers;
  final List<Widget> footers;

  @override
  Widget build(BuildContext context) {
    final safeChild = SafeArea(child: child);
    final pBackground = background ?? context.decorations.scaffoldBackground;
    return Scaffold(
      headers: headers,
      footers: footers,
      child: switch (pBackground) {
        TurboColorBackground() => safeChild,
        TurboLinearGradient() => Container(
            decoration: BoxDecoration(
              gradient: pBackground.pLinearGradient,
            ),
            child: safeChild,
          ),
        TurboRadialGradient() => Container(
            decoration: BoxDecoration(
              gradient: pBackground.pRadialGradient,
            ),
            child: safeChild,
          ),
      },
      backgroundColor: pBackground.pBackgroundColor ?? context.colors.background,
    );
  }
}
