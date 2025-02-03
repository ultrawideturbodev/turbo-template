import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:turbo_template/turbo/constants/k_durations.dart';
import 'package:turbo_template/turbo/globals/g_vibrate.dart';

class OpacityScaleAnimator extends StatefulWidget {
  const OpacityScaleAnimator({
    super.key,
    required this.child,
    this.duration = kDurationsHover,
    this.curve = Curves.fastOutSlowIn,
    this.reverseCurve = Curves.decelerate,
    this.scaleEnd = 0.90,
    this.opacityEnd = 0.8,
    this.minSize = 0,
    this.padding = EdgeInsets.zero,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;
  final Curve reverseCurve;
  final double scaleEnd;
  final double opacityEnd;
  final double minSize;
  final EdgeInsetsGeometry padding;
  final HitTestBehavior hitTestBehavior;

  @override
  State<OpacityScaleAnimator> createState() => _OpacityScaleAnimatorState();
}

class _OpacityScaleAnimatorState extends State<OpacityScaleAnimator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleEnd,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve,
      ),
    );

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: widget.opacityEnd,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
    gVibrateSelection();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handlePointerCancel(PointerCancelEvent event) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Listener(
        behavior: widget.hitTestBehavior,
        onPointerDown: (_) => _handleTapDown(TapDownDetails(kind: PointerDeviceKind.touch)),
        onPointerUp: (_) => _handleTapUp(TapUpDetails(kind: PointerDeviceKind.touch)),
        onPointerCancel: _handlePointerCancel,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: widget.minSize,
            minHeight: widget.minSize,
          ),
          child: Padding(
            padding: widget.padding,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
