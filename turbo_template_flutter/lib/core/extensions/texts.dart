part of 'context_extension.dart';

class _Texts {
  _Texts(this.colors, this.sizes);

  final _Colors colors;
  final _Sizes sizes;

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
        fontWeight: FontWeight.w400,
        color: colors.captionText,
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
        fontSize: sizes.labelFontSize,
        fontWeight: sizes.labelFontWeight,
        color: colors.label,
      );

  TextStyle get infoLabel => TextStyle(
        fontSize: sizes.labelFontSize,
        fontWeight: sizes.labelFontWeight,
        color: colors.label,
      );

  TextStyle get infoLabelValue => TextStyle(
        fontSize: sizes.labelFontSize,
        fontWeight: sizes.labelFontWeight,
        color: colors.label,
      );

  TextStyle get label => TextStyle(
        fontSize: sizes.labelFontSize,
        fontWeight: sizes.labelFontWeight,
        color: colors.labelText,
      );

  TextStyle get primaryButton => TextStyle(
        fontSize: sizes.buttonFontSize,
        fontWeight: sizes.buttonFontWeight,
        color: colors.primaryButtonText,
      );

  TextStyle get primaryHint => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors.primaryHintText,
      );

  TextStyle get primaryText => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.primaryText,
      );

  TextStyle get scaffoldHeader => TextStyle(
        fontSize: 30,
        height: 1,
        fontWeight: FontWeight.w800,
        color: colors.scaffoldHeaderText,
      );

  TextStyle get secondaryButton => TextStyle(
        fontSize: sizes.buttonFontSize,
        fontWeight: sizes.buttonFontWeight,
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

  TextStyle get switchLabel => TextStyle(
        fontSize: sizes.labelFontSize,
        fontWeight: sizes.labelFontWeight,
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
}
