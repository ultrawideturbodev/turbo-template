import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/routing/enums/navigation_tab.dart';
import 'package:turbo_template/ui/enums/turbo_device_type.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/routing/shell/shell_view_model.dart';
import 'package:turbo_template/ui/widgets/turbo_scaffold.dart';
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
          print(
              '''[🐛] [PRINT] [🌟] [ShellView.build] [📞] context.data.deviceType: ${context.data.deviceType}''');
          switch (context.data.deviceType) {
            case TurboDeviceType.mobile:
              return TurboScaffold(
                child: statefulNavigationShell,
                footers: [
                  ValueListenableBuilder<NavigationTab>(
                    valueListenable: model.currentNavigationTab,
                    builder: (context, currentNavigationTab, child) => NavigationBar(
                      backgroundColor: context.colors.shellBackground,
                      labelType: NavigationLabelType.all,
                      onSelected: (int index) => model.onNavigationTap(
                        NavigationTab.values[index],
                        statefulNavigationShell: statefulNavigationShell,
                        context: context,
                      ),
                      index: currentNavigationTab.index,
                      children: NavigationTab.values
                          .map(
                            (bottomNavigationTab) => NavigationItem(
                              style: const ButtonStyle.muted(density: ButtonDensity.icon),
                              selectedStyle: const ButtonStyle.fixed(density: ButtonDensity.icon),
                              label: Text(bottomNavigationTab.label),
                              child: Icon(bottomNavigationTab.icon),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              );
            case TurboDeviceType.tablet:
            case TurboDeviceType.desktop:
              return TurboScaffold(
                child: ValueListenableBuilder<NavigationTab>(
                  valueListenable: model.currentNavigationTab,
                  builder: (context, currentNavigationTab, child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: model.menuIsExpanded,
                          builder: (context, menuIsExpanded, child) => NavigationRail(
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
                            onSelected: (index) => model.onNavigationTap(
                              NavigationTab.values[index],
                              context: context,
                              statefulNavigationShell: statefulNavigationShell,
                            ),
                            children: [
                              for (final tab in NavigationTab.values)
                                NavigationItem(
                                  child: Icon(tab.icon),
                                  alignment: Alignment.centerLeft,
                                  label: Text(tab.label),
                                  selectedStyle: const ButtonStyle.primaryIcon(),
                                ),
                              // const NavigationDivider(),
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
