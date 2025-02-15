import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/environment/extensions/turbo_target_platform_extension.dart';
import 'package:turbo_template/localizations/enums/supported_language.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/config/turbo_breakpoint_config.dart';
import 'package:turbo_template/ui/enums/t_device_type.dart';
import 'package:turbo_template/ui/enums/t_theme.dart';
import 'package:turbo_template/ui/enums/t_theme_mode.dart';
import 'package:turbo_template/ui/extensions/box_constraints_extension.dart';
import 'package:turbo_template/ui/models/t_data.dart';
import 'package:turbo_template/ui/utils/t_tools.dart';
import 'package:turbo_template/ui/widgets/t_provider.dart';

export 't_provider_builder.dart';

class TProviderBuilder extends StatelessWidget {
  const TProviderBuilder({
    super.key,
    required this.builder,
    required this.turboThemeMode,
    required this.turboTheme,
    required this.supportedLanguage,
    this.turboBreakpointConfig = const TBreakpointConfig(),
  });

  final TBreakpointConfig turboBreakpointConfig;
  final TThemeMode turboThemeMode;
  final TTheme turboTheme;
  final SupportedLanguage supportedLanguage;
  final Widget Function(
    TDeviceType deviceType,
    TThemeMode themeMode,
    TTheme theme,
    TTools tools,
    TData data,
    TTexts texts,
    TurboColors colors,
    TSizes sizes,
    TDecorations decorations,
    BuildContext context,
  ) builder;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final deviceType = constraints.turboDeviceType(
            breakpointConfig: turboBreakpointConfig,
          );
          final sizes = TSizes(context, deviceType);
          final colors = TurboColors(
            context: context,
            themeMode: turboThemeMode,
          );
          final decorations = TDecorations(
            colors: colors,
            themeMode: turboThemeMode,
            deviceType: deviceType,
            theme: turboTheme,
          );
          final texts = TTexts(
            context: context,
            colors: colors,
            deviceType: deviceType,
            themeMode: turboThemeMode,
          );
          final tools = TTools(
            currentWidth: constraints.maxWidth,
            currentHeight: constraints.maxHeight,
            widthInDesign: defaultTargetPlatform.defaultHeightInDesign,
            heightInDesign: defaultTargetPlatform.defaultWidthInDesign,
          );
          final data = TData(
            currentWidth: constraints.maxWidth,
            currentHeight: constraints.maxHeight,
            orientation: constraints.turboOrientation,
            deviceType: deviceType,
            media: context.media,
          );
          return TProvider(
            data: data,
            themeMode: turboThemeMode,
            tools: tools,
            texts: texts,
            colors: colors,
            decorations: decorations,
            breakpointConfig: turboBreakpointConfig,
            theme: turboTheme,
            child: Builder(
              builder: (context) {
                return builder(
                  context.turboProvider.data.deviceType,
                  context.turboProvider.themeMode,
                  context.turboProvider.theme,
                  context.turboProvider.tools,
                  context.turboProvider.data,
                  context.turboProvider.texts,
                  context.turboProvider.colors,
                  context.turboProvider.sizes,
                  context.turboProvider.decorations,
                  context,
                );
              },
            ),
            sizes: sizes,
          );
        },
      );
}
