import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:{{packageName.snakeCase()}}/ui/abstracts/turbo_button_type.dart';
import 'package:{{packageName.snakeCase()}}/state/extensions/context_extension.dart';
import 'package:{{packageName.snakeCase()}}/ui/extensions/wrapper_extensions.dart';
import 'package:{{packageName.snakeCase()}}/ui/widgets/turbo_gap.dart';

sealed class TListItemType {
  const TListItemType({
    required this.title,
    this.subtitle,
    this.trailing = const [],
  });

  final String title;
  final String? subtitle;
  final List<TButtonType> trailing;
}

class TAvatarListItem extends TListItemType {
  TAvatarListItem({
    required super.title,
    super.subtitle,
    required this.avatar,
    super.trailing,
  });

  final Avatar avatar;
}

class TPlainListItem extends TListItemType {
  TPlainListItem({
    required super.title,
    super.subtitle,
    super.trailing,
  });
}

class TurboListItem extends StatelessWidget {
  const TurboListItem({Key? key, required this.type}) : super(key: key);

  final TListItemType type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (type is TAvatarListItem) ...[
          (type as TAvatarListItem).avatar,
          const TGap.element(),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type.title, style: context.texts.listItemTitle),
              if (type.subtitle != null) ...[
                const TGap.subtitle(),
                Text(type.subtitle!, style: context.texts.subtitle),
              ],
            ],
          ),
        ),
        for (final item in type.trailing)
          switch (item) {
            TIconButton() => OutlineButton(
                density: ButtonDensity.icon,
                onPressed: item.onPressed,
                child: Icon(item.pIconData),
              ).wrapLeftElementGap(),
            TTextButton() => OutlineButton(
                onPressed: item.onPressed,
                child: Text(item.pText!),
                density: ButtonDensity.icon,
              ).wrapLeftElementGap(),
          },
      ],
    );
  }
}
