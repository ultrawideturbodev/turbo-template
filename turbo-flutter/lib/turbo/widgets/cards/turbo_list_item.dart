import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/config/turbo_button_config.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/extensions/wrapper_extensions.dart';
import 'package:turbo_template/turbo/widgets/t_gap.dart';

sealed class TurboListItemType {
  const TurboListItemType({
    required this.title,
    this.subtitle,
    this.trailing = const [],
  });

  final String title;
  final String? subtitle;
  final List<TurboButtonConfig> trailing;
}

class AvatarListItem extends TurboListItemType {
  AvatarListItem({
    required super.title,
    super.subtitle,
    required this.avatar,
    super.trailing,
  });

  final Avatar avatar;
}

class PlainTurboListItem extends TurboListItemType {
  PlainTurboListItem({
    required super.title,
    super.subtitle,
    super.trailing,
  });
}

class TurboListItem extends StatelessWidget {
  const TurboListItem({Key? key, required this.type}) : super(key: key);

  final TurboListItemType type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (type is AvatarListItem) ...[
          (type as AvatarListItem).avatar,
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
            TurboIconButtonConfig() => OutlineButton(
                density: ButtonDensity.icon,
                onPressed: item.onPressed,
                child: Icon(item.pIconData),
              ).wrapLeftElementGap(),
            TurboTextButtonConfig() => OutlineButton(
                onPressed: item.onPressed,
                child: Text(item.pText!),
                density: ButtonDensity.icon,
              ).wrapLeftElementGap(),
          },
      ],
    );
  }
}
