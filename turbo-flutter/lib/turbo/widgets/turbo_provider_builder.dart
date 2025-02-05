import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/config/turbo_breakpoint_config.dart';
import 'package:turbo_template/turbo/enums/supported_language.dart';
import 'package:turbo_template/turbo/enums/turbo_theme_mode.dart';
import 'package:turbo_template/turbo/extensions/box_constraints_extension.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/extensions/turbo_target_platform_extension.dart';
import 'package:turbo_template/turbo/models/turbo_data.dart';
import 'package:turbo_template/turbo/models/turbo_tools.dart';
import 'package:turbo_template/turbo/widgets/providers/turbo_provider.dart';

export 'turbo_provider_builder.dart';

class TurboProviderBuilder extends StatelessWidget {
  const TurboProviderBuilder({
    super.key,
    required this.builder,
    required this.turboThemeMode,
    required this.supportedLanguage,
    this.turboBreakpointConfig = const TurboBreakpointConfig(),
  });

  final TurboBreakpointConfig turboBreakpointConfig;
  final TurboThemeMode turboThemeMode;
  final SupportedLanguage supportedLanguage;
  final Widget Function(
    TurboThemeMode themeMode,
    TurboTools tools,
    TurboData data,
    TurboTexts texts,
    TurboColors colors,
    TurboSizes sizes,
    TurboDecorations decorations,
    BuildContext context,
  ) builder;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final deviceType = constraints.turboDeviceType(
            breakpointConfig: turboBreakpointConfig,
          );
          final sizes = TurboSizes(context, deviceType);
          final colors = TurboColors(
            context: context,
            themeMode: turboThemeMode,
          );
          final decorations = TurboDecorations(
            themeMode: turboThemeMode,
            deviceType: deviceType,
          );
          final texts = TurboTexts(
            context: context,
            colors: colors,
            deviceType: deviceType,
            themeMode: turboThemeMode,
          );
          final tools = TurboTools(
            currentWidth: constraints.maxWidth,
            currentHeight: constraints.maxHeight,
            widthInDesign: defaultTargetPlatform.defaultHeightInDesign,
            heightInDesign: defaultTargetPlatform.defaultWidthInDesign,
          );
          final data = TurboData(
            currentWidth: constraints.maxWidth,
            currentHeight: constraints.maxHeight,
            orientation: constraints.turboOrientation,
            deviceType: deviceType,
            media: context.media,
          );
          return TurboProvider(
            data: data,
            themeMode: turboThemeMode,
            tools: tools,
            texts: texts,
            colors: colors,
            decorations: decorations,
            breakpointConfig: turboBreakpointConfig,
            child: Builder(
              builder: (context) => builder(
                turboThemeMode,
                tools,
                data,
                texts,
                colors,
                sizes,
                decorations,
                context,
              ),
            ),
            sizes: sizes,
          );
        },
      );
}
