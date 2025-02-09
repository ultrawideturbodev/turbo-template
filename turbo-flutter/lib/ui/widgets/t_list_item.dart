import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/ui/config/turbo_button_config.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/extensions/wrapper_extensions.dart';
import 'package:turbo_template/ui/widgets/t_leading.dart';
import 'package:turbo_template/ui/widgets/t_card.dart';
import 'package:turbo_template/ui/widgets/t_gap.dart';
import 'package:turbo_template/ui/widgets/t_row.dart';

class TListItem extends StatelessWidget {
  const TListItem({
    super.key,
    required this.title,
    this.leading = const [],
    this.subtitle,
    this.trailing = const [],
    this.spacing = kSizesItemGap,
  });

  final String title;
  final String? subtitle;
  final List<Widget> leading;
  final List<Widget> trailing;
  final double spacing;

  @override
  Widget build(BuildContext context) => TRow(
        spacing: spacing,
        children: [
          for (final leadingItem in leading) leadingItem,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.texts.listItemTitle),
                if (subtitle != null) ...[
                  const TGap.subtitle(),
                  Text(subtitle!, style: context.texts.subtitle),
                ],
              ],
            ),
          ),
          for (final trailingItem in trailing) trailingItem,
        ],
      );
}

class TListItemAvatar extends TListItem {
  const TListItemAvatar({
    super.key,
    required super.title,
    super.subtitle,
    required this.avatar,
    super.trailing,
  });

  final Avatar avatar;

  @override
  Widget build(BuildContext context) => TListItem(
        title: title,
        leading: [avatar],
      );
}
