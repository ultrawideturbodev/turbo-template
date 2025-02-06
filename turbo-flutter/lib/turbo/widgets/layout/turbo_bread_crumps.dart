import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/widgets/layout/turbo_bread_crumb.dart';

class TurboBreadCrumbs extends StatelessWidget {
  const TurboBreadCrumbs({
    Key? key,
    required this.turboBreadCrumbs,
    this.separator = Breadcrumb.arrowSeparator,
  }) : super(key: key);

  final List<TurboBreadCrumb> turboBreadCrumbs;
  final Widget separator;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: kSizesAppPadding, top: kSizesAppPadding),
    child: Breadcrumb(
          separator: separator,
          children: turboBreadCrumbs.map(
            (e) {
              switch (e) {
                case TurboTextCrumb():
                  return TextButton(
                    scaleAnimationEnd: 1,
                    opacityAnimationEnd: 0.6,
                    onPressed: e.onPressed,
                    enableFeedback: false,
                    density: ButtonDensity.compact,
                    child: Text(e.text),
                  );
                case TurboMoreDotsCrumb():
                  return const MoreDots();
              }
            },
          ).toList(),
        ),
  );
}
