// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants/k_durations.dart';
import '../extensions/context_extension.dart';

const Duration _kMenuDuration = kDurationsAnimation;
const double _kMenuCloseIntervalEnd = 2.0 / 3.0;
const double _kMenuScreenPadding = 8.0;

abstract class PopupMenuEntry<T> extends StatefulWidget {
  const PopupMenuEntry({Key? key}) : super(key: key);
  bool represents(T? value);
}

class _MenuItem extends SingleChildRenderObjectWidget {
  const _MenuItem({
    Key? key,
    required this.onLayout,
    required Widget? child,
  }) : super(key: key, child: child);

  final ValueChanged<Size> onLayout;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMenuItem(onLayout);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderMenuItem renderObject) {
    renderObject.onLayout = onLayout;
  }
}

class _RenderMenuItem extends RenderShiftedBox {
  _RenderMenuItem(this.onLayout, [RenderBox? child]) : super(child);

  ValueChanged<Size> onLayout;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child == null) {
      return Size.zero;
    }
    return child!.getDryLayout(constraints);
  }

  @override
  void performLayout() {
    if (child == null) {
      size = Size.zero;
    } else {
      child!.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child!.size);
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset = Offset.zero;
    }
    onLayout(size);
  }
}

class HijackedPopupMenuItem<T> extends PopupMenuEntry<T> {
  const HijackedPopupMenuItem({
    Key? key,
    this.value,
    this.borderRadius,
    required this.child,
  }) : super(key: key);

  final BorderRadius? borderRadius;
  final T? value;
  final Widget? child;

  @override
  bool represents(T? value) => value == this.value;

  @override
  HijackedPopupMenuItemState<T, HijackedPopupMenuItem<T>> createState() =>
      HijackedPopupMenuItemState<T, HijackedPopupMenuItem<T>>();
}

class HijackedPopupMenuItemState<T, W extends HijackedPopupMenuItem<T>> extends State<W> {
  @protected
  Widget? buildChild() => widget.child;

  @protected
  void onTap() {
    Navigator.pop<T>(context, widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
        button: true,
        child: InkWell(
          borderRadius: widget.borderRadius,
          splashColor: context.t.colors.dropdownHover,
          hoverColor: context.t.colors.dropdownHover,
          onTap: onTap,
          child: buildChild(),
        ),
      ),
    );
  }
}

class _PopupMenu<T> extends StatelessWidget {
  const _PopupMenu({
    Key? key,
    required this.route,
    required this.semanticLabel,
    required this.itemBorderRadius,
  }) : super(key: key);

  final _PopupMenuRoute<T> route;
  final String? semanticLabel;
  final double itemBorderRadius;

  @override
  Widget build(BuildContext context) {
    final double unit =
        1.0 / (route.items.length + 1.5); // 1.0 for the width and 0.5 for the last item's fade.
    final List<Widget> children = <Widget>[];
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);

    for (int i = 0; i < route.items.length; i += 1) {
      final double start = (i + 1) * unit;
      final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
      final CurvedAnimation opacity = CurvedAnimation(
        parent: route.animation!,
        curve: Interval(start, end),
      );
      children.add(
        _MenuItem(
          onLayout: (Size size) {
            route.itemSizes[i] = size;
          },
          child: FadeTransition(
            opacity: opacity,
            child: route.items[i],
          ),
        ),
      );
    }

    return AnimatedBuilder(
      animation: route.animation!,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: CurveTween(curve: const Interval(0.0, 1.0 / 3.0)).evaluate(route.animation!),
          child: Material(
            shape: route.shape ?? popupMenuTheme.shape,
            color: route.color ?? popupMenuTheme.color,
            type: MaterialType.card,
            elevation: route.elevation ?? popupMenuTheme.elevation ?? 8.0,
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              widthFactor: CurveTween(curve: Interval(0.0, unit)).evaluate(route.animation!),
              heightFactor: CurveTween(curve: Interval(0.0, unit * route.items.length))
                  .evaluate(route.animation!),
              child: child,
            ),
          ),
        );
      },
      child: IntrinsicWidth(
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: semanticLabel,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(itemBorderRadius),
            child: SingleChildScrollView(
              child: ListBody(children: children),
            ),
          ),
        ),
      ),
    );
  }
}

