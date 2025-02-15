import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/routing/enums/navigation_tab.dart';
import 'package:turbo_template/routing/shell/shell_view_model.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/ui/enums/t_device_type.dart';
import 'package:turbo_template/ui/widgets/t_scaffold.dart';
import 'package:veto/data/models/base_view_model.dart';

class ShellView extends StatelessWidget {
  const ShellView({
    super.key,
    required this.statefulNavigationShell,
  });

  static const String path = 'gp';

  final StatefulNavigationShell statefulNavigationShell;

  @override
  Widget build(BuildContext context) => ViewModelBuilder<ShellViewModel>(
        builder: (context, model, isInitialised, child) {
          if (!isInitialised) {
            return kWidgetsNothing;
          }
          final deviceType = context.data.deviceType;
          switch (deviceType) {
            case TDeviceType.mobile:
              return TScaffold(
                child: statefulNavigationShell,
                footers: [
                  ValueListenableBuilder<NavigationTab>(
                    valueListenable: model.currentNavigationTab,
                    builder: (context, currentNavigationTab, child) {
                      final navigationTabs =
                          NavigationTab.navigationTabs(deviceType: TDeviceType.mobile);
                      return NavigationBar(
                        labelType: NavigationLabelType.selected,
                        onSelected: (int index) => model.onNavigationTap(
                          navigationTabs[index],
                          statefulNavigationShell: statefulNavigationShell,
                          context: context,
                        ),
                        index: navigationTabs.indexOf(currentNavigationTab),
                        children: navigationTabs
                            .map(
                              (bottomNavigationTab) => NavigationItem(
                                style: const ButtonStyle.muted(density: ButtonDensity.icon),
                                selectedStyle: const ButtonStyle.fixed(density: ButtonDensity.icon),
                                label: Text(bottomNavigationTab.label),
                                child: Icon(bottomNavigationTab.icon),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              );
            case TDeviceType.tablet:
            case TDeviceType.desktop:
              return TScaffold(
                child: ValueListenableBuilder<NavigationTab>(
                  valueListenable: model.currentNavigationTab,
                  builder: (context, currentNavigationTab, child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: model.menuIsExpanded,
                          builder: (context, menuIsExpanded, child) => NavigationRail(
                            backgroundColor: context.texts.colors.navigationRailBackground,
                            padding: const EdgeInsets.only(
                              top: kSizesAppPadding / 1.5,
                              left: kSizesAppPadding / 1.5,
                              right: kSizesAppPadding / 1.5,
                            ),
                            labelType: NavigationLabelType.expanded,
                            labelPosition: NavigationLabelPosition.end,
                            alignment: NavigationRailAlignment.start,
                            expanded: menuIsExpanded,
                            index: currentNavigationTab.index,
                            onSelected: (index) {
                              final navigationTabs =
                                  NavigationTab.navigationTabs(deviceType: deviceType);
                              model.onNavigationTap(
                                navigationTabs[index],
                                context: context,
                                statefulNavigationShell: statefulNavigationShell,
                              );
                            },
                            children: [
                              for (final tab
                                  in NavigationTab.navigationTabs(deviceType: deviceType)) ...[
                                    if (!tab.isSettings)
                                NavigationItem(
                                  child: Icon(tab.icon),
                                  alignment: Alignment.centerLeft,
                                  label: Text(tab.label),
                                  selectedStyle: const ButtonStyle.primaryIcon(),
                                ),
                              ],
                              NavigationItem(
                                child: Icon(NavigationTab.settings.icon),
                                alignment: Alignment.centerLeft,
                                label: Text(NavigationTab.settings.label),
                                selectedStyle: const ButtonStyle.primaryIcon(),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(),
                        Expanded(child: statefulNavigationShell),
                      ],
                    );
                  },
                ),
              );
          }
        },
        viewModelBuilder: () => ShellViewModel.locate,
      );
}
