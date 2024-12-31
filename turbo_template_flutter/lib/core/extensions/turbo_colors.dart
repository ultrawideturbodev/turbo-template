part of 'context_extension.dart';

class TurboColors {
  TurboColors(this.context);
  final BuildContext context;

  Color get svgMessageText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF3C3C3F),
        SupportedThemeMode.dark => const Color(0xFF3C3C3F),
      };

  Color get transparantSelectedBorder => background.onColor.withOpacity(0.75);

  List<Color> get transparantCardGradient => [
        Colors.transparent,
        switch (context.tUi.themeMode) {
          SupportedThemeMode.dark => Colors.white.withOpacity(0.03),
          SupportedThemeMode.light => Colors.black.withOpacity(0.03),
        },
      ];
  Color get transparantLightCardBorder => context.tColors.border.withOpacity(0.75);
  Color get solidLightCardBorder => switch (context.tUi.themeMode) {
        SupportedThemeMode.dark => const Color(0xBF272727),
        SupportedThemeMode.light => const Color(0xBF272727),
      };

  List<Color> get colorCardGradient => [
        context.tColors.background,
        switch (context.tUi.themeMode) {
          SupportedThemeMode.dark => Colors.white.withOpacity(0.03),
          SupportedThemeMode.light => Colors.black.withOpacity(0.03),
        },
      ];
  Color get transparantDarkCardBorder =>
      context.tColors.background.onColor.withOpacity(kSizesOpacityDisabled);

  Color get badgeText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFE5E7EB),
        SupportedThemeMode.dark => const Color(0xFFE5E7EB),
      };

  Color get activeChipBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFEDEBEB),
        SupportedThemeMode.dark => const Color(0xFFEDEBEB),
      };

  Color get activeFormFieldBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFFFFFFF),
        SupportedThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get activeFormFieldBorder => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF262626),
        SupportedThemeMode.dark => const Color(0xFF262626),
      };

  Color get activeIconBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFBAE6FC),
        SupportedThemeMode.dark => const Color(0xFFBAE6FC),
      };

  Color get activeMenuItem => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFEAE8E8),
        SupportedThemeMode.dark => const Color(0xFFEAE8E8),
      };

  Color get activeScrollBar => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF7D7D7D),
        SupportedThemeMode.dark => const Color(0xFF7D7D7D),
      };

  Color get activeTabDivider => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF000000),
        SupportedThemeMode.dark => const Color(0xFF000000),
      };

  Color get activeTableRow => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFEDEBEB),
        SupportedThemeMode.dark => const Color(0xFFEDEBEB),
      };

  Color get background => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFFEFCFA),
        SupportedThemeMode.dark => const Color(0xFFFEFCFA),
      };

  Color get badge => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFE5E7EB),
        SupportedThemeMode.dark => const Color(0xFFE5E7EB),
      };

  Color get border => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFE1DFDE),
        SupportedThemeMode.dark => const Color(0xFFE1DFDE),
      };

  Color get buttonHover => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFE5E4E3),
        SupportedThemeMode.dark => const Color(0xFFE5E4E3),
      };

  Color get caption => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF777779),
        SupportedThemeMode.dark => const Color(0xFF777779),
      };

  Color get captionText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF3C3C3F),
        SupportedThemeMode.dark => const Color(0xFF3C3C3F),
      };

  Color get cardBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFFFFFFF),
        SupportedThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get cardSectionBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFF7F7F7),
        SupportedThemeMode.dark => const Color(0xFFF7F7F7),
      };

  Color get chipLabel => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF737373),
        SupportedThemeMode.dark => const Color(0xFF737373),
      };

  Color get chipText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF404040),
        SupportedThemeMode.dark => const Color(0xFF404040),
      };

  Color get danger => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFEF4445),
        SupportedThemeMode.dark => const Color(0xFFEF4445),
      };

  Color get dialogBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFFEFCFA),
        SupportedThemeMode.dark => const Color(0xFFFEFCFA),
      };

  Color get divider => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFE9E8E6),
        SupportedThemeMode.dark => const Color(0xFFE9E8E6),
      };

  Color get dropDownItemText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF262626),
        SupportedThemeMode.dark => const Color(0xFF262626),
      };

  Color get dropdownBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFFFFFFF),
        SupportedThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get dropdownHover => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFF7F7F7),
        SupportedThemeMode.dark => const Color(0xFFF7F7F7),
      };

  Color get emptyPlaceholderText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF3C3C3F),
        SupportedThemeMode.dark => const Color(0xFF3C3C3F),
      };

  Color get error => danger;

  Color get formFieldBorder => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFD1D1D1),
        SupportedThemeMode.dark => const Color(0xFFD1D1D1),
      };

  Color get formFieldText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF404040),
        SupportedThemeMode.dark => const Color(0xFF404040),
      };

  Color get headerRowBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFFAF8F7),
        SupportedThemeMode.dark => const Color(0xFFFAF8F7),
      };

  Color get headerText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF262626),
        SupportedThemeMode.dark => const Color(0xFF262626),
      };

  Color get icon => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF777779),
        SupportedThemeMode.dark => const Color(0xFF777779),
      };

  Color get iconBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFA8F3D0),
        SupportedThemeMode.dark => const Color(0xFFA8F3D0),
      };

  Color get iconLetter => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF404040),
        SupportedThemeMode.dark => const Color(0xFF404040),
      };

  Color get inactiveChipBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFDAD9D9),
        SupportedThemeMode.dark => const Color(0xFFDAD9D9),
      };

  Color get inactiveFormFieldBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFF6F4F2),
        SupportedThemeMode.dark => const Color(0xFFF6F4F2),
      };

  Color get inactiveIconBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFE4E2E1),
        SupportedThemeMode.dark => const Color(0xFFE4E2E1),
      };

  Color get infoLabelValue => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xB23C3C3F),
        SupportedThemeMode.dark => const Color(0xB23C3C3F),
      };

  Color get label => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF262626),
        SupportedThemeMode.dark => const Color(0xFF262626),
      };

  Color get labelText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF262626),
        SupportedThemeMode.dark => const Color(0xFF262626),
      };

  Color get primaryButtonBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF23A9EA),
        SupportedThemeMode.dark => const Color(0xFF23A9EA),
      };

  List<Color> get primaryButtonGradient => [
        Colors.red,
        Colors.red.darken(20),
      ];

  List<Color> get secondaryButtonGradient => [
        const Color(0xFF3280FF),
        const Color(0xFF3280FF).darken(20),
      ];

  Color get primaryButtonHover => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF20AFF4),
        SupportedThemeMode.dark => const Color(0xFF20AFF4),
      };

  Color get primaryButtonText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFFFFFFF),
        SupportedThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get primaryHintText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF404040),
        SupportedThemeMode.dark => const Color(0xFF404040),
      };
  Color get primaryIcon => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF777677),
        SupportedThemeMode.dark => const Color(0xFF777677),
      };

  Color get primaryText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF777677),
        SupportedThemeMode.dark => const Color(0xFF777677),
      };

  Color get primaryToolTipText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFCDD1E0),
        SupportedThemeMode.dark => const Color(0xFFCDD1E0),
      };

  Color get scaffoldHeaderText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF262626),
        SupportedThemeMode.dark => const Color(0xFF262626),
      };

  Color get scrollBar => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFC1C1C1),
        SupportedThemeMode.dark => const Color(0xFFC1C1C1),
      };

  Color get secondaryButton => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xB23C3C3F),
        SupportedThemeMode.dark => const Color(0xB23C3C3F),
      };

  Color get secondaryButtonBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => Colors.transparent,
        SupportedThemeMode.dark => Colors.transparent,
      };

  Color get secondaryButtonHover => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFE6E6E4),
        SupportedThemeMode.dark => const Color(0xFFE6E6E4),
      };

  Color get secondaryButtonText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF000000),
        SupportedThemeMode.dark => const Color(0xFF000000),
      };

  Color get secondaryHintText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF9CA3AF),
        SupportedThemeMode.dark => const Color(0xFF9CA3AF),
      };

  Color get secondaryIcon => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF737373),
        SupportedThemeMode.dark => const Color(0xFF737373),
      };

  Color get secondaryText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF737373),
        SupportedThemeMode.dark => const Color(0xFF737373),
      };

  Color get secondaryToolTipText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF888A98),
        SupportedThemeMode.dark => const Color(0xFF888A98),
      };

  Color get sectionGroupHeaderText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF262626),
        SupportedThemeMode.dark => const Color(0xFF262626),
      };

  Color get settingsItemText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF262626),
        SupportedThemeMode.dark => const Color(0xFF262626),
      };

  Color get shellBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFFFFFFF),
        SupportedThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get shellHeaderText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF000000),
        SupportedThemeMode.dark => const Color(0xFF000000),
      };

  Color get shellHover => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFFF2F0EF),
        SupportedThemeMode.dark => const Color(0xFFF2F0EF),
      };

  Color get shellMenuText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF262626),
        SupportedThemeMode.dark => const Color(0xFF262626),
      };

  Color get shellText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF525252),
        SupportedThemeMode.dark => const Color(0xFF525252),
      };

  Color get switchLabel => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF737373),
        SupportedThemeMode.dark => const Color(0xFF737373),
      };

  Color get tabHeaderText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF737373),
        SupportedThemeMode.dark => const Color(0xFF737373),
      };

  Color get tableHeaderText => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF171717),
        SupportedThemeMode.dark => const Color(0xFF171717),
      };

  Color get toolTipBackground => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF1E202B),
        SupportedThemeMode.dark => const Color(0xFF1E202B),
      };
}
