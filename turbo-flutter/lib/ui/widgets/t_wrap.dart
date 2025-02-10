import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';

class PottyWrap<T> extends StatelessWidget {
  const PottyWrap({
    super.key,
    required this.children,
    required this.childBuilder,
    this.spacing = kSizesAppPadding,
    this.maxChildPerRow = 2,
    this.maxChildWidth = double.infinity,
    this.expandedWidth = kSizesWrapMinChildWidth * 1.5,
    this.minChildWidth = kSizesWrapMinChildWidth,
    this.emptyPlaceholderBuilder,
    this.leadingBuilder,
  });

  final List<T> children;
  final Widget Function(
      T child,
      BoxConstraints constraints,
      double spacing,
      double childWidth,
      BuildContext context,
      ) childBuilder;

  final double maxChildPerRow;
  final double maxChildWidth;
  final double expandedWidth;
  final double minChildWidth;
  final double spacing;

  final WidgetBuilder? emptyPlaceholderBuilder;
  final Widget Function(
      BoxConstraints constraints,
      double spacing,
      double childWidth,
      BuildContext context,
      )? leadingBuilder;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final rawMinChildWidth = minChildWidth + spacing;
      final biggestChildCount = ((constraints.maxWidth + spacing) / rawMinChildWidth).floor();
      final childCount = min(biggestChildCount, maxChildPerRow);
      final rawChildWidth = (constraints.maxWidth - (spacing * (childCount - 1))) / childCount;
      final childWidth = biggestChildCount > maxChildPerRow
          ? min(
        rawChildWidth,
        expandedWidth,
      )
          : rawChildWidth;
      final wrapChildren = [
        if (leadingBuilder != null)
          leadingBuilder!(
            constraints,
            spacing,
            childWidth,
            context,
          ),
        for (final child in children)
          childBuilder(
            child,
            constraints,
            spacing,
            childWidth,
            context,
          ),
      ];
      if (wrapChildren.isEmpty && emptyPlaceholderBuilder != null)
        return emptyPlaceholderBuilder!(context);
      return Wrap(
        runSpacing: spacing,
        spacing: spacing,
        children: wrapChildren,
      );
    },
  );
}
