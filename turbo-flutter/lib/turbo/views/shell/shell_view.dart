import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/constants/k_sizes.dart';
import 'package:turbo_template/turbo/constants/k_widgets.dart';
import 'package:turbo_template/turbo/enums/navigation_tab.dart';
import 'package:turbo_template/turbo/enums/turbo_device_type.dart';
import 'package:turbo_template/turbo/extensions/context_extension.dart';
import 'package:turbo_template/turbo/views/shell/shell_view_model.dart';
import 'package:turbo_template/turbo/widgets/layout/turbo_scaffold.dart';
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
          switch (context.data.deviceType) {
            case TurboDeviceType.mobile:
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
                            backgroundColor: context.colors.scheme.card,
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
                              NavigationButton(
                                child: const Icon(Icons.menu),
                                alignment: Alignment.centerLeft,
                                label: const Text('Menu'),
                                onPressed: model.onHamburgerIconPressed,
                              ),
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
