import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/ui/enums/turbo_theme_mode.dart';

extension TButtonTypeExtension on TButtonType {
  IconData? get pIconData {
    switch (this) {
      case TIconButton():
        return (this as TIconButton).iconData;
      case TTextButton():
        return null;
    }
  }

  String? get pText {
    switch (this) {
      case TIconButton():
        return null;
      case TTextButton():
        return (this as TTextButton).text;
    }
  }
}

sealed class TButtonType {
  const TButtonType({
    required this.onPressed,
  });

  final VoidCallback onPressed;
}

class TIconButton extends TButtonType {
  const TIconButton({
    required this.iconData,
    required super.onPressed,
  });

  factory TIconButton.goBack({
    required BuildContext context,
    required VoidCallback? onFail,
  }) =>
      TIconButton(
        iconData: Icons.arrow_back,
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            onFail?.call();
          }
        },
      );

  factory TIconButton.logout({
    required VoidCallback onPressed,
  }) =>
      TIconButton(
        iconData: BootstrapIcons.doorClosed,
        onPressed: onPressed,
      );

  factory TIconButton.theme({
    required VoidCallback onPressed,
    required TurboThemeMode themeMode,
  }) =>
      TIconButton(
        iconData: themeMode == TurboThemeMode.light ? BootstrapIcons.moon : BootstrapIcons.sun,
        onPressed: onPressed,
      );

  final IconData iconData;
}

class TTextButton extends TButtonType {
  const TTextButton({
    required this.text,
    required super.onPressed,
  });

  final String text;
}
