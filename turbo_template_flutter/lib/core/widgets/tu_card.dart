import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/k_durations.dart';
import '../constants/k_sizes.dart';
import '../extensions/context_extension.dart';

enum TuCardBackground {
  topLeftTransparantGradient,
  topLeftColorGradient,
  topCenterTransparantGradient,
  topCenterColorGradient,
  redGradient,
  blueGradient,
  appBackground,
  transparant,
}

enum TuCardBorder {
  none,
  transparantLight,
  solidLight,
  dark,
  selected,
}

class TuCard extends StatelessWidget {
  const TuCard({
    Key? key,
    required this.child,
    this.borderRadius = kSizesCardRadius,
    this.clipBehavior = Clip.none,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.background = TuCardBackground.topLeftTransparantGradient,
    this.border = TuCardBorder.transparantLight,
  }) : super(key: key);

  final double borderRadius;
  final Clip clipBehavior;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  final Widget child;
  final TuCardBackground background;
  final TuCardBorder border;

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        height: height,
        width: width,
        padding: padding,
        clipBehavior: clipBehavior,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: context.ui.cardShadow,
          color: switch (background) {
            TuCardBackground.appBackground => context.colors.background,
            (_) => null,
          },
          gradient: switch (background) {
            TuCardBackground.topLeftTransparantGradient =>
              context.ui.topLeftTransparantCardGradient,
            TuCardBackground.topCenterTransparantGradient =>
              context.ui.topCenterTransparantCardGradient,
            TuCardBackground.redGradient => context.ui.primaryButtonGradient,
            TuCardBackground.blueGradient => context.ui.secondaryButtonGradient,
            TuCardBackground.transparant => null,
            TuCardBackground.topLeftColorGradient => context.ui.topLeftColorCardGradient,
            TuCardBackground.topCenterColorGradient => context.ui.topCenterColorCardGradient,
            TuCardBackground.appBackground => null,
          },
          border: switch (border) {
            TuCardBorder.transparantLight => context.ui.transparantLightBorder,
            TuCardBorder.solidLight => context.ui.solidLightBorder,
            TuCardBorder.dark => context.ui.darkBorder,
            TuCardBorder.selected => context.ui.selectedBorder,
            TuCardBorder.none => null,
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
    this.background = TuCardBackground.topLeftTransparantGradient,
    this.border = TuCardBorder.transparantLight,
  }) : super(key: key);

  final BorderRadius borderRadius;
  final Clip clipBehavior;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  final Widget child;
  final TuCardBackground background;
  final TuCardBorder border;

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
          boxShadow: context.ui.cardShadow,
          color: switch (background) {
            TuCardBackground.appBackground => context.colors.background,
            (_) => null,
          },
          gradient: switch (background) {
            TuCardBackground.topLeftTransparantGradient =>
              context.ui.topLeftTransparantCardGradient,
            TuCardBackground.topCenterTransparantGradient =>
              context.ui.topCenterTransparantCardGradient,
            TuCardBackground.redGradient => context.ui.primaryButtonGradient,
            TuCardBackground.blueGradient => context.ui.secondaryButtonGradient,
            TuCardBackground.transparant => null,
            TuCardBackground.topLeftColorGradient => context.ui.topLeftColorCardGradient,
            TuCardBackground.topCenterColorGradient => context.ui.topCenterColorCardGradient,
            TuCardBackground.appBackground => null,
          },
          border: switch (border) {
            TuCardBorder.transparantLight => context.ui.transparantLightBorder,
            TuCardBorder.solidLight => context.ui.solidLightBorder,
            TuCardBorder.dark => context.ui.darkBorder,
            TuCardBorder.selected => context.ui.selectedBorder,
            TuCardBorder.none => null,
          },
        ),
        child: child,
      );
}
