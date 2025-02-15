part of '../widgets/t_provider.dart';

class TurboColors {
  const TurboColors({
    required this.themeMode,
    required BuildContext context,
  }) : _context = context;

  final TThemeMode themeMode;
  final BuildContext _context;

  // 🚀 TURBO --------------------------------------------------------------------------------- \\

  ThemeData get _themeData => _context.themeData;
  Typography get typography => _themeData.typography;
  ColorScheme get scheme => _themeData.colorScheme;

  Color get appBar => cardBackground;
  Color get navigationRailBackground => cardBackground;

  Color get cardBorder => switch (themeMode) {
        TThemeMode.dark => const Color(0xFF27272A),
        TThemeMode.light => const Color(0xFFE4E4E7),
      };

  Color get cardBackground => switch (themeMode) {
    TThemeMode.dark => const Color(0xFF0D1117),
    TThemeMode.light => const Color(0xFFFAFAFA),
  };


  Color get formFieldPlaceholder => const Color(0xFF8D8D93);
  Color get input => scheme.input;

  // 📜 DEPRECATED ---------------------------------------------------------------------------- \\

  List<Color> get transparantCardGradient => [
        Colors.transparent,
        switch (themeMode) {
          TThemeMode.dark => Colors.white.withOpacity(0.03),
          TThemeMode.light => Colors.black.withOpacity(0.03),
        },
      ];

  Color get iconOnBackground => switch (themeMode) {
        TThemeMode.light => Colors.white,
        TThemeMode.dark => Colors.white,
      };

  Color get borderOnBackground {
    return switch (themeMode) {
      TThemeMode.light => Colors.white,
      TThemeMode.dark => Colors.white,
    };
  }

  Color get selectedBorder => activeFormFieldBorder;

  Color? get iconColor => background.onColor;

