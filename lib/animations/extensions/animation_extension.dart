import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../data/constants/k_durations.dart';
import '../../data/extensions/duration_extension.dart';

extension ListAnimationExtension on List<Widget> {
  List<Widget> oneByOneList() {
    return animate(interval: 150.ms)
        .fadeIn(duration: 900.ms, delay: 300.ms)
        .shimmer(blendMode: BlendMode.srcOver, color: Colors.white)
        .move(
          begin: const Offset(-16, 0),
          curve: Curves.easeOutQuad,
        );
  }
}

extension AnimationExtension on Widget {
  Widget slideBottomUp({
    Duration duration = kDurationsAnimation,
    Duration? delay,
    double size = 1,
    double begin = 1,
    Curve? curve,
    double? target,
  }) =>
      RepaintBoundary(
        child: this,
      )
          .animate(
            target: target,
          )
          .slideY(
            curve: curve,
            begin: begin,
            end: 0,
            duration: duration,
            delay: delay,
          );

  Widget slideBottomUpWithFade({
    Duration duration = kDurationsAnimation,
    Duration? delay,
    double begin = 0.2,
    double end = 0,
    Curve? curve,
    double? target,
    Key? key,
  }) =>
      RepaintBoundary(
        child: this,
      )
          .animate(
            target: target,
            key: key,
          )
          .slideY(
            curve: curve,
            begin: begin,
            end: end,
            duration: duration,
            delay: delay,
          )
          .fadeIn();

  Widget fade({
    Key? key,
    Duration duration = kDurationsAnimationX0p5,
    Duration? delay,
    double? target,
    bool? autoPlay,
    Curve curve = Curves.linear,
  }) =>
      RepaintBoundary(
        child: this,
      )
          .animate(
            target: target,
            autoPlay: autoPlay,
            key: key,
          )
          .fade(
            duration: duration,
            delay: delay,
            curve: curve,
          );

  Widget fadeWithoutRepaint({
    Key? key,
    Duration duration = kDurationsAnimationX0p5,
    Duration? delay,
    double? target,
    bool? autoPlay,
    Curve curve = Curves.linear,
  }) =>
      animate(
        target: target,
        autoPlay: autoPlay,
        key: key,
      ).fade(
        duration: duration,
        delay: delay,
        curve: curve,
      );

  Widget slideBottomDownWithFade({
    Duration duration = kDurationsAnimation,
    Duration? delay,
    double begin = 0,
    double end = 1,
    Curve? curve,
    double? target,
  }) =>
      RepaintBoundary(
        child: this,
      )
          .animate(target: target)
          .slideY(
            curve: curve,
            begin: begin,
            end: end,
            duration: duration,
            delay: delay,
          )
          .fadeOut();

  Widget slideOutLeftWithFade({
    Duration duration = kDurationsAnimation,
    Duration? delay,
    double size = 1,
    double begin = 0,
    double end = -1,
    Curve? curve,
    double? target,
  }) =>
      RepaintBoundary(
        child: this,
      )
          .animate(target: target)
          .slideX(
            curve: curve,
            begin: begin,
            end: end,
            duration: duration,
            delay: delay,
          )
          .fadeOut();

  Widget slideInRightWithFade({
    Duration duration = kDurationsAnimation,
    Duration? delay,
    double size = 1,
    double begin = 1,
    Curve? curve,
    double? target,
  }) =>
      RepaintBoundary(
        child: this,
      )
          .animate(target: target)
          .slideX(
            curve: curve,
            begin: begin,
            end: 0,
            duration: duration,
            delay: delay,
          )
          .fadeIn();

  Widget slideInLeftWithFade({
    Duration duration = kDurationsAnimation,
    Duration? delay,
    double size = 1,
    double begin = -1,
    Curve? curve,
    double? target,
  }) =>
      RepaintBoundary(
        child: this,
      )
          .animate(target: target)
          .slideX(
            curve: curve,
            begin: begin,
            end: 0,
            duration: duration,
            delay: delay,
          )
          .fadeIn();

  Widget slideInRightOutLeftWithFade({
    Duration duration = kDurationsAnimation,
    Duration? slideInDelay,
    double size = 1,
    double slideInBegin = 1,
    double slideInEnd = 0,
    double slideOutBegin = 0,
    double slideOutEnd = -1,
    Curve? curve,
    double? target,
  }) =>
      RepaintBoundary(
        child: this,
      )
          .animate(
            target: target,
          )
          .slideX(
            curve: curve,
            begin: slideInBegin,
            end: slideInEnd,
            duration: duration.add(slideInDelay),
          )
          .fadeIn()
          .then()
          .slideX(
            curve: curve,
            begin: slideOutBegin,
            end: slideOutEnd,
            duration: duration,
          )
          .fadeOut();
}
