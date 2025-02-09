import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/typography/extensions/text_style_extension.dart';
import 'package:turbo_template/ui/config/t_background_config.dart';
import 'package:turbo_template/ui/config/turbo_breakpoint_config.dart';
import 'package:turbo_template/ui/enums/t_device_type.dart';
import 'package:turbo_template/ui/enums/t_theme.dart';
import 'package:turbo_template/ui/enums/t_theme_mode.dart';
import 'package:turbo_template/ui/extensions/color_extension.dart';
import 'package:turbo_template/ui/models/t_data.dart';
import 'package:turbo_template/ui/utils/t_tools.dart';

export 't_provider.dart';

part '../models/t_colors.dart';
part '../models/t_sizes.dart';
part '../models/t_texts.dart';
part 't_decorations.dart';

class TProvider extends InheritedWidget {
  const TProvider({
    super.key,
    required super.child,
    required this.colors,
    required this.data,
    required this.decorations,
    required this.texts,
    required this.theme,
    required this.themeMode,
    required this.tools,
    required this.breakpointConfig,
    required this.sizes,
  });

  final TurboColors colors;
  final TSizes sizes;
  final TDecorations decorations;
  final TTexts texts;
  final TData data;
  final TThemeMode themeMode;
  final TTheme theme;
  final TTools tools;
  final TBreakpointConfig breakpointConfig;

  static TProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TProvider>()!;
  @override
  bool updateShouldNotify(TProvider oldWidget) =>
      tools != oldWidget.tools ||
      data != oldWidget.data ||
      themeMode != oldWidget.themeMode ||
      colors != oldWidget.colors ||
      sizes != oldWidget.sizes ||
      decorations != oldWidget.decorations ||
      texts != oldWidget.texts ||
      theme != oldWidget.theme ||
      breakpointConfig != oldWidget.breakpointConfig;
}
