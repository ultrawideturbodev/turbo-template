import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
  Widget build(BuildContext context) => ShadCard(
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
  Widget build(BuildContext context) => const ShadCard();
}
