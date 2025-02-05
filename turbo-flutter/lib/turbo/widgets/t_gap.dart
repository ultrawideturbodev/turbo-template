import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as gap_package;
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';

class TGap extends gap_package.Gap {
  const TGap(super.mainAxisExtent, {super.key});
  const TGap.element({super.key, double multiplier = 1}) : super(kSizesElementGap * multiplier);
  const TGap.appPadding({super.key, double multiplier = 1}) : super(kSizesAppPadding * multiplier);
  const TGap.cardPadding({super.key, double multiplier = 1}) : super(kSizesCardPadding * multiplier);
  const TGap.bottomFade({super.key, double multiplier = 1})
      : super(kSizesHeightButtonBottomFade * multiplier);
  const TGap.headerTitle({super.key, double multiplier = 1}) : super(kSizesTitleGap * multiplier);
  const TGap.listItemTitleCaption({super.key, double multiplier = 1})
      : super(kSizesListItemTitleCaption * multiplier);
  const TGap.inlineText({super.key, double multiplier = 1}) : super(kSizesTextGap * multiplier);
  const TGap.label({super.key, double multiplier = 1}) : super(kSizesLabelGap * multiplier);
  const TGap.listItem({super.key, double multiplier = 1}) : super(kSizesListItemGap * multiplier);
  const TGap.scaffoldTitle({super.key, double multiplier = 1}) : super(kSizesTitleGap * multiplier);
  const TGap.section({super.key, double multiplier = 1}) : super(kSizesSectionGap * multiplier);
  factory TGap.bottomSafeArea(BuildContext context, {double multiplier = 1}) =>
      TGap(context.sizes.bottomSafeAreaWithMinimum * multiplier);
  factory TGap.topSafeArea(BuildContext context, {double multiplier = 1}) =>
      TGap(context.sizes.topSafeArea * multiplier);
}

class TSliverGap extends gap_package.SliverGap {
  const TSliverGap._(super.mainAxisExtent);

  const TSliverGap.listItem({super.key, double multiplier = 1})
      : super(kSizesListItemGap * multiplier);
  const TSliverGap.inlineText({super.key, double multiplier = 1})
      : super(kSizesTextGap * multiplier);
  const TSliverGap.bottomButton({super.key, double multiplier = 1})
      : super(kSizesHeightButtonBottomFade * multiplier);
  const TSliverGap.appPadding({super.key, double multiplier = 1})
      : super(kSizesItemGap * multiplier);
  const TSliverGap.label({super.key, double multiplier = 1}) : super(kSizesLabelGap * multiplier);
  factory TSliverGap.bottomSafeArea(BuildContext context, {double multiplier = 1}) =>
      TSliverGap._(context.sizes.bottomSafeArea * multiplier);
  factory TSliverGap.topSafeArea(BuildContext context, {double multiplier = 1}) =>
      TSliverGap._(context.sizes.topSafeArea * multiplier);
  const TSliverGap.scaffoldTitle({super.key, double multiplier = 1})
      : super(kSizesTitleGap * multiplier);
  const TSliverGap.headerTitle({super.key, double multiplier = 1})
      : super(kSizesHeaderTitleGap * multiplier);

  const TSliverGap.section({super.key, double multiplier = 1})
      : super(kSizesSectionGap * multiplier);
}
