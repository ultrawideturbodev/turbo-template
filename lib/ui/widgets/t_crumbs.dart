import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/ui/config/t_crumb_config.dart';

class TCrumbs extends StatelessWidget {
  const TCrumbs({
    Key? key,
    required this.tCrumbs,
    this.separator = Breadcrumb.arrowSeparator,
  }) : super(key: key);

  final List<TCrumb> tCrumbs;
  final Widget separator;

  @override
  Widget build(BuildContext context) => Breadcrumb(
        separator: separator,
        children: tCrumbs.map(
          (e) {
            switch (e) {
              case TCrumbText():
                return TextButton(
                  scaleAnimationEnd: 1,
                  opacityAnimationEnd: 0.6,
                  onPressed: e.onPressed,
                  enableFeedback: false,
                  density: ButtonDensity.compact,
                  child: Text(e.text),
                );
              case TCrumbDots():
                return const MoreDots();
            }
          },
        ).toList(),
      );
}
