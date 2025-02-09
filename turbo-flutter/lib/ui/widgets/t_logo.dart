import 'package:flutter/widgets.dart';
import 'package:turbo_template/data/constants/k_pngs.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/enums/t_theme_mode.dart';

class TLogo extends StatelessWidget {
  const TLogo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Image.asset(
        switch (context.themeMode) {
          TThemeMode.light => kPngsLogoDarkMode,
          TThemeMode.dark => kPngsLogoDarkMode,
        },
        height: 64,
      );
}