  Color get profileAvatarBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFFFFFFF),
        TThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get badgeText => switch (themeMode) {
        TThemeMode.light => const Color(0xFFE5E7EB),
        TThemeMode.dark => const Color(0xFFE5E7EB),
      };

  Color get activeChipBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFEDEBEB),
        TThemeMode.dark => const Color(0xFFEDEBEB),
      };

  Color get activeFormFieldBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFFFFFFF),
        TThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get activeFormFieldBorder => switch (themeMode) {
        TThemeMode.light => const Color(0xFF262626),
        TThemeMode.dark => const Color(0xFF262626),
      };

  Color get activeIconBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFBAE6FC),
        TThemeMode.dark => const Color(0xFFBAE6FC),
      };

  Color get activeMenuItem => switch (themeMode) {
        TThemeMode.light => const Color(0xFFEAE8E8),
        TThemeMode.dark => const Color(0xFFEAE8E8),
      };

  Color get activeScrollBar => switch (themeMode) {
        TThemeMode.light => const Color(0xFF7D7D7D),
        TThemeMode.dark => const Color(0xFF7D7D7D),
      };

  Color get activeTabDivider => switch (themeMode) {
        TThemeMode.light => const Color(0xFF000000),
        TThemeMode.dark => const Color(0xFF000000),
      };

  Color get activeTableRow => switch (themeMode) {
        TThemeMode.light => const Color(0xFFEDEBEB),
        TThemeMode.dark => const Color(0xFFEDEBEB),
      };

  Color get background => scheme.background;

  Color get badge => switch (themeMode) {
        TThemeMode.light => const Color(0xFFE5E7EB),
        TThemeMode.dark => const Color(0xFFE5E7EB),
      };

  Color get border => switch (themeMode) {
        TThemeMode.light => const Color(0xFFE1DFDE),
        TThemeMode.dark => const Color(0xFFE1DFDE),
      };

  Color get buttonHover => switch (themeMode) {
        TThemeMode.light => const Color(0xFFE5E4E3),
        TThemeMode.dark => const Color(0xFFE5E4E3),
      };

  Color get caption => switch (themeMode) {
        TThemeMode.light => const Color(0xFF777779),
        TThemeMode.dark => const Color(0xFF777779),
      };

  Color get navigationTabText => switch (themeMode) {
        TThemeMode.light => const Color(0xFFFFFFFF),
        TThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get captionText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF3C3C3F),
        TThemeMode.dark => const Color(0xFF3C3C3F),
      };


  Color get cardSectionBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFF7F7F7),
        TThemeMode.dark => const Color(0xFFF7F7F7),
      };

  Color get chipLabel => switch (themeMode) {
        TThemeMode.light => const Color(0xFF737373),
        TThemeMode.dark => const Color(0xFF737373),
      };

  Color get chipText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF404040),
        TThemeMode.dark => const Color(0xFF404040),
      };

  Color get danger => switch (themeMode) {
        TThemeMode.light => const Color(0xFFEF4445),
        TThemeMode.dark => const Color(0xFFEF4445),
      };

  Color get dialogBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFFEFCFA),
        TThemeMode.dark => const Color(0xFFFEFCFA),
      };

  Color get divider => switch (themeMode) {
        TThemeMode.light => const Color(0xFFE9E8E6),
        TThemeMode.dark => const Color(0xFFE9E8E6),
      };

  Color get dropDownItemText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF262626),
        TThemeMode.dark => const Color(0xFF262626),
      };

  Color get dropdownBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFFFFFFF),
        TThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get dropdownHover => switch (themeMode) {
        TThemeMode.light => const Color(0xFFF7F7F7),
        TThemeMode.dark => const Color(0xFFF7F7F7),
      };

  Color get emptyPlaceholderText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF3C3C3F),
        TThemeMode.dark => const Color(0xFF3C3C3F),
      };

  Color get error => danger;

  Color get formFieldBorder => switch (themeMode) {
        TThemeMode.light => const Color(0xFFD1D1D1),
        TThemeMode.dark => const Color(0xFFD1D1D1),
      };

  Color get formFieldText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF404040),
        TThemeMode.dark => const Color(0xFF404040),
      };

  Color get headerRowBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFFAF8F7),
        TThemeMode.dark => const Color(0xFFFAF8F7),
      };

  Color get headerText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF262626),
        TThemeMode.dark => const Color(0xFF262626),
      };

  Color get icon => switch (themeMode) {
        TThemeMode.light => const Color(0xFF000000),
        TThemeMode.dark => const Color(0xFF000000),
      };

  Color get iconBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFA8F3D0),
        TThemeMode.dark => const Color(0xFFA8F3D0),
      };

  Color get iconLetter => switch (themeMode) {
        TThemeMode.light => const Color(0xFF404040),
        TThemeMode.dark => const Color(0xFF404040),
      };

  Color get inactiveChipBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFDAD9D9),
        TThemeMode.dark => const Color(0xFFDAD9D9),
      };

  Color get inactiveFormFieldBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFF6F4F2),
        TThemeMode.dark => const Color(0xFFF6F4F2),
      };

  Color get inactiveIconBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFE4E2E1),
        TThemeMode.dark => const Color(0xFFE4E2E1),
      };

  Color get infoLabelValue => switch (themeMode) {
        TThemeMode.light => const Color(0xB23C3C3F),
        TThemeMode.dark => const Color(0xB23C3C3F),
      };

  Color get labelOnBackground => switch (themeMode) {
        TThemeMode.light => background.onColor,
        TThemeMode.dark => background.onColor,
      };

  Color get label => switch (themeMode) {
        TThemeMode.light => const Color(0xFF262626),
        TThemeMode.dark => const Color(0xFF262626),
      };

  Color get keyLabel => switch (themeMode) {
        TThemeMode.light => const Color(0xFF565252),
        TThemeMode.dark => const Color(0xFF565252),
      };

  Color get labelText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF262626),
        TThemeMode.dark => const Color(0xFF262626),
      };

  Color get primaryButtonBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFF23A9EA),
        TThemeMode.dark => const Color(0xFF23A9EA),
      };

  Color get dangerButtonBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFEF4445),
        TThemeMode.dark => const Color(0xFFEF4445),
      };

  Color get primaryButtonHover => switch (themeMode) {
        TThemeMode.light => const Color(0xFF20AFF4),
        TThemeMode.dark => const Color(0xFF20AFF4),
      };

  Color get primaryText => switch (themeMode) {
        TThemeMode.light => const Color(0xFFFFFFFF),
        TThemeMode.dark => const Color(0xFFFFFFFF),
      };

  Color get primaryHintText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF404040),
        TThemeMode.dark => const Color(0xFF404040),
      };
  Color get primaryIcon => switch (themeMode) {
        TThemeMode.light => const Color(0xFF777677),
        TThemeMode.dark => const Color(0xFF777677),
      };

  Color get primaryTextOnBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFFF2F2F2),
        TThemeMode.dark => const Color(0xFFF2F2F2),
      };

  Color get primaryToolTipText => switch (themeMode) {
        TThemeMode.light => const Color(0xFFCDD1E0),
        TThemeMode.dark => const Color(0xFFCDD1E0),
      };

  Color listItemTitle({required Color onBackgroundColor}) => switch (themeMode) {
        TThemeMode.light => onBackgroundColor.onColor,
        TThemeMode.dark => onBackgroundColor.onColor,
      };

  Color scaffoldHeaderText({required Color onBackgroundColor}) => switch (themeMode) {
        TThemeMode.light => onBackgroundColor.onColor,
        TThemeMode.dark => onBackgroundColor.onColor,
      };

  Color get scrollBar => switch (themeMode) {
        TThemeMode.light => const Color(0xFFC1C1C1),
        TThemeMode.dark => const Color(0xFFC1C1C1),
      };

  Color get secondaryButton => switch (themeMode) {
        TThemeMode.light => const Color(0xB23C3C3F),
        TThemeMode.dark => const Color(0xB23C3C3F),
      };

  Color get secondaryButtonBackground => switch (themeMode) {
        TThemeMode.light => Colors.transparent,
        TThemeMode.dark => Colors.transparent,
      };

  Color get secondaryButtonHover => switch (themeMode) {
        TThemeMode.light => const Color(0xFFE6E6E4),
        TThemeMode.dark => const Color(0xFFE6E6E4),
      };

  Color get secondaryText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF000000),
        TThemeMode.dark => const Color(0xFF000000),
      };

  Color get secondaryHintText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF9CA3AF),
        TThemeMode.dark => const Color(0xFF9CA3AF),
      };

  Color get secondaryIcon => switch (themeMode) {
        TThemeMode.light => const Color(0xFF737373),
        TThemeMode.dark => const Color(0xFF737373),
      };

  Color get secondaryToolTipText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF888A98),
        TThemeMode.dark => const Color(0xFF888A98),
      };

  Color get sectionGroupHeaderText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF262626),
        TThemeMode.dark => const Color(0xFF262626),
      };

  Color get settingsItemText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF262626),
        TThemeMode.dark => const Color(0xFF262626),
      };

  Color get shellBackground => switch (themeMode) {
        TThemeMode.light => background,
        TThemeMode.dark => background,
      };

  Color get shellHeaderText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF000000),
        TThemeMode.dark => const Color(0xFF000000),
      };

  Color get shellHover => switch (themeMode) {
        TThemeMode.light => const Color(0xFFF2F0EF),
        TThemeMode.dark => const Color(0xFFF2F0EF),
      };

  Color get shellMenuText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF262626),
        TThemeMode.dark => const Color(0xFF262626),
      };

  Color get shellText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF525252),
        TThemeMode.dark => const Color(0xFF525252),
      };

  Color get shoppingListItemHint => switch (themeMode) {
        TThemeMode.light => const Color(0xFFBDBDBD),
        TThemeMode.dark => const Color(0xFFBDBDBD),
      };

  Color get switchLabel => switch (themeMode) {
        TThemeMode.light => const Color(0xFF737373),
        TThemeMode.dark => const Color(0xFF737373),
      };

  Color get tabHeaderText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF737373),
        TThemeMode.dark => const Color(0xFF737373),
      };

  Color get tableHeaderText => switch (themeMode) {
        TThemeMode.light => const Color(0xFF171717),
        TThemeMode.dark => const Color(0xFF171717),
      };

  Color get toolTipBackground => switch (themeMode) {
        TThemeMode.light => const Color(0xFF1E202B),
        TThemeMode.dark => const Color(0xFF1E202B),
      };
}
