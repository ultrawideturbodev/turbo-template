import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/config/turbo_breakpoint_config.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/enums/turbo_device_type.dart';
import 'package:turbo_template/turbo/enums/turbo_theme_mode.dart';
import 'package:turbo_template/turbo/extensions/color_extension.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/models/turbo_data.dart';
import 'package:turbo_template/turbo/models/turbo_tools.dart';
import 'package:turbo_template/typography/extensions/text_style_extension.dart';

export 'turbo_provider.dart';

part 'turbo_colors.dart';
part 'turbo_decorations.dart';
part 'turbo_sizes.dart';
part 'turbo_texts.dart';

class TurboProvider extends InheritedWidget {
  const TurboProvider({
    super.key,
    required super.child,
    required this.colors,
    required this.data,
    required this.decorations,
    required this.texts,
    required this.themeMode,
    required this.tools,
    required this.breakpointConfig,
    required this.sizes,
  });

  final TurboColors colors;
  final TurboSizes sizes;
  final TurboDecorations decorations;
  final TurboTexts texts;
  final TurboData data;
  final TurboThemeMode themeMode;
  final TurboTools tools;
  final TurboBreakpointConfig breakpointConfig;

  static TurboProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TurboProvider>()!;

  @override
  bool updateShouldNotify(TurboProvider oldWidget) =>
      tools != oldWidget.tools || data != oldWidget.data || themeMode != oldWidget.themeMode;
}
