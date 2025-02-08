import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:{{packageName.snakeCase()}}/ui/abstracts/turbo_button_type.dart';
import 'package:{{packageName.snakeCase()}}/data/constants/k_sizes.dart';

class TurboAppBar extends StatelessWidget {
  const TurboAppBar({
    Key? key,
    this.title,
    this.header,
    this.subtitle,
    this.automaticallyImplyLeading = true,
    this.leading = const [],
    this.trailing = const [],
    this.onBackPressed,
  }) : super(key: key);

  final String? title;
  final String? header;
  final String? subtitle;
  final bool automaticallyImplyLeading;
  final VoidCallback? onBackPressed;
  final List<TButtonType> leading;
  final List<TButtonType> trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppBar(
          leadingGap: kSizesElementGap,
          trailingGap: kSizesElementGap,
          title: title == null ? null : Text(title!),
          header: header == null ? null : Text(header!),
          subtitle: subtitle == null ? null : Text(subtitle!),
          leading: [
            if (onBackPressed != null || (automaticallyImplyLeading && context.canPop()))
              OutlineButton(
                density: ButtonDensity.icon,
                onPressed: onBackPressed ?? () => context.pop(),
                child: const Icon(Icons.arrow_back),
              ),
            for (final item in leading)
              switch (item) {
                TIconButton() => OutlineButton(
                    density: ButtonDensity.icon,
                    onPressed: item.onPressed,
                    child: Icon(item.pIconData),
                  ),
                TTextButton() => OutlineButton(
                    onPressed: item.onPressed,
                    child: Text(item.pText!),
                    density: ButtonDensity.icon,
                  ),
              }
          ],
          trailing: [
            for (final item in trailing)
              switch (item) {
                TIconButton() => OutlineButton(
                    density: ButtonDensity.icon,
                    onPressed: item.onPressed,
                    child: Icon(item.pIconData),
                  ),
                TTextButton() => OutlineButton(
                    onPressed: item.onPressed,
                    child: Text(item.pText!),
                    density: ButtonDensity.icon,
                  ),
              }
          ],
        ),
      ],
    );
  }
}
