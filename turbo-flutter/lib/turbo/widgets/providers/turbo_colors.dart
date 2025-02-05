part of 'turbo_provider.dart';

class TurboColors {
  const TurboColors({
    required this.themeMode,
    required BuildContext context,
  }) : _context = context;

  final TurboThemeMode themeMode;
  final BuildContext _context;

  // 🚀 TURBO --------------------------------------------------------------------------------- \\

  ThemeData get _themeData => _context.themeData;
  Typography get typography => _themeData.typography;
  ColorScheme get _colorScheme => _themeData.colorScheme;

  Color get cardBorder => const Color(0xFFE4E4E7);
  Color get formFieldPlaceholder => const Color(0xFF8D8D93);
  Color get input => _colorScheme.input;

  // 📜 DEPRECATED ---------------------------------------------------------------------------- \\

  List<Color> get transparantCardGradient => [
        Colors.transparent,
        switch (themeMode) {
          TurboThemeMode.dark => Colors.white.withOpacity(0.03),
          TurboThemeMode.light => Colors.black.withOpacity(0.03),
        },
      ];

  Color get iconOnBackground => switch (themeMode) {
        TurboThemeMode.light => Colors.white,
        TurboThemeMode.dark => Colors.white,
      };

  Color get borderOnBackground {
    return switch (themeMode) {
      TurboThemeMode.light => Colors.white,
      TurboThemeMode.dark => Colors.white,
    };
  }

  Color get selectedBorder => activeFormFieldBorder;

  Color? get iconColor => background.onColor;

