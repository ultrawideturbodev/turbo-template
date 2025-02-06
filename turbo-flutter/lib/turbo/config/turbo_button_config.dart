import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

extension TurboButtonConfigExtension on TurboButtonConfig {
  IconData? get pIconData {
    switch (this) {
      case TurboIconButtonConfig():
        return (this as TurboIconButtonConfig).iconData;
      case TurboTextButtonConfig():
        return null;
    }
  }

  String? get pText {
    switch (this) {
      case TurboIconButtonConfig():
        return null;
      case TurboTextButtonConfig():
        return (this as TurboTextButtonConfig).text;
    }
  }
}

sealed class TurboButtonConfig {
  const TurboButtonConfig({
    required this.onPressed,
  });

  final VoidCallback onPressed;
}

class TurboIconButtonConfig extends TurboButtonConfig {
  const TurboIconButtonConfig({
    required this.iconData,
    required super.onPressed,
  });

  factory TurboIconButtonConfig.goBack({
    required BuildContext context,
    required VoidCallback? onFail,
  }) =>
      TurboIconButtonConfig(
        iconData: Icons.arrow_back,
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            onFail?.call();
          }
        },
      );

  factory TurboIconButtonConfig.logout({
    required VoidCallback onPressed,
  }) =>
      TurboIconButtonConfig(
        iconData: BootstrapIcons.doorClosed,
        onPressed: onPressed,
      );

  final IconData iconData;
}

class TurboTextButtonConfig extends TurboButtonConfig {
  const TurboTextButtonConfig({
    required this.text,
    required super.onPressed,
  });

  final String text;
}
