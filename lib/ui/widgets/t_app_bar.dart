import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/config/turbo_button_config.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';

class TAppBar extends StatelessWidget {
  const TAppBar({
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
  final List<TButtonConfig> leading;
  final List<TButtonConfig> trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppBar(
          backgroundColor: context.colors.appBar,
          leadingGap: kSizesSpacingGap,
          trailingGap: kSizesSpacingGap,
          title: title == null ? null : Text(title!),
          header: header == null ? null : Text(header!),
          subtitle: subtitle == null ? null : Text(subtitle!),
          leading: [
            if (onBackPressed != null || (automaticallyImplyLeading && context.canPop()))
              GhostButton(
                density: ButtonDensity.icon,
                onPressed: onBackPressed ?? () => context.pop(),
                child: const Icon(Icons.arrow_back),
              ),
            for (final item in leading)
              switch (item) {
                TButtonIconConfig() => GhostButton(
                    density: ButtonDensity.icon,
                    onPressed: item.onPressed,
                    child: Icon(item.pIconData),
                  ),
                TButtonTextConfig() => GhostButton(
                    onPressed: item.onPressed,
                    child: Text(item.pText!),
                    density: ButtonDensity.icon,
                  ),
              }
          ],
          trailing: [
            for (final item in trailing)
              switch (item) {
                TButtonIconConfig() => GhostButton(
                    density: ButtonDensity.icon,
                    onPressed: item.onPressed,
                    child: Icon(item.pIconData),
                  ),
                TButtonTextConfig() => GhostButton(
                    onPressed: item.onPressed,
                    child: Text(item.pText!),
                    density: ButtonDensity.icon,
                  ),
              }
          ],
        ),
          const Divider(height: 0),
      ],
    );
  }
}
