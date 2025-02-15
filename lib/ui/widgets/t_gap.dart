import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as gap_package;
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';

class TGap extends gap_package.Gap {
  const TGap._(super.mainAxisExtent, {super.key});

  const TGap.element({super.key, double multiplier = 1}) : super(kSizesSpacingGap * multiplier);
  const TGap.subtitle({super.key, double multiplier = 1}) : super(kSizesSubtitleGap * multiplier);
  const TGap.appPadding({super.key, double multiplier = 1}) : super(kSizesAppPadding * multiplier);
  const TGap.cardPadding({super.key, double multiplier = 1})
      : super(kSizesCardPadding * multiplier);
  const TGap.bottomFade({super.key, double multiplier = 1})
      : super(kSizesHeightButtonBottomFade * multiplier);
  const TGap.headerTitle({super.key, double multiplier = 1}) : super(kSizesTitleGap * multiplier);
  const TGap.listItemTitleCaption({super.key, double multiplier = 1})
      : super(kSizesListItemTitleCaption * multiplier);
  const TGap.inlineText({super.key, double multiplier = 1}) : super(kSizesTextGap * multiplier);
  const TGap.label({super.key, double multiplier = 1}) : super(kSizesItemGap * multiplier);
  const TGap.listItem({super.key, double multiplier = 1}) : super(kSizesListItemGap * multiplier);
  const TGap.scaffoldTitle({super.key, double multiplier = 1}) : super(kSizesTitleGap * multiplier);
  const TGap.section({super.key, double multiplier = 1}) : super(kSizesSectionGap * multiplier);
  factory TGap.bottomSafeArea(BuildContext context, {double multiplier = 1}) =>
      TGap._(context.sizes.bottomSafeAreaWithMinimum * multiplier);
  factory TGap.topSafeArea(BuildContext context, {double multiplier = 1}) =>
      TGap._(context.sizes.topSafeArea * multiplier);
}
