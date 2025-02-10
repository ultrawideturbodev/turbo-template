import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/ui/enums/t_theme_mode.dart';

sealed class TButtonConfig {
  const TButtonConfig({
    required this.onPressed,
  });

  final VoidCallback onPressed;
}

class TButtonIconConfig extends TButtonConfig {
  const TButtonIconConfig({
    required this.iconData,
    required super.onPressed,
  });

  factory TButtonIconConfig.goBack({
    required BuildContext context,
    required VoidCallback? onFail,
  }) =>
      TButtonIconConfig(
        iconData: Icons.arrow_back,
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            onFail?.call();
          }
        },
      );

  factory TButtonIconConfig.logout({
    required VoidCallback onPressed,
  }) =>
      TButtonIconConfig(
        iconData: BootstrapIcons.doorClosed,
        onPressed: onPressed,
      );

  factory TButtonIconConfig.theme({
    required VoidCallback onPressed,
    required TThemeMode themeMode,
  }) =>
      TButtonIconConfig(
        iconData: themeMode == TThemeMode.light ? BootstrapIcons.moon : BootstrapIcons.sun,
        onPressed: onPressed,
      );

  factory TButtonIconConfig.settings({
    required VoidCallback onPressed,
  }) =>
      TButtonIconConfig(
        iconData: Icons.settings,
        onPressed: onPressed,
      );

  final IconData iconData;
}

class TButtonTextConfig extends TButtonConfig {
  const TButtonTextConfig({
    required this.text,
    required super.onPressed,
  });

  final String text;
}

extension TButtonConfigExtension on TButtonConfig {
  IconData? get pIconData {
    switch (this) {
      case TButtonIconConfig():
        return (this as TButtonIconConfig).iconData;
      case TButtonTextConfig():
        return null;
    }
  }

  String? get pText {
    switch (this) {
      case TButtonIconConfig():
        return null;
      case TButtonTextConfig():
        return (this as TButtonTextConfig).text;
    }
  }
}
