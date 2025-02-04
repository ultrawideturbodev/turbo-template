part of 'turbo_provider.dart';

class TurboTexts {
  const TurboTexts({
    required this.colors,
    required this.config,
    required this.context,
    required this.themeMode,
    required this.deviceType,
  });

  final TurboColors colors;
  final TurboConfig config;
  final BuildContext context;
  final TurboThemeMode themeMode;
  final TurboDeviceType deviceType;

  Typography get typography => context.themeData.typography;

  TextStyle get _h1 => typography.h1;
  TextStyle get _h2 => typography.h2;
  TextStyle get _h3 => typography.h3;
  TextStyle get _h4 => typography.h4;
  TextStyle get _blockquote => typography.blockQuote;
  TextStyle get _lead => typography.lead;
  TextStyle get _large => typography.large;
  TextStyle get _small => typography.small;
  TextStyle get _p => typography.p;

  TextStyle get button => _small.copyWith(color: context.themeData.colorScheme.primary.onColor);
  TextStyle get title => _h1;
  TextStyle get h1 => _h2;
  TextStyle get h2 => _h3;
  TextStyle get h3 => _h4;
  TextStyle get formFieldError => _small.copyWith(color: colors.error);
  TextStyle get formFieldLabel => _small.copyWith(color: colors.background.onColor);
  TextStyle get formField => _small;
  TextStyle get svgMessage => _p;
  TextStyle get dialogHeader => _h3;
  TextStyle get dialogBody => _p;
  TextStyle get paragraph => _p;
  TextStyle get acceptPrivacy => _small;
  TextStyle get badge => _small;
  TextStyle get shellMenuItem => _small;
  TextStyle get navigationTab => _small;
  TextStyle get sectionHeader => h1;

  TextStyle get cardTitle => typography.x2Large.copyWith(
        fontWeight: FontWeight.w600,
      );


}
