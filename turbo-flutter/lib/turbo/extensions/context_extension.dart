import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/widgets/providers/turbo_provider.dart';

extension ContextExtension on BuildContext {
  RenderBox? get renderBox {
    if (!mounted) return null;
    return findRenderObject() as RenderBox?;
  }

  ThemeData get themeData => Theme.of(this);
  TurboProvider get t => TurboProvider.of(this);
  MediaQueryData get media => MediaQuery.of(this);
  NavigatorState get navigation => Navigator.of(this);
  OverlayState get overlay => Overlay.of(this, rootOverlay: true);
  TickerProviderStateMixin get vsync => navigation;
  TextScaler get textScaler => TextScaler.linear(t.tools.scaledPerWidth(1));
  ThemeData get theme => Theme.of(this);
  NavigatorState get navigator => Navigator.of(this);
  StatefulNavigationShell? get shell => StatefulNavigationShell.maybeOf(this)?.widget;

  void popNavigator<T>([T? result]) => navigator.pop(result);

  void tryPop<T>([T? result]) {
    if (mounted && canPop()) {
      pop(result);
    }
  }

  void unfocus() => FocusScope.of(this).unfocus();
}
