import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:gap/gap.dart';
import '../../extensions/context_extension.dart';

class TuDivider extends StatelessWidget {
  const TuDivider({
    Key? key,
    required this.topPadding,
    required this.bottomPadding,
  }) : super(key: key);

  final double topPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Gap(topPadding),
          Container(
            height: 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.colors.border,
            ),
            width: double.infinity,
          ),
          Gap(bottomPadding),
        ],
      );
}
