import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../constants/k_sizes.dart';
import '../extensions/context_extension.dart';
import '../extensions/num_extension.dart';

class CustomDialog<T> extends StatefulWidget {
  const CustomDialog({
    super.key,
    required this.builder,
    this.maxWidth = kSizesDialogMaxWidth,
    this.padding = 16,
  });

  final WidgetBuilder builder;
  final double maxWidth;
  final double padding;

  @override
  State<CustomDialog<T>> createState() => _CustomDialogState<T>();
}

class _CustomDialogState<T> extends State<CustomDialog<T>> {
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Text('TODO');
}
