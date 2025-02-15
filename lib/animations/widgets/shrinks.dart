import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../data/constants/k_durations.dart';

class HorizontalFadeShrink extends StatelessWidget {
  const HorizontalFadeShrink({
    required this.show,
    required this.child,
    Key? key,
    this.fadeDuration = kDurationsAnimation,
    this.sizeDuration = kDurationsAnimation,
    this.fadeInCurve = Curves.easeInOut,
    this.fadeOutCurve = Curves.easeInOut,
    this.sizeCurve = Curves.easeInOut,
    this.alignment = Alignment.center,
    this.hideChild,
    this.height,
  }) : super(key: key);

  final Widget child;
  final Duration fadeDuration;
  final Duration sizeDuration;
  final Curve fadeInCurve;
  final Curve fadeOutCurve;
  final Curve sizeCurve;
  final Alignment alignment;
  final bool show;
  final Widget? hideChild;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedSize(
        duration: sizeDuration,
        curve: sizeCurve,
        alignment: alignment,
        child: AnimatedSwitcher(
          duration: fadeDuration,
          switchInCurve: fadeInCurve,
          switchOutCurve: fadeOutCurve,
          child: show ? child : hideChild,
        ),
      ),
    );
  }
}

class HorizontalShrink extends StatelessWidget {
  const HorizontalShrink({
    required this.show,
    required this.child,
    Key? key,
    this.fadeDuration = kDurationsAnimation,
    this.sizeDuration = kDurationsAnimation,
    this.fadeInCurve = Curves.fastOutSlowIn,
    this.fadeOutCurve = Curves.fastOutSlowIn,
    this.sizeCurve = Curves.fastOutSlowIn,
    this.alignment = Alignment.center,
    this.hideChild,
    this.height,
  }) : super(key: key);

  final Widget child;
  final Duration fadeDuration;
  final Duration sizeDuration;
  final Curve fadeInCurve;
  final Curve fadeOutCurve;
  final Curve sizeCurve;
  final Alignment alignment;
  final bool show;
  final Widget? hideChild;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedSize(
        duration: sizeDuration,
        curve: sizeCurve,
        alignment: alignment,
        child: Stack(
          alignment: alignment,
          children: [
            AnimatedOpacity(
              opacity: show ? 1 : 0,
              duration: fadeDuration,
              curve: show ? fadeInCurve : fadeOutCurve,
              child: Align(
                alignment: alignment,
                widthFactor: show ? null : 0,
                child: child,
              ),
            ),
            if (hideChild != null)
              AnimatedOpacity(
                opacity: show ? 0 : 1,
                duration: fadeDuration,
                curve: show ? fadeInCurve : fadeOutCurve,
                child: Align(
                  alignment: alignment,
                  widthFactor: show ? 0 : null,
                  child: hideChild,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class VerticalShrink extends StatelessWidget {
  const VerticalShrink({
    required this.show,
    required this.child,
    Key? key,
    this.fadeDuration = kDurationsAnimation,
    this.sizeDuration = kDurationsAnimation,
    this.fadeInCurve = Curves.easeInOut,
    this.fadeOutCurve = Curves.easeInOut,
    this.sizeCurve = Curves.easeInOut,
    this.alignment = Alignment.topCenter,
    this.hideChild,
    this.height,
  }) : super(key: key);

  final Widget child;
  final Duration fadeDuration;
  final Duration sizeDuration;
  final Curve fadeInCurve;
  final Curve fadeOutCurve;
  final Curve sizeCurve;
  final Alignment alignment;
  final bool show;
  final Widget? hideChild;
  final double? height;

  @override
  Widget build(BuildContext context) => ClipRect(
        child: RepaintBoundary(
          child: AnimatedSize(
            duration: sizeDuration,
            curve: sizeCurve,
            alignment: alignment,
            child: Stack(
              alignment: alignment,
              children: [
                AnimatedOpacity(
                  opacity: show ? 1 : 0,
                  duration: fadeDuration,
                  curve: show ? fadeInCurve : fadeOutCurve,
                  child: Align(
                    alignment: alignment,
                    heightFactor: show ? null : 0,
                    child: child,
                  ),
                ),
                if (hideChild != null)
                  AnimatedOpacity(
                    opacity: show ? 0 : 1,
                    duration: fadeDuration,
                    curve: show ? fadeInCurve : fadeOutCurve,
                    child: Align(
                      alignment: alignment,
                      heightFactor: show ? 0 : null,
                      child: hideChild,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}
