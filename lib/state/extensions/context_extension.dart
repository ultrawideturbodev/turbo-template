import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/ui/config/turbo_breakpoint_config.dart';
import 'package:turbo_template/ui/enums/t_device_type.dart';
import 'package:turbo_template/ui/enums/t_theme_mode.dart';
import 'package:turbo_template/ui/models/t_data.dart';
import 'package:turbo_template/ui/utils/t_tools.dart';
import 'package:turbo_template/ui/widgets/t_provider.dart';

extension ContextExtension on BuildContext {
  RenderBox? get renderBox {
    if (!mounted) return null;
    return findRenderObject() as RenderBox?;
  }

  TTexts get texts => turboProvider.texts;
  TTools get tools => turboProvider.tools;
  TurboColors get colors => turboProvider.colors;
  TSizes get sizes => turboProvider.sizes;
  TDecorations get decorations => turboProvider.decorations;
  TData get data => turboProvider.data;
  TThemeMode get themeMode => turboProvider.themeMode;
  TBreakpointConfig get breakpointConfig => turboProvider.breakpointConfig;
  TDeviceType get deviceType => turboProvider.data.deviceType;

  ThemeData get themeData => Theme.of(this);
  TProvider get turboProvider => TProvider.of(this);
  MediaQueryData get media => MediaQuery.of(this);
  NavigatorState get navigation => Navigator.of(this);
  OverlayState get overlay => Overlay.of(this, rootOverlay: true);
  TickerProviderStateMixin get vsync => navigation;
  TextScaler get textScaler => TextScaler.linear(turboProvider.tools.scaledPerWidth(1));
  ThemeData get theme => Theme.of(this);
  NavigatorState get navigator => Navigator.of(this);
  StatefulNavigationShell? get shell => StatefulNavigationShell.maybeOf(this)?.widget;
  double get maxWidth => media.size.width;
  double get maxHeight => media.size.height;

  void popNavigator<T>([T? result]) => navigator.pop(result);

  void tryPop<T>([T? result]) {
    if (mounted && canPop()) {
      pop(result);
    }
  }

  void unfocus() => FocusScope.of(this).unfocus();
}
