import 'package:flutter/widgets.dart';
import 'package:turbo_template/data/enums/t_png.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/enums/t_theme_mode.dart';
import 'package:turbo_template/ui/widgets/t_png_image.dart';

class TLogo extends StatelessWidget {
  const TLogo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => TPngImage(
        png: switch (context.themeMode) {
          TThemeMode.dark => TPng.logoDarkMode,
          TThemeMode.light => TPng.logoLightMode,
        },
    height: 64,
      );
}
