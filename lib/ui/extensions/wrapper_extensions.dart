import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/ui/widgets/t_card.dart';

extension WrapperExtension on Widget {

  Widget wrapLeftElementGap() =>
      wrapMargin(edgeInsets: const EdgeInsets.only(left: kSizesSpacingGap));

  Widget wrapMargin({required EdgeInsets? edgeInsets}) => switch (edgeInsets == null) {
        true => this,
        false => Padding(
            padding: edgeInsets!,
            child: this,
          ),
      };

  Widget wrapConstraints({required BoxConstraints? boxConstraints}) =>
      switch (boxConstraints == null) {
        true => this,
        false => ConstrainedBox(
            constraints: boxConstraints!,
            child: this,
          ),
      };
}
