import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/widgets/cards/turbo_card.dart';
import 'package:turbo_template/turbo/widgets/ho_padding.dart';

extension WrapperExtension on Widget {
  Widget wrapCard() => TurboCard(
        type: TurboChildCard(child: this),
      );

  Widget wrapHoPadding() => HoPadding(
        child: this,
      );

  Widget wrapLeftElementGap() =>
      wrapMargin(edgeInsets: const EdgeInsets.only(left: kSizesElementGap));

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
