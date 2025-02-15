import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:turbo_template/ui/enums/emoji.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/typography/widgets/turbo_auto_size_text.dart';

enum EmojiHeaderType {
  scaffoldTitle,
  h1,
  h2,
  h3,
  ;
}

class EmojiHeader extends StatelessWidget {
  const EmojiHeader.scaffoldTitle({
    super.key,
    required this.emoji,
    required this.title,
    this.textAlign = TextAlign.left,
    this.color,
  }) : type = EmojiHeaderType.scaffoldTitle;

  const EmojiHeader.h1({
    super.key,
    required this.emoji,
    required this.title,
    this.textAlign = TextAlign.left,
    this.color,
  }) : type = EmojiHeaderType.h1;

  const EmojiHeader.h2({
    super.key,
    required this.emoji,
    required this.title,
    this.textAlign = TextAlign.left,
    this.color,
  }) : type = EmojiHeaderType.h2;

  const EmojiHeader.h3({
    super.key,
    required this.emoji,
    required this.title,
    this.textAlign = TextAlign.left,
    this.color,
  }) : type = EmojiHeaderType.h3;

  final Color? color;
  final Emoji emoji;
  final EmojiHeaderType type;
  final String title;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) => Transform.translate(
        offset: const Offset(0, 2),
        child: TurboAutoSizeText(
          minFontSize: 18,
          '${emoji.toString()}  $title',
          style: switch (type) {
            EmojiHeaderType.scaffoldTitle => context.texts.h2,
            EmojiHeaderType.h1 => context.texts.h1,
            EmojiHeaderType.h2 => context.texts.h2,
            EmojiHeaderType.h3 => context.texts.h3,
          },
          textAlign: textAlign,
        ),
      );
}
