part of 'turbo_provider.dart';

class TurboTexts {
  const TurboTexts({
    required this.colors,
    required this.config,
  });

  final TurboColors colors;
  final TurboConfig config;

  TextStyle get svgMessage => TextStyle(
        fontSize: 16,
        height: 1,
        fontWeight: FontWeight.w500,
        color: colors.primaryTextOnBackground,
      );

  TextStyle listItemCaption({required Color onBackgroundColor}) => TextStyle(
        fontSize: 12,
        height: 1,
        fontWeight: FontWeight.w400,
        color: colors.listItemTitle(onBackgroundColor: onBackgroundColor),
      );

  TextStyle listItemTitle({
    required Color onBackgroundColor,
    required bool hasCaption,
  }) =>
      TextStyle(
        fontSize: switch (hasCaption) {
          true => 16,
          false => 19,
        },
        height: switch (hasCaption) {
          true => 1,
          false => null,
        },
        fontWeight: FontWeight.w600,
        color: colors.listItemTitle(onBackgroundColor: onBackgroundColor),
      );

  TextStyle get iconLabel => caption.copyWith(
        color: colors.primaryTextOnBackground,
        fontWeight: FontWeight.bold,
        height: 1,
      );

  TextStyle get verifyEmailTitle => TextStyle(
        fontSize: 24,
        height: 1,
        fontWeight: FontWeight.w800,
        color: colors.shellHeaderText,
      );

  TextStyle get createUserNameTitle => TextStyle(
        fontSize: 24,
        height: 1,
        fontWeight: FontWeight.w800,
        color: colors.shellHeaderText,
      );

  TextStyle get badge => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: colors.badgeText,
      );

  TextStyle get navigationTab => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.navigationTabText,
      );

  TextStyle get caption => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: colors.captionText,
      );

  TextStyle get chip => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors.chipText,
      );

  TextStyle get dialogHeader => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: colors.headerText,
        fontFamily: config.headerFontFamily,
        height: 1,
      );

  TextStyle get dropDownItem => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.dropDownItemText,
      );

  TextStyle get emptyPlaceholder => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.emptyPlaceholderText,
      );

  TextStyle get formField => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors.formFieldText,
      );

  TextStyle get formFieldError => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: colors.error,
      );

  TextStyle get formFieldLabel => TextStyle(
        fontSize: config.labelFontSize,
        fontWeight: config.labelFontWeight,
        color: colors.label,
      );

  TextStyle get cardTitle => TextStyle(
        fontSize: 22,
        fontWeight: config.labelFontWeight,
        height: 1,
        color: colors.label,
      );

  TextStyle get keyLabel => TextStyle(
        fontSize: 15,
        fontWeight: config.labelFontWeight,
        color: colors.label,
      );

  TextStyle get valueLabel => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: colors.label,
      );
  TextStyle get keyLabelOnBackground => TextStyle(
        fontSize: 15,
        fontWeight: config.labelFontWeight,
        color: colors.labelOnBackground,
      );

  TextStyle get valueLabelOnBackground => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: colors.labelOnBackground,
      );

  TextStyle get infoLabel => TextStyle(
        fontSize: config.labelFontSize,
        fontWeight: config.labelFontWeight,
        color: colors.label,
      );

  TextStyle get infoLabelValue => TextStyle(
        fontSize: config.labelFontSize,
        fontWeight: config.labelFontWeight,
        color: colors.label,
      );

  TextStyle get label => TextStyle(
        fontSize: config.labelFontSize,
        fontWeight: config.labelFontWeight,
        color: colors.labelText,
      );

  TextStyle get primaryButton => TextStyle(
        fontSize: config.buttonFontSize,
        fontWeight: config.buttonFontWeight,
        color: colors.primaryButtonText,
      );

  TextStyle get dangerButton => primaryButton;

  TextStyle get primaryHint => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors.primaryHintText,
      );

  TextStyle get paragraph => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.primaryTextOnBackground,
      );

  TextStyle get profileUsername => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: colors.profileAvatarBackground,
      );

  TextStyle get profileHeader => TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.w500,
        color: colors.primaryTextOnBackground,
      );

  TextStyle scaffoldHeader({required Color onBackgroundColor}) => TextStyle(
        fontSize: 30,
        height: 1,
        fontWeight: FontWeight.w800,
        fontFamily: config.headerFontFamily,
        letterSpacing: 1,
        color: colors.scaffoldHeaderText(onBackgroundColor: onBackgroundColor),
      );

  TextStyle get emojiIcon => const TextStyle(
        fontSize: 24,
        height: 1,
      );

  TextStyle h1({required Color onBackgroundColor}) => TextStyle(
        fontSize: 20,
        height: 1,
        fontWeight: FontWeight.w800,
        fontFamily: config.headerFontFamily,
        letterSpacing: 1,
        color: colors.scaffoldHeaderText(onBackgroundColor: onBackgroundColor),
      );

  TextStyle h2({required Color onBackgroundColor}) => TextStyle(
        fontSize: 17,
        height: 1,
        fontWeight: FontWeight.w700,
        fontFamily: config.headerFontFamily,
        letterSpacing: 1,
        color: colors.scaffoldHeaderText(onBackgroundColor: onBackgroundColor),
      );

  TextStyle h3({required Color onBackgroundColor}) => TextStyle(
        fontSize: 14,
        height: 1,
        fontWeight: FontWeight.w600,
        fontFamily: config.headerFontFamily,
        letterSpacing: 1,
        color: colors.scaffoldHeaderText(onBackgroundColor: onBackgroundColor),
      );

  TextStyle get secondaryButton => TextStyle(
        fontSize: config.buttonFontSize,
        fontWeight: config.buttonFontWeight,
        color: colors.secondaryButtonText,
      );

  TextStyle get secondaryHint => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors.secondaryHintText,
      );

  TextStyle get sectionGroupHeader => TextStyle(
        fontSize: 20,
        height: 1,
        fontWeight: FontWeight.w700,
        color: colors.sectionGroupHeaderText,
      );

  TextStyle get sectionHeader => TextStyle(
        fontSize: 16,
        height: 1,
        fontWeight: FontWeight.w600,
        color: colors.headerText,
      );

  TextStyle get settingsItem => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.settingsItemText,
      );
  TextStyle get shellHeader => TextStyle(
        fontSize: 20,
        height: 1,
        fontWeight: FontWeight.w700,
        color: colors.shellHeaderText,
      );

  TextStyle get shellMenuItem => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.shellMenuText,
      );

  TextStyle get shoppingListItemHint => TextStyle(
        fontWeight: FontWeight.w400,
        color: colors.shoppingListItemHint,
      );

  TextStyle get switchLabel => TextStyle(
        fontSize: config.labelFontSize,
        fontWeight: config.labelFontWeight,
        color: colors.switchLabel,
      );

  TextStyle get tabHeader => TextStyle(
        fontSize: 14,
        height: 1,
        fontWeight: FontWeight.w500,
        color: colors.tabHeaderText,
      );

  TextStyle get tableHeader => TextStyle(
        fontSize: 14,
        height: 1,
        fontWeight: FontWeight.w700,
        color: colors.tableHeaderText,
      );

  TextStyle get emptyFormFieldPlaceholder => caption.copyWith(
        color: colors.primaryTextOnBackground,
        fontStyle: FontStyle.italic,
      );
}
