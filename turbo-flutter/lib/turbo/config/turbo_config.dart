import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:turbo_template/turbo/enums/turbo_device_type.dart';
import 'package:turbo_template/turbo/enums/turbo_theme_mode.dart';
import 'package:turbo_template/turbo/extensions/turbo_target_platform_extension.dart';

class TurboConfig {
  const TurboConfig({
    required this.animationDuration,
    required this.appPadding,
    required this.bottomSafeAreaMinimum,
    required this.buttonFontSize,
    required this.buttonFontWeight,
    required this.cardPadding,
    required this.disabledOpacity,
    required this.fontFamily,
    required this.formFieldBorderRadius,
    required this.headerFontFamily,
    required this.heightInDesign,
    required this.hoverDuration,
    required this.labelFontSize,
    required this.labelFontWeight,
    required this.onPressedOpacity,
    required this.sideNavBarWidth,
    required this.timeOutDuration,
    required this.widthInDesign,
    required this.buttonBorderRadius,
  })  : animationDurationX0p25 = animationDuration * 0.25,
        animationDurationX0p5 = animationDuration * 0.5,
        animationDurationX0p75 = animationDuration * 0.75,
        animationDurationX1p5 = animationDuration * 1.5,
        animationDurationX2 = animationDuration * 2,
        animationDurationX2p5 = animationDuration * 2.5,
        animationDurationX3 = animationDuration * 3,
        animationDurationX4 = animationDuration * 4,
        appPaddingX0p25 = appPadding * 0.25,
        appPaddingX0p5 = appPadding * 0.5,
        appPaddingX0p75 = appPadding * 0.75,
        appPaddingX1p5 = appPadding * 1.5,
        appPaddingX2 = appPadding * 2,
        appPaddingX2p5 = appPadding * 2.5,
        appPaddingX3 = appPadding * 3,
        appPaddingX4 = appPadding * 4,
        cardPaddingX0p25 = cardPadding * 0.25,
        cardPaddingX0p5 = cardPadding * 0.5,
        cardPaddingX0p75 = cardPadding * 0.75,
        cardPaddingX1p5 = cardPadding * 1.5,
        cardPaddingX2 = cardPadding * 2,
        cardPaddingX2p5 = cardPadding * 2.5,
        cardPaddingX3 = cardPadding * 3,
        cardPaddingX4 = cardPadding * 4,
        timeOutDurationX0p5 = timeOutDuration * 0.5,
        timeOutDurationX1p5 = timeOutDuration * 1.5,
        timeOutDurationX2 = timeOutDuration * 2,
        timeOutDurationX2p5 = timeOutDuration * 2.5,
        timeOutDurationX3 = timeOutDuration * 3,
        timeOutDurationX4 = timeOutDuration * 4;

  factory TurboConfig.defaultValues(
    TurboThemeMode themeMode,
    TurboDeviceType deviceType,
  ) =>
      TurboConfig(
        formFieldBorderRadius: 16,
        widthInDesign: defaultTargetPlatform.defaultHeightInDesign,
        heightInDesign: defaultTargetPlatform.defaultWidthInDesign,
        disabledOpacity: 0.5,
        appPadding: 16,
        cardPadding: 16,
        animationDuration: const Duration(milliseconds: 225),
        hoverDuration: const Duration(milliseconds: 50),
        timeOutDuration: const Duration(seconds: 10),
        onPressedOpacity: 0.6,
        fontFamily: 'Nunito',
        headerFontFamily: 'Nunito',
        bottomSafeAreaMinimum: 16,
        buttonFontSize: 14,
        buttonFontWeight: FontWeight.bold,
        labelFontSize: 14,
        labelFontWeight: FontWeight.bold,
        sideNavBarWidth: 258,
        buttonBorderRadius: 16,
      );

  final double formFieldBorderRadius;
  final double buttonBorderRadius;

  final String fontFamily;
  final String headerFontFamily;
  final double labelFontSize;
  final FontWeight labelFontWeight;
  final double buttonFontSize;
  final FontWeight buttonFontWeight;

  final double sideNavBarWidth;

  final double heightInDesign;
  final double widthInDesign;

  final double disabledOpacity;
  final double onPressedOpacity;

  final Duration hoverDuration;

  final double bottomSafeAreaMinimum;

  final double appPadding;
  final double appPaddingX0p25;
  final double appPaddingX0p5;
  final double appPaddingX0p75;
  final double appPaddingX1p5;
  final double appPaddingX2;
  final double appPaddingX2p5;
  final double appPaddingX3;
  final double appPaddingX4;

  final double cardPadding;
  final double cardPaddingX0p25;
  final double cardPaddingX0p5;
  final double cardPaddingX0p75;
  final double cardPaddingX1p5;
  final double cardPaddingX2;
  final double cardPaddingX2p5;
  final double cardPaddingX3;
  final double cardPaddingX4;

  final Duration animationDuration;
  final Duration animationDurationX0p25;
  final Duration animationDurationX0p5;
  final Duration animationDurationX0p75;
  final Duration animationDurationX1p5;
  final Duration animationDurationX2;
  final Duration animationDurationX2p5;
  final Duration animationDurationX3;
  final Duration animationDurationX4;

  final Duration timeOutDuration;
  final Duration timeOutDurationX0p5;
  final Duration timeOutDurationX1p5;
  final Duration timeOutDurationX2;
  final Duration timeOutDurationX2p5;
  final Duration timeOutDurationX3;
  final Duration timeOutDurationX4;
}
