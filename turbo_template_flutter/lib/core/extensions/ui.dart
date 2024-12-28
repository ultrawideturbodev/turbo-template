part of 'context_extension.dart';

class _Ui {
  _Ui(this.context);
  final BuildContext context;

  LocalSettingsProvider get _localSettings => LocalSettingsProvider.of(context);
  SupportedThemeMode get themeMode => _localSettings.supportedThemeMode;

  TuGradient get primaryButtonGradient => TuGradient.topBottom(
        colors: context.colors.primaryButtonGradient,
      );

  TuGradient get secondaryButtonGradient => TuGradient.topBottom(
        colors: context.colors.secondaryButtonGradient,
      );

  LinearGradient get gradientBackground {
    return const LinearGradient(
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
    );
  }

  TuGradient get topLeftTransparantCardGradient => TuGradient.topLeft(
        colors: context.colors.transparantCardGradient,
      );

  TuGradient get topLeftColorCardGradient => TuGradient.topLeft(
        colors: context.colors.colorCardGradient,
      );

  TuGradient get topCenterTransparantCardGradient => TuGradient.topBottom(
        colors: context.colors.transparantCardGradient,
      );

  TuGradient get topCenterColorCardGradient => TuGradient.topBottom(
        colors: context.colors.colorCardGradient,
      );

  BoxBorder get darkBorder => Border.all(
        color: context.colors.transparantDarkCardBorder,
        width: kSizesBorderWidth,
      );

  BoxBorder get selectedBorder => Border.all(
        color: context.colors.transparantSelectedBorder,
        width: kSizesBorderWidth,
      );

  Color get border => switch (context.ui.themeMode) {
        SupportedThemeMode.light => const Color(0xFF3C3C55),
        SupportedThemeMode.dark => const Color(0xFF272727),
      };

  BoxBorder get transparantLightBorder => Border.all(
        color: context.colors.transparantLightCardBorder,
        width: kSizesBorderWidth,
      );

  BoxBorder get solidLightBorder => Border.all(
        color: context.colors.solidLightCardBorder,
        width: kSizesBorderWidth,
      );

  List<BoxShadow> get cardShadow {
    switch (themeMode) {
      case SupportedThemeMode.dark:
      case SupportedThemeMode.light:
        return [
          const BoxShadow(
            blurStyle: BlurStyle.outer,
            color: Color(0xFF000000),
            offset: Offset(2, 2),
            blurRadius: 6,
          ),
        ];
    }
  }
}
