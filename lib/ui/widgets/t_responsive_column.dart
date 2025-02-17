import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/ui/extensions/build_context_extensions.dart';

/// A responsive layout widget that automatically arranges children in columns based on available width
class TResponsiveColumn extends StatelessWidget {
  const TResponsiveColumn({
    super.key,
    required this.children,
    this.maxWidth = kSizesDialogMaxWidth * 2,
    this.maxColumns = 4,
    this.crossAxisSpacing = 24,
    this.spacing = kSizesSpacingGap,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : assert(maxColumns > 0, 'maxColumns must be greater than 0');

  /// The widgets to be displayed in the columns
  final List<Widget> children;

  /// The maximum total width before splitting into columns
  final double maxWidth;

  /// The maximum number of columns to display
  final int maxColumns;

  /// The spacing between columns
  final double crossAxisSpacing;

  /// The spacing between elements
  final double spacing;

  /// The alignment of the content
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columnCount = _calculateColumnCount(width);
        final content = columnCount == 1
            ? Column(
                crossAxisAlignment: crossAxisAlignment,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: spacing,
                children: children,
              )
            : _buildMultiColumn(columnCount);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: content,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMultiColumn(int columnCount) {
    // Initialize empty columns
    final columns = List<List<Widget>>.generate(columnCount, (_) => []);

    // Distribute items row by row
    for (var i = 0; i < children.length; i++) {
      final columnIndex = i % columnCount;
      columns[columnIndex].add(children[i]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: crossAxisSpacing,
      children: [
        for (var i = 0; i < columns.length; i++)
          Expanded(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: spacing,
              children: columns[i],
            ),
          ),
      ],
    );
  }

  int _calculateColumnCount(double width) {
    final columnWidth = maxWidth / maxColumns;
    final possibleColumns = (width / columnWidth).floor();
    return possibleColumns.clamp(1, maxColumns);
  }
}
