import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turbo_template/core/extensions/context_extension.dart';
import 'package:turbo_template/core/extensions/context_extension.dart';
import 'package:turbo_template/core/extensions/context_extension.dart';
import 'package:turbo_template/core/extensions/context_extension.dart';
import 'package:turbo_template/core/widgets/turbo_auto_size_text.dart';

import '../enums/emoji.dart';

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

  final Emoji emoji;
  final String title;
  final TextAlign textAlign;
  final EmojiHeaderType type;
  final Color? color;

  @override
  Widget build(BuildContext context) => Transform.translate(
        offset: const Offset(0, 2),
        child: TurboAutoSizeText(
          minFontSize: 18,
          '${emoji.toString()}  $title',
          style: switch (type) {
            EmojiHeaderType.scaffoldTitle => context.tTexts.scaffoldHeader,
            EmojiHeaderType.h1 => context.tTexts.h1,
            EmojiHeaderType.h2 => context.tTexts.h2,
            EmojiHeaderType.h3 => context.tTexts.h3,
          },
          textAlign: textAlign,
        ),
      );
}
