part of '../widgets/t_provider.dart';

class TTexts {
  const TTexts({
    required this.colors,
    required BuildContext context,
    required this.themeMode,
    required this.deviceType,
  }) : _context = context;

  final TurboColors colors;
  final BuildContext _context;
  final TThemeMode themeMode;
  final TDeviceType deviceType;

  // helpers

  ThemeData get _themeData => _context.themeData;
  Typography get typography => _themeData.typography;
  ColorScheme get _colorScheme => _themeData.colorScheme;

  // font weights
  static const FontWeight fwThin = FontWeight.w100;
  static const FontWeight fwExtraLight = FontWeight.w200;
  static const FontWeight fwLight = FontWeight.w300;
  static const FontWeight fwRegular = FontWeight.w400;
  static const FontWeight fwMedium = FontWeight.w500;
  static const FontWeight fwSemiBold = FontWeight.w600;
  static const FontWeight fwBold = FontWeight.w700;
  static const FontWeight fwExtraBold = FontWeight.w800;
  static const FontWeight fwBlack = FontWeight.w900;

  // core

  TextStyle get _h1 => typography.h1;
  TextStyle get _h2 => typography.h2;
  TextStyle get _h3 => typography.h3;
  TextStyle get _h4 => typography.h4;
  TextStyle get _blockquote => typography.blockQuote;
  TextStyle get _lead => typography.lead;
  TextStyle get _large => typography.large;
  TextStyle get _xLarge => typography.xLarge;
  TextStyle get _x2Large => typography.x2Large;
  TextStyle get _small => typography.small;
  TextStyle get _xSmall => typography.xSmall;
  TextStyle get _muted => _small.copyWith(
        color: _colorScheme.mutedForeground,
      );
  TextStyle get _xMuted => _xSmall.copyWith(
        color: _colorScheme.mutedForeground,
      );

  TextStyle get _p => typography.p;

  // use cases

  TextStyle get button => _small.copyWith(
        color: _themeData.colorScheme.primary.onColor,
      );

  TextStyle get h1 => _h2;
  TextStyle get h2 => _h3;
  TextStyle get h3 => _h4;

  TextStyle get formField => _small;
  TextStyle get formFieldError => _xSmall.copyWith(
        color: colors.error,
        fontWeight: fwSemiBold,
      );
  TextStyle get formFieldHint => formField.copyWith(
        color: _colorScheme.input,
        fontWeight: fwRegular,
      );
  TextStyle get formFieldLabel => _xSmall.copyWith(
        color: colors.background.onColor,
        fontWeight: fwSemiBold,
      );

  TextStyle get formFieldSubLabel => subtitle;

  TextStyle get trailingFormFieldLabel => _xMuted.copyWithCurrent(
        fontSize: (cValue) => cValue * 0.9,
      );
  TextStyle get paragraph => _p;
  TextStyle get acceptPrivacy => _xMuted;

  TextStyle get cardTitle => typography.h3;

  TextStyle get listItemTitle => typography.normal.copyWith(
        fontWeight: fwSemiBold,
      );

  TextStyle get subtitle => _muted.copyWithCurrent(
        fontWeight: (_) => fwRegular,
        color: (cValue) => cValue.lighten(20),
      );

  TextStyle get navigationLabel => _xMuted.copyWith(
        fontWeight: fwSemiBold,
      );
}
