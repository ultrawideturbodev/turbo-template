import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart' as gap_package;
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';

class Gap extends gap_package.Gap {
  const Gap(super.mainAxisExtent, {super.key});
  const Gap.element({super.key, double multiplier = 1}) : super(kSizesElementGap * multiplier);
  const Gap.appPadding({super.key, double multiplier = 1}) : super(kSizesAppPadding * multiplier);
  const Gap.cardPadding({super.key, double multiplier = 1}) : super(kSizesCardPadding * multiplier);
  const Gap.bottomFade({super.key, double multiplier = 1})
      : super(kSizesHeightButtonBottomFade * multiplier);
  const Gap.headerTitle({super.key, double multiplier = 1}) : super(kSizesTitleGap * multiplier);
  const Gap.listItemTitleCaption({super.key, double multiplier = 1})
      : super(kSizesListItemTitleCaption * multiplier);
  const Gap.inlineText({super.key, double multiplier = 1}) : super(kSizesTextGap * multiplier);
  const Gap.label({super.key, double multiplier = 1}) : super(kSizesLabelGap * multiplier);
  const Gap.listItem({super.key, double multiplier = 1}) : super(kSizesListItemGap * multiplier);
  const Gap.scaffoldTitle({super.key, double multiplier = 1}) : super(kSizesTitleGap * multiplier);
  const Gap.section({super.key, double multiplier = 1}) : super(kSizesSectionGap * multiplier);
  factory Gap.bottomSafeArea(BuildContext context, {double multiplier = 1}) =>
      Gap(context.t.sizes.bottomSafeAreaWithMinimum * multiplier);
  factory Gap.topSafeArea(BuildContext context, {double multiplier = 1}) =>
      Gap(context.t.sizes.topSafeArea * multiplier);
}

class SliverGap extends gap_package.SliverGap {
  const SliverGap._(super.mainAxisExtent);

  const SliverGap.listItem({super.key, double multiplier = 1})
      : super(kSizesListItemGap * multiplier);
  const SliverGap.inlineText({super.key, double multiplier = 1})
      : super(kSizesTextGap * multiplier);
  const SliverGap.bottomButton({super.key, double multiplier = 1})
      : super(kSizesHeightButtonBottomFade * multiplier);
  const SliverGap.appPadding({super.key, double multiplier = 1})
      : super(kSizesItemGap * multiplier);
  const SliverGap.label({super.key, double multiplier = 1}) : super(kSizesLabelGap * multiplier);
  factory SliverGap.bottomSafeArea(BuildContext context, {double multiplier = 1}) =>
      SliverGap._(context.t.sizes.bottomSafeArea * multiplier);
  factory SliverGap.topSafeArea(BuildContext context, {double multiplier = 1}) =>
      SliverGap._(context.t.sizes.topSafeArea * multiplier);
  const SliverGap.scaffoldTitle({super.key, double multiplier = 1})
      : super(kSizesTitleGap * multiplier);
  const SliverGap.headerTitle({super.key, double multiplier = 1})
      : super(kSizesHeaderTitleGap * multiplier);

  const SliverGap.section({super.key, double multiplier = 1})
      : super(kSizesSectionGap * multiplier);
}
