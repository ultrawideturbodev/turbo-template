import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:{{packageName.snakeCase()}}/ui/config/turbo_breakpoint_config.dart';
import 'package:{{packageName.snakeCase()}}/ui/enums/turbo_theme_mode.dart';
import 'package:{{packageName.snakeCase()}}/ui/models/turbo_data.dart';
import 'package:{{packageName.snakeCase()}}/ui/utils/turbo_tools.dart';
import 'package:{{packageName.snakeCase()}}/ui/widgets/turbo_provider.dart';

extension ContextExtension on BuildContext {
  RenderBox? get renderBox {
    if (!mounted) return null;
    return findRenderObject() as RenderBox?;
  }

  TurboTexts get texts => turboProvider.texts;
  TurboTools get tools => turboProvider.tools;
  TurboColors get colors => turboProvider.colors;
  TurboSizes get sizes => turboProvider.sizes;
  TurboDecorations get decorations => turboProvider.decorations;
  TurboData get data => turboProvider.data;
  TurboThemeMode get themeMode => turboProvider.themeMode;
  TurboBreakpointConfig get breakpointConfig => turboProvider.breakpointConfig;

  ThemeData get themeData => Theme.of(this);
  TurboProvider get turboProvider => TurboProvider.of(this);
  MediaQueryData get media => MediaQuery.of(this);
  NavigatorState get navigation => Navigator.of(this);
  OverlayState get overlay => Overlay.of(this, rootOverlay: true);
  TickerProviderStateMixin get vsync => navigation;
  TextScaler get textScaler => TextScaler.linear(turboProvider.tools.scaledPerWidth(1));
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