// Positioning of the menu on the screen.
class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteLayout(
    this.position,
    this.itemSizes,
    this.selectedItemIndex,
    this.textDirection,
    this.topPadding,
    this.bottomPadding,
  );

  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  // The sizes of each item are computed when the menu is laid out, and before
  // the route is laid out.
  List<Size?> itemSizes;

  // The index of the selected item, or null if HijackedPopupMenuButton.initialValue
  // was not specified.
  final int? selectedItemIndex;

  // Whether to prefer going to the left or to the right.
  final TextDirection textDirection;

  // Top padding of unsafe area.
  final double topPadding;

  // Bottom padding of unsafe area.
  final double bottomPadding;

  // We put the child wherever position specifies, so long as it will fit within
  // the specified parent size padded (inset) by 8. If necessary, we adjust the
  // child's position so that it fits.

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The menu can be at most the size of the overlay minus 8.0 pixels in each
    // direction.
    return BoxConstraints.loose(constraints.biggest).deflate(
      const EdgeInsets.all(_kMenuScreenPadding) +
          EdgeInsets.only(top: topPadding, bottom: bottomPadding),
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    final double buttonHeight = size.height - position.top - position.bottom;
    // Find the ideal vertical position.
    double y = position.top;
    if (selectedItemIndex != null) {
      double selectedItemOffset = 0;
      for (int index = 0; index < selectedItemIndex!; index += 1)
        selectedItemOffset += itemSizes[index]!.height;
      selectedItemOffset += itemSizes[selectedItemIndex!]!.height / 2;
      y = y + buttonHeight / 2.0 - selectedItemOffset;
    }

    // Find the ideal horizontal position.
    double x;
    if (position.left > position.right) {
      // Menu button is closer to the right edge, so grow to the left, aligned to the right edge.
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      // Menu button is closer to the left edge, so grow to the right, aligned to the left edge.
      x = position.left;
    } else {
      // Menu button is equidistant from both edges, so grow in reading direction.
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    // Avoid going outside an area defined as the rectangle 8.0 pixels from the
    // edge of the screen in every direction.
    if (x < _kMenuScreenPadding)
      x = _kMenuScreenPadding;
    else if (x + childSize.width > size.width - _kMenuScreenPadding)
      x = size.width - childSize.width - _kMenuScreenPadding;
    if (y < _kMenuScreenPadding + topPadding)
      y = _kMenuScreenPadding + topPadding;
    else if (y + childSize.height > size.height - _kMenuScreenPadding - bottomPadding)
      y = size.height - bottomPadding - _kMenuScreenPadding - childSize.height;
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    // If called when the old and new itemSizes have been initialized then
    // we expect them to have the same length because there's no practical
    // way to change length of the items list once the menu has been shown.
    assert(itemSizes.length == oldDelegate.itemSizes.length);

    return position != oldDelegate.position ||
        selectedItemIndex != oldDelegate.selectedItemIndex ||
        textDirection != oldDelegate.textDirection ||
        !listEquals(itemSizes, oldDelegate.itemSizes) ||
        topPadding != oldDelegate.topPadding ||
        bottomPadding != oldDelegate.bottomPadding;
  }
}

class _PopupMenuRoute<T> extends PopupRoute<T> {
  _PopupMenuRoute({
    required this.position,
    required this.items,
    this.elevation,
    required this.barrierLabel,
    this.semanticLabel,
    this.shape,
    this.color,
    required this.capturedThemes,
    required this.itemBorderRadius,
  }) : itemSizes = List<Size?>.filled(items.length, null);

