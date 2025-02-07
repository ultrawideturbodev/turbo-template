import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/config/turbo_button_config.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/widgets/ho_padding.dart';

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
  final List<TurboButtonConfig> leading;
  final List<TurboButtonConfig> trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(4),
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
                TurboIconButtonConfig() => OutlineButton(
                    density: ButtonDensity.icon,
                    onPressed: item.onPressed,
                    child: Icon(item.pIconData),
                  ),
                TurboTextButtonConfig() => OutlineButton(
                    onPressed: item.onPressed,
                    child: Text(item.pText!),
                    density: ButtonDensity.icon,
                  ),
              }
          ],
          trailing: [
            for (final item in trailing)
              switch (item) {
                TurboIconButtonConfig() => OutlineButton(
                    density: ButtonDensity.icon,
                    onPressed: item.onPressed,
                    child: Icon(item.pIconData),
                  ),
                TurboTextButtonConfig() => OutlineButton(
                    onPressed: item.onPressed,
                    child: Text(item.pText!),
                    density: ButtonDensity.icon,
                  ),
              }
          ],
        ),
        const HoPadding(child: NavigationDivider()),
      ],
    );
  }
}
