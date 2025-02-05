import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/models/turbo_background.dart';

class TurboScaffold extends StatelessWidget {
  const TurboScaffold({
    Key? key,
    this.background,
    required this.child,
  }) : super(key: key);

  final TurboBackground? background;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final safeChild = SafeArea(child: child);
    final pBackground = background ?? TurboColorBackground(color: context.t.colors.background);
    return Scaffold(
      child: switch (pBackground) {
        TurboColorBackground() => safeChild,
        TurboGradientBackground() => Stack(
            children: [
              Positioned.fill(
                top: -100,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: pBackground.radialGradient,
                  ),
                ),
              ),
              safeChild,
            ],
          ),
      },
      backgroundColor: switch (pBackground) {
        TurboColorBackground(color: final c) => c,
        TurboGradientBackground() => null,
      },
    );
  }
}