  final RelativeRect position;
  final List<PopupMenuEntry<T>> items;
  final List<Size?> itemSizes;
  final double? elevation;
  final String? semanticLabel;
  final ShapeBorder? shape;
  final Color? color;
  final CapturedThemes capturedThemes;
  final double itemBorderRadius;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kMenuCloseIntervalEnd),
    );
  }

  @override
  Duration get transitionDuration => _kMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    int? selectedItemIndex;

    final Widget menu = _PopupMenu<T>(
      route: this,
      semanticLabel: semanticLabel,
      itemBorderRadius: itemBorderRadius,
    );

    return Builder(
      builder: (BuildContext context) {
        final MediaQueryData mediaQuery = MediaQuery.of(context);
        return CustomSingleChildLayout(
          delegate: _PopupMenuRouteLayout(
            position,
            itemSizes,
            selectedItemIndex,
            Directionality.of(context),
            mediaQuery.padding.top,
            mediaQuery.padding.bottom,
          ),
          child: capturedThemes.wrap(menu),
        );
      },
    );
  }
}

Future<T?> showMenu<T>({
  required BuildContext context,
  required RelativeRect position,
  required List<PopupMenuEntry<T>> items,
  double? elevation,
  String? semanticLabel,
  ShapeBorder? shape,
  Color? color,
  bool useRootNavigator = false,
  required double itemBorderRadius,
}) {
  assert(items.isNotEmpty);
  assert(debugCheckHasMaterialLocalizations(context));

  switch (Theme.of(context).platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      break;
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      semanticLabel ??= MaterialLocalizations.of(context).popupMenuLabel;
  }

  final NavigatorState navigator = Navigator.of(context, rootNavigator: useRootNavigator);
  return navigator.push(
    _PopupMenuRoute<T>(
      position: position,
      items: items,
      elevation: elevation,
      semanticLabel: semanticLabel,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      shape: shape,
      color: color,
      itemBorderRadius: itemBorderRadius,
      capturedThemes: InheritedTheme.capture(
        from: context,
        to: navigator.context,
      ),
    ),
  );
}

typedef HijackedPopupMenuItemSelected<T> = void Function(T? value);

typedef PopupMenuCanceled = void Function();

typedef HijackedPopupMenuItemBuilder<T> = List<PopupMenuEntry<T>> Function(BuildContext context);

class HijackedPopupMenuButton<T> extends StatefulWidget {
  const HijackedPopupMenuButton({
    Key? key,
    required this.itemBuilder,
    required this.builder,
    this.onSelected,
    this.elevation,
    this.backgroundColor,
    this.itemBorderRadius = 16,
    required this.clickOffset,
    required this.buttonKey,
  }) : super(key: key);

  final HijackedPopupMenuItemBuilder<T> itemBuilder;
  final HijackedPopupMenuItemSelected<T>? onSelected;
  final double? elevation;
  final Widget Function(BuildContext context, Function(Offset globalPosition) showMenu) builder;
  final Color? backgroundColor;
  final double itemBorderRadius;
  final GlobalKey buttonKey;
  final Offset clickOffset;

  @override
  HijackedPopupMenuButtonState<T> createState() => HijackedPopupMenuButtonState<T>();
}

class HijackedPopupMenuButtonState<T> extends State<HijackedPopupMenuButton<T>> {
  void showButtonMenu(Offset globalPosition) {
    final RenderBox button = widget.buttonKey.currentContext!.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;

    final Offset tapPosition = globalPosition + widget.clickOffset;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        tapPosition - Offset(0, button.size.height),
        tapPosition + Offset(0, button.size.height),
      ),
      Offset.zero & overlay.size,
    );
    final List<PopupMenuEntry<T>> items = widget.itemBuilder(context);
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    // Only show the menu if there is something to show
    if (items.isNotEmpty) {
      showMenu<T?>(
        context: context,
        elevation: widget.elevation ?? popupMenuTheme.elevation,
        items: items,
        position: position,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.itemBorderRadius),
          side: BorderSide(color: context.t.colors.border),
        ),
        color: widget.backgroundColor ?? context.t.colors.background,
        itemBorderRadius: widget.itemBorderRadius,
        useRootNavigator: true,
      ).then<void>((T? newValue) {
        if (!mounted) return null;
        widget.onSelected?.call(newValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return widget.builder(context, showButtonMenu);
  }
}
