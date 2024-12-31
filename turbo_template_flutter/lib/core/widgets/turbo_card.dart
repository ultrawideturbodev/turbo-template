import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/k_durations.dart';
import '../constants/k_sizes.dart';
import '../extensions/context_extension.dart';

enum TurboCardBackground {
  topLeftTransparantGradient,
  topLeftColorGradient,
  topCenterTransparantGradient,
  topCenterColorGradient,
  redGradient,
  blueGradient,
  appBackground,
  transparant,
}

enum TurboCardBorder {
  none,
  transparantLight,
  solidLight,
  dark,
  selected,
}

class TurboCard extends StatelessWidget {
  const TurboCard({
    Key? key,
    required this.child,
    this.borderRadius = kSizesCardRadius,
    this.clipBehavior = Clip.none,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.background = TurboCardBackground.topLeftTransparantGradient,
    this.border = TurboCardBorder.transparantLight,
  }) : super(key: key);

  final double borderRadius;
  final Clip clipBehavior;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  final Widget child;
  final TurboCardBackground background;
  final TurboCardBorder border;

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        height: height,
        width: width,
        padding: padding,
        clipBehavior: clipBehavior,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: context.tUi.cardShadow,
          color: switch (background) {
            TurboCardBackground.appBackground => context.tColors.background,
            (_) => null,
          },
          gradient: switch (background) {
            TurboCardBackground.topLeftTransparantGradient =>
              context.tUi.topLeftTransparantCardGradient,
            TurboCardBackground.topCenterTransparantGradient =>
              context.tUi.topCenterTransparantCardGradient,
            TurboCardBackground.redGradient => context.tUi.primaryButtonGradient,
            TurboCardBackground.blueGradient => context.tUi.secondaryButtonGradient,
            TurboCardBackground.transparant => null,
            TurboCardBackground.topLeftColorGradient => context.tUi.topLeftColorCardGradient,
            TurboCardBackground.topCenterColorGradient => context.tUi.topCenterColorCardGradient,
            TurboCardBackground.appBackground => null,
          },
          border: switch (border) {
            TurboCardBorder.transparantLight => context.tUi.transparantLightBorder,
            TurboCardBorder.solidLight => context.tUi.solidLightBorder,
            TurboCardBorder.dark => context.tUi.darkBorder,
            TurboCardBorder.selected => context.tUi.selectedBorder,
            TurboCardBorder.none => null,
          },
        ),
        child: child,
      );
}

class TuAnimatedCard extends StatelessWidget {
  const TuAnimatedCard({
    Key? key,
    required this.child,
    required this.borderRadius,
    this.clipBehavior = Clip.none,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.background = TurboCardBackground.topLeftTransparantGradient,
    this.border = TurboCardBorder.transparantLight,
  }) : super(key: key);

  final BorderRadius borderRadius;
  final Clip clipBehavior;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  final Widget child;
  final TurboCardBackground background;
  final TurboCardBorder border;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: kDurationsAnimation,
        margin: margin,
        height: height,
        width: width,
        padding: padding,
        clipBehavior: clipBehavior,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: context.tUi.cardShadow,
          color: switch (background) {
            TurboCardBackground.appBackground => context.tColors.background,
            (_) => null,
          },
          gradient: switch (background) {
            TurboCardBackground.topLeftTransparantGradient =>
              context.tUi.topLeftTransparantCardGradient,
            TurboCardBackground.topCenterTransparantGradient =>
              context.tUi.topCenterTransparantCardGradient,
            TurboCardBackground.redGradient => context.tUi.primaryButtonGradient,
            TurboCardBackground.blueGradient => context.tUi.secondaryButtonGradient,
            TurboCardBackground.transparant => null,
            TurboCardBackground.topLeftColorGradient => context.tUi.topLeftColorCardGradient,
            TurboCardBackground.topCenterColorGradient => context.tUi.topCenterColorCardGradient,
            TurboCardBackground.appBackground => null,
          },
          border: switch (border) {
            TurboCardBorder.transparantLight => context.tUi.transparantLightBorder,
            TurboCardBorder.solidLight => context.tUi.solidLightBorder,
            TurboCardBorder.dark => context.tUi.darkBorder,
            TurboCardBorder.selected => context.tUi.selectedBorder,
            TurboCardBorder.none => null,
          },
        ),
        child: child,
      );
}
