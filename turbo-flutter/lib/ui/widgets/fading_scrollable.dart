import 'package:flutter/material.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/animations/extensions/animation_value_extension.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/state/utils/notifier.dart';

class FadingScrollable extends StatefulWidget {
  const FadingScrollable({
    Key? key,
    this.builder,
    this.color,
    this.bottomEnd = 1,
    this.bottomOffset = kSizesFormFieldHeight / 2,
    this.bottomSigma = 16,
    this.bottomSize = kSizesFormFieldHeight,
    this.bottomStart = 0,
    this.child,
    this.reverse = false,
    this.tabController,
    this.topEnd = 1,
    this.topOffset = 0,
    this.topSigma = 16,
    this.topSize = kSizesFormFieldHeight,
    this.topStart = 0,
    this.foregroundContent,
    this.backgroundContent,
    this.speed = 1.0,
    this.resetScrollingFadeNotifier,
  })  : assert(child != null || builder != null, 'Either child or builder must be provided'),
        super(key: key);

  final TabController? tabController;
  final Widget Function(bool reverse, Widget? child)? builder;
  final Widget? child;
  final bool reverse;

  final double topEnd;
  final double topOffset;
  final double topSigma;
  final double topSize;
  final double topStart;

  final double bottomEnd;
  final double bottomOffset;
  final double bottomSigma;
  final double bottomSize;
  final double bottomStart;

  final Color? color;

  final Widget? foregroundContent;
  final Widget? backgroundContent;

  final double speed;

  final Notifier? resetScrollingFadeNotifier;

  @override
  State<FadingScrollable> createState() => _FadingScrollableState();
}

class _FadingScrollableState extends State<FadingScrollable> {
  bool _shouldUpdateFadeMaskPercentage = true;

  late double topPercentage = _fetchTopPercentage(0);

  late final color = widget.color ?? context.colors.background;

  @override
  void initState() {
    super.initState();
    widget.tabController?.animation?.addListener(_onTabChange);
    widget.resetScrollingFadeNotifier?.addListener(_animateToZeroPercentage);
  }

  @override
  void dispose() {
    widget.tabController?.animation?.removeListener(_onTabChange);
    widget.resetScrollingFadeNotifier?.removeListener(_animateToZeroPercentage);
    super.dispose();
  }

  bool _didChangeTab = false;

  void _onTabChange() => _didChangeTab = true;

  void _animateToZeroPercentage() {
    if (!mounted) return;
    for (var i = 1.0; i >= 0; i -= 0.1) {
      Future.delayed(Duration(milliseconds: (50 * (1.0 - i)).toInt()), () {
        if (!mounted) return;
        setState(() => topPercentage = _fetchTopPercentage(0));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasTopOffset = widget.topOffset > 0;
    return NotificationListener(
      onNotification: onNotification,
      child: Stack(
        children: [
          if (widget.backgroundContent != null) widget.backgroundContent!,
          widget.builder?.call(
                widget.reverse,
                widget.child,
              ) ??
              widget.child!,
          SoftEdgeBlur(
            edges: [
              EdgeBlur(
                type: EdgeType.topEdge,
                size: widget.topOffset + (topPercentage * widget.topSize),
                sigma: widget.topSigma,
                tintColor: color,
                controlPoints: [
                  if (hasTopOffset)
                    ControlPoint(
                      position: 0,
                      type: ControlPointType.visible,
                    ),
                  ControlPoint(
                    position: hasTopOffset
                        ? widget.topOffset / (widget.topSize + widget.topOffset)
                        : widget.topStart,
                    type: ControlPointType.visible,
                  ),
                  ControlPoint(
                    position: widget.topEnd,
                    type: ControlPointType.transparent,
                  ),
                ],
              ),
            ],
            child: const SizedBox.expand(),
          ),
          if (widget.bottomSize > 0)
            Builder(
              builder: (context) {
                final hasBottomOffset = widget.bottomOffset > 0;
                return SoftEdgeBlur(
                  edges: [
                    EdgeBlur(
                      type: EdgeType.bottomEdge,
                      size: widget.bottomSize + widget.bottomOffset,
                      sigma: widget.bottomSigma,
                      tintColor: color,
                      controlPoints: [
                        if (hasBottomOffset)
                          ControlPoint(
                            position: 0,
                            type: ControlPointType.visible,
                          ),
                        ControlPoint(
                          position: hasBottomOffset
                              ? widget.bottomOffset / (widget.bottomSize + widget.bottomOffset)
                              : widget.bottomStart,
                          type: ControlPointType.visible,
                        ),
                        ControlPoint(
                          position: widget.bottomEnd,
                          type: ControlPointType.transparent,
                        ),
                      ],
                    ),
                  ],
                  child: const SizedBox.expand(),
                );
              },
            ),
          if (widget.foregroundContent != null) widget.foregroundContent!,
        ],
      ),
    );
  }

  bool onNotification(ScrollNotification notification) {
    if (!_shouldUpdateFadeMaskPercentage) return true;
    if (notification.metrics.axis == Axis.vertical) {
      _shouldUpdateFadeMaskPercentage = false;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          setState(() {
            final pixels = notification.metrics.pixels;
            topPercentage = _fetchTopPercentage(pixels);
          });
        },
      );
      Future.delayed(
        const Duration(milliseconds: 50),
        () => _shouldUpdateFadeMaskPercentage = true,
      );
    }
    return true;
  }

  double _changedTabPercentage = 0;

  double _fetchTopPercentage(double pixels) {
    final rPercentage = pixels / (100 / widget.speed);
    if (_didChangeTab) {
      _changedTabPercentage = topPercentage;
      final newPercentage = _pPercentage(rPercentage);
      final difference = (newPercentage - _changedTabPercentage).abs();
      if (difference < 0.2) {
        _changedTabPercentage = 0;
        _didChangeTab = false;
        return newPercentage;
      } else {
        final newPercentageIsMore = newPercentage > _changedTabPercentage;
        if (newPercentageIsMore) {
          return _changedTabPercentage + 0.1;
        } else {
          return _changedTabPercentage - 0.1;
        }
      }
    } else {
      return _pPercentage(rPercentage);
    }
  }

  double _pPercentage(double rPercentage) =>
      (widget.reverse ? rPercentage.reversed : rPercentage).clamp(0, 1);
}
