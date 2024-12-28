part of 'shell_view.dart';

class _ShellMenuItem extends ViewModelWidget<ShellViewModel> {
  const _ShellMenuItem({
    required this.navigationTab,
    required this.statefulNavigationShell,
    required this.currentNavigationTab,
    this.badgeNumber,
  }) : super(isReactive: false);

  final NavigationTab navigationTab;
  final StatefulNavigationShell statefulNavigationShell;
  final NavigationTab currentNavigationTab;
  final int? badgeNumber;

  @override
  Widget build(BuildContext context, ShellViewModel model) {
    final rTools = context.rTools;
    return OpacityButton(
      onPressed: () => model.onNavigationTap(
        navigationTab,
        context: context,
        statefulNavigationShell: statefulNavigationShell,
      ),
      child: HoverBuilder(
        builder: (context, isHovered, child) {
          final backgroundColor = context.colors.background;
          final color =
              currentNavigationTab == navigationTab ? backgroundColor.darken() : backgroundColor;
          return Container(
            height: rTools.scaledPerWidth(56),
            color: isHovered ? context.colors.shellHover : color,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(kSizesAppPadding),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      navigationTab.icon,
                      size: 24,
                    ),
                    if (badgeNumber != null)
                      Positioned(
                        left: -4,
                        top: -4,
                        child: CustomBadgeContainer(
                          height: 16,
                          width: 16,
                          color: context.colors.badge,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Center(
                              child: AutoSizeText(
                                badgeNumber!.toString(),
                                minFontSize: 0,
                                style: context.texts.badge,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const Gap(8),
                Text(
                  navigationTab.label,
                  style: context.texts.shellMenuItem,
                  textScaler: context.textScaler,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