  Color get profileAvatarBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFFFFFFF),
        TurboThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get badgeText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFE5E7EB),
        TurboThemeMode.dark => const Color(0xFFE5E7EB),
      };

  Color get activeChipBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFEDEBEB),
        TurboThemeMode.dark => const Color(0xFFEDEBEB),
      };

  Color get activeFormFieldBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFFFFFFF),
        TurboThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get activeFormFieldBorder => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF262626),
        TurboThemeMode.dark => const Color(0xFF262626),
      };

  Color get activeIconBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFBAE6FC),
        TurboThemeMode.dark => const Color(0xFFBAE6FC),
      };

  Color get activeMenuItem => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFEAE8E8),
        TurboThemeMode.dark => const Color(0xFFEAE8E8),
      };

  Color get activeScrollBar => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF7D7D7D),
        TurboThemeMode.dark => const Color(0xFF7D7D7D),
      };

  Color get activeTabDivider => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF000000),
        TurboThemeMode.dark => const Color(0xFF000000),
      };

  Color get activeTableRow => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFEDEBEB),
        TurboThemeMode.dark => const Color(0xFFEDEBEB),
      };

  Color get background => _colorScheme.background;

  Color get badge => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFE5E7EB),
        TurboThemeMode.dark => const Color(0xFFE5E7EB),
      };

  Color get border => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFE1DFDE),
        TurboThemeMode.dark => const Color(0xFFE1DFDE),
      };

  Color get buttonHover => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFE5E4E3),
        TurboThemeMode.dark => const Color(0xFFE5E4E3),
      };

  Color get caption => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF777779),
        TurboThemeMode.dark => const Color(0xFF777779),
      };

  Color get navigationTabText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFFFFFFF),
        TurboThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get captionText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF3C3C3F),
        TurboThemeMode.dark => const Color(0xFF3C3C3F),
      };

  Color get cardBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFFFFFFF),
        TurboThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get cardSectionBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFF7F7F7),
        TurboThemeMode.dark => const Color(0xFFF7F7F7),
      };

  Color get chipLabel => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF737373),
        TurboThemeMode.dark => const Color(0xFF737373),
      };

  Color get chipText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF404040),
        TurboThemeMode.dark => const Color(0xFF404040),
      };

  Color get danger => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFEF4445),
        TurboThemeMode.dark => const Color(0xFFEF4445),
      };

  Color get dialogBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFFEFCFA),
        TurboThemeMode.dark => const Color(0xFFFEFCFA),
      };

  Color get divider => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFE9E8E6),
        TurboThemeMode.dark => const Color(0xFFE9E8E6),
      };

  Color get dropDownItemText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF262626),
        TurboThemeMode.dark => const Color(0xFF262626),
      };

  Color get dropdownBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFFFFFFF),
        TurboThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get dropdownHover => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFF7F7F7),
        TurboThemeMode.dark => const Color(0xFFF7F7F7),
      };

  Color get emptyPlaceholderText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF3C3C3F),
        TurboThemeMode.dark => const Color(0xFF3C3C3F),
      };

  Color get error => danger;

  Color get formFieldBorder => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFD1D1D1),
        TurboThemeMode.dark => const Color(0xFFD1D1D1),
      };

  Color get formFieldText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF404040),
        TurboThemeMode.dark => const Color(0xFF404040),
      };

  Color get headerRowBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFFAF8F7),
        TurboThemeMode.dark => const Color(0xFFFAF8F7),
      };

  Color get headerText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF262626),
        TurboThemeMode.dark => const Color(0xFF262626),
      };

  Color get icon => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF000000),
        TurboThemeMode.dark => const Color(0xFF000000),
      };

  Color get iconBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFA8F3D0),
        TurboThemeMode.dark => const Color(0xFFA8F3D0),
      };

  Color get iconLetter => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF404040),
        TurboThemeMode.dark => const Color(0xFF404040),
      };

  Color get inactiveChipBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFDAD9D9),
        TurboThemeMode.dark => const Color(0xFFDAD9D9),
      };

  Color get inactiveFormFieldBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFF6F4F2),
        TurboThemeMode.dark => const Color(0xFFF6F4F2),
      };

  Color get inactiveIconBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFE4E2E1),
        TurboThemeMode.dark => const Color(0xFFE4E2E1),
      };

  Color get infoLabelValue => switch (themeMode) {
        TurboThemeMode.light => const Color(0xB23C3C3F),
        TurboThemeMode.dark => const Color(0xB23C3C3F),
      };

  Color get labelOnBackground => switch (themeMode) {
        TurboThemeMode.light => background.onColor,
        TurboThemeMode.dark => background.onColor,
      };

  Color get label => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF262626),
        TurboThemeMode.dark => const Color(0xFF262626),
      };

  Color get keyLabel => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF565252),
        TurboThemeMode.dark => const Color(0xFF565252),
      };

  Color get labelText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF262626),
        TurboThemeMode.dark => const Color(0xFF262626),
      };

  Color get primaryButtonBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF23A9EA),
        TurboThemeMode.dark => const Color(0xFF23A9EA),
      };

  Color get dangerButtonBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFEF4445),
        TurboThemeMode.dark => const Color(0xFFEF4445),
      };

  Color get primaryButtonHover => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF20AFF4),
        TurboThemeMode.dark => const Color(0xFF20AFF4),
      };

  Color get primaryText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFFFFFFF),
        TurboThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get primaryHintText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF404040),
        TurboThemeMode.dark => const Color(0xFF404040),
      };
  Color get primaryIcon => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF777677),
        TurboThemeMode.dark => const Color(0xFF777677),
      };

  Color get primaryTextOnBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFF2F2F2),
        TurboThemeMode.dark => const Color(0xFFF2F2F2),
      };

  Color get primaryToolTipText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFCDD1E0),
        TurboThemeMode.dark => const Color(0xFFCDD1E0),
      };

  Color listItemTitle({required Color onBackgroundColor}) => switch (themeMode) {
        TurboThemeMode.light => onBackgroundColor.onColor,
        TurboThemeMode.dark => onBackgroundColor.onColor,
      };

  Color scaffoldHeaderText({required Color onBackgroundColor}) => switch (themeMode) {
        TurboThemeMode.light => onBackgroundColor.onColor,
        TurboThemeMode.dark => onBackgroundColor.onColor,
      };

  Color get scrollBar => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFC1C1C1),
        TurboThemeMode.dark => const Color(0xFFC1C1C1),
      };

  Color get secondaryButton => switch (themeMode) {
        TurboThemeMode.light => const Color(0xB23C3C3F),
        TurboThemeMode.dark => const Color(0xB23C3C3F),
      };

  Color get secondaryButtonBackground => switch (themeMode) {
        TurboThemeMode.light => Colors.transparent,
        TurboThemeMode.dark => Colors.transparent,
      };

  Color get secondaryButtonHover => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFE6E6E4),
        TurboThemeMode.dark => const Color(0xFFE6E6E4),
      };

  Color get secondaryText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF000000),
        TurboThemeMode.dark => const Color(0xFF000000),
      };

  Color get secondaryHintText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF9CA3AF),
        TurboThemeMode.dark => const Color(0xFF9CA3AF),
      };

  Color get secondaryIcon => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF737373),
        TurboThemeMode.dark => const Color(0xFF737373),
      };

  Color get secondaryToolTipText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF888A98),
        TurboThemeMode.dark => const Color(0xFF888A98),
      };

  Color get sectionGroupHeaderText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF262626),
        TurboThemeMode.dark => const Color(0xFF262626),
      };

  Color get settingsItemText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF262626),
        TurboThemeMode.dark => const Color(0xFF262626),
      };

  Color get shellBackground => switch (themeMode) {
        TurboThemeMode.light => background,
        TurboThemeMode.dark => background,
      };

  Color get shellHeaderText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF000000),
        TurboThemeMode.dark => const Color(0xFF000000),
      };

  Color get shellHover => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFF2F0EF),
        TurboThemeMode.dark => const Color(0xFFF2F0EF),
      };

  Color get shellMenuText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF262626),
        TurboThemeMode.dark => const Color(0xFF262626),
      };

  Color get shellText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF525252),
        TurboThemeMode.dark => const Color(0xFF525252),
      };

  Color get shoppingListItemHint => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFFBDBDBD),
        TurboThemeMode.dark => const Color(0xFFBDBDBD),
      };

  Color get switchLabel => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF737373),
        TurboThemeMode.dark => const Color(0xFF737373),
      };

  Color get tabHeaderText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF737373),
        TurboThemeMode.dark => const Color(0xFF737373),
      };

  Color get tableHeaderText => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF171717),
        TurboThemeMode.dark => const Color(0xFF171717),
      };

  Color get toolTipBackground => switch (themeMode) {
        TurboThemeMode.light => const Color(0xFF1E202B),
        TurboThemeMode.dark => const Color(0xFF1E202B),
      };
}
