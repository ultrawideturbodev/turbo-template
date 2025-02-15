import 'package:flutter/gestures.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_durations.dart';
import 'package:turbo_template/feedback/globals/g_vibrate.dart';

class TButtonAnimation extends StatefulWidget {
  const TButtonAnimation({
    super.key,
    required this.child,
    this.duration = kDurationsHover,
    this.curve = Curves.fastOutSlowIn,
    this.reverseCurve = Curves.decelerate,
    this.scaleEnd = 0.95,
    this.opacityEnd = 0.8,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;
  final Curve reverseCurve;
  final double scaleEnd;
  final double opacityEnd;

  @override
  State<TButtonAnimation> createState() => _TButtonAnimationState();
}

class _TButtonAnimationState extends State<TButtonAnimation>
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
  Widget build(BuildContext context) => Listener(
        onPointerDown: (_) => _handleTapDown(TapDownDetails(kind: PointerDeviceKind.touch)),
        onPointerUp: (_) => _handleTapUp(TapUpDetails(kind: PointerDeviceKind.touch)),
        onPointerCancel: _handlePointerCancel,
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
      );
}
