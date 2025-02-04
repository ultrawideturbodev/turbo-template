import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/widgets/turbo_auto_size_text.dart';

class ButtonText extends StatelessWidget {
  const ButtonText(this.text, {Key? key, this.autoSizeGroup}) : super(key: key);

  final AutoSizeGroup? autoSizeGroup;
  final String text;

  @override
  Widget build(BuildContext context) => TurboAutoSizeText(
        text,
        autoSizeGroup: autoSizeGroup,
        style: context.t.texts.button,
      );
}
