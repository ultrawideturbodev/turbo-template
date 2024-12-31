part of 'context_extension.dart';

class TurboUi {
  TurboUi(this.context);
  final BuildContext context;

  LocalSettingsProvider get _localSettings => LocalSettingsProvider.of(context);
  SupportedThemeMode get themeMode => _localSettings.supportedThemeMode;

  TuGradient get primaryButtonGradient => TuGradient.topBottom(
        colors: context.tColors.primaryButtonGradient,
      );

  TuGradient get secondaryButtonGradient => TuGradient.topBottom(
        colors: context.tColors.secondaryButtonGradient,
      );

  Gradient get gradientBackground {
    return switch (themeMode) {
      SupportedThemeMode.light => const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFFB4B4ED),
            Color(0xFFE5E6F8),
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
            Color(0xFFD5D5F5),
            Color(0xFFB4B4ED),
          ],
          stops: [0.0, 0.22, 0.4, 0.6, 0.75, 1.0],
        ),
      SupportedThemeMode.dark => RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [
            Colors.white.withOpacity(0.08),
            Colors.transparent,
          ],
        ),
    };
  }

  TuGradient get topLeftTransparantCardGradient => TuGradient.topLeft(
        colors: context.tColors.transparantCardGradient,
      );

  TuGradient get topLeftColorCardGradient => TuGradient.topLeft(
        colors: context.tColors.colorCardGradient,
      );

  TuGradient get topCenterTransparantCardGradient => TuGradient.topBottom(
        colors: context.tColors.transparantCardGradient,
      );

  TuGradient get topCenterColorCardGradient => TuGradient.topBottom(
        colors: context.tColors.colorCardGradient,
      );

  BoxBorder get darkBorder => Border.all(
        color: context.tColors.transparantDarkCardBorder,
        width: kSizesBorderWidth,
      );

  BoxBorder get selectedBorder => Border.all(
        color: context.tColors.transparantSelectedBorder,
        width: kSizesBorderWidth,
      );

  Color get border => switch (context.tUi.themeMode) {
        SupportedThemeMode.light => const Color(0xFF3C3C55),
        SupportedThemeMode.dark => const Color(0xFF272727),
      };

  BoxBorder get transparantLightBorder => Border.all(
        color: context.tColors.transparantLightCardBorder,
        width: kSizesBorderWidth,
      );

  BoxBorder get solidLightBorder => Border.all(
        color: context.tColors.solidLightCardBorder,
        width: kSizesBorderWidth,
      );

  List<BoxShadow> get cardShadow {
    switch (themeMode) {
      case SupportedThemeMode.dark:
        return [
          const BoxShadow(
            blurStyle: BlurStyle.outer,
            color: Color(0xFF000000),
            offset: Offset(2, 2),
            blurRadius: 6,
          ),
        ];

      case SupportedThemeMode.light:
        return [
          const BoxShadow(
            blurStyle: BlurStyle.outer,
            color: Color(0x14000000),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ];
    }
  }
}
