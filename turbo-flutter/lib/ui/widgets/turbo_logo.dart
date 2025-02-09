import 'package:flutter/widgets.dart';
import 'package:turbo_template/data/constants/k_pngs.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/enums/turbo_theme_mode.dart';

class TurboLogo extends StatelessWidget {
  const TurboLogo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Image.asset(
        switch (context.themeMode) {
          TurboThemeMode.light => kPngsLogoDarkMode,
          TurboThemeMode.dark => kPngsLogoDarkMode,
        },
        height: 64,
      );
}
