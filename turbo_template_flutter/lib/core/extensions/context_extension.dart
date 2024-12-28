// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/k_sizes.dart';
import '../enums/device_type.dart';
import '../enums/supported_language.dart';
import '../enums/supported_theme_mode.dart';
import '../utils/responsive_data.dart';
import '../utils/responsive_tools.dart';
import '../widgets/local_settings_provider.dart';
import '../widgets/responsive_tools_provider.dart';
import '../widgets/tu_gradient.dart';
import 'color_extension.dart';

part 'colors.dart';
part 'sizes.dart';
part 'texts.dart';
part 'ui.dart';

extension ContextExtension on BuildContext {
  _Texts get texts => _Texts(colors, sizes);
  _Ui get ui => _Ui(this);
  _Colors get colors => _Colors(this);
  _Sizes get sizes => _Sizes(this);

  DeviceType get deviceType => rData.deviceType;
  Locale get locale => Localizations.localeOf(this);
  MediaQueryData get media => MediaQuery.of(this);
  OverlayState get overlayState => Overlay.of(this, rootOverlay: true);
  RenderBox get renderBox => findRenderObject() as RenderBox;
  ResponsiveData get rData => ResponsiveToolsProvider.of(this).rData;
  ResponsiveTools get rTools => ResponsiveToolsProvider.of(this).rTools;
  String? get appCountryCode => locale.countryCode;
  String? get systemCountryCode => WidgetsBinding.instance.platformDispatcher.locale.countryCode;
  SupportedLanguage get language => LocalSettingsProvider.of(this).supportedLanguage;
  TextScaler get textScaler => TextScaler.linear(rTools.scaledPerWidth(1));
  ThemeData get theme => Theme.of(this);
  NavigatorState get navigator => Navigator.of(this);
  StatefulNavigationShell? get shell => StatefulNavigationShell.maybeOf(this)?.widget;
  TickerProviderStateMixin get vsync => navigator;
  void closeDrawer() => Scaffold.of(this).closeDrawer();
  void openDrawer() => Scaffold.of(this).openDrawer();
  void popNavigator<T>([T? result]) => navigator.pop(result);

  void tryPop() {
    if (mounted) {
      pop();
    }
  }

  void unfocus() => FocusScope.of(this).unfocus();

  /// Provides a design scaled value based on given [value], [width] and given [screenWidthInDesign].
  ///
  /// Where [screenWidthInDesign] is the width of the screen in your original UI design file.
  double scaledPerWidth({
    required double value,
    required double screenWidthInDesign,
    double speed = 1.0,
  }) {
    final widthScale = sizes.width / screenWidthInDesign;
    final adjustedScale = pow(widthScale, speed);
    return value * adjustedScale;
  }

  /// Provides a design scaled value based on given [value], [width] and given [screenWidthInDesign].
  ///
  /// Where [screenHeightInDesign] is the height of the screen in your original UI design file.
  double scaledPerHeight({
    required double value,
    required double screenHeightInDesign,
    double speed = 1.0,
  }) {
    final heightScale = sizes.height / screenHeightInDesign;
    final adjustedScale = pow(heightScale, speed);
    return value * adjustedScale;
  }

  /// Provides a design scaled value based on given [value], [width], [height]
  /// and given [screenWidthInDesign] and [screenHeightInDesign].
  ///
  /// Where [screenWidthInDesign] is the width of the screen in your original UI design file.
  /// Where [screenHeightInDesign] is the height of the screen in your original UI design file.
  double scaledPerWidthAndHeight({
    required double value,
    required double screenWidthInDesign,
    required double screenHeightInDesign,
    double speed = 1.0,
  }) {
    final widthScale = sizes.width / screenWidthInDesign;
    final heightScale = sizes.height / screenHeightInDesign;
    final scale = min(widthScale, heightScale);
    final adjustedScale = pow(scale, speed);
    return value * adjustedScale;
  }

  void printDesignWidthAndHeight() {
    if (kDebugMode) {
      print('''


screenWidthInDesign: ${sizes.width},
screenHeightInDesign: ${sizes.height},
''');
    }
  }
}
