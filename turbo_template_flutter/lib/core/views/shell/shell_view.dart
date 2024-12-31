import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:veto/data/models/base_view_model.dart';
import 'package:veto/widgets/view_model_widget.dart';

import '../../constants/k_sizes.dart';
import '../../constants/k_widgets.dart';
import '../../enums/navigation_tab.dart';
import '../../enums/supported_platform.dart';
import '../../extensions/color_extension.dart';
import '../../extensions/context_extension.dart';
import '../../globals/g_env.dart';
import '../../widgets/custom_badge_container.dart';
import '../../widgets/hover_builder.dart';
import '../../widgets/opacity_button.dart';
import 'shell_view_model.dart';

part 'shell_menu_item.dart';

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
          switch (gPlatform) {
            case SupportedPlatform.mobile:
              final body = Column(
                children: [
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final media = context.media;
                        return MediaQuery(
                          data: media.copyWith(
                            viewInsets: media.viewInsets.copyWith(
                              bottom: max(
                                0,
                                media.viewInsets.bottom - kSizesHeightTabBarBottom,
                              ),
                            ),
                          ),
                          child: statefulNavigationShell,
                        );
                      },
                    ),
                  ),
                ],
              );
              return Scaffold(
                backgroundColor: context.tColors.shellBackground,
                bottomNavigationBar: ValueListenableBuilder<NavigationTab>(
                  valueListenable: model.currentNavigationTab,
                  builder: (context, currentNavigationTab, child) => Theme(
                    data: context.theme.copyWith(
                      splashColor: Colors.transparent,
                    ),
                    child: Theme(
                      data: context.theme.copyWith(
                        navigationBarTheme: context.theme.navigationBarTheme.copyWith(
                          labelTextStyle: WidgetStatePropertyAll(context.tTexts.navigationTab),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: NavigationBar(
                          elevation: 0,
                          backgroundColor: context.tColors.shellBackground,
                          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
                          onDestinationSelected: (int index) => model.onNavigationTap(
                            NavigationTab.values[index],
                            statefulNavigationShell: statefulNavigationShell,
                            context: context,
                          ),
                          selectedIndex: currentNavigationTab.index,
                          destinations: NavigationTab.values
                              .map(
                                (bottomNavigationTab) => NavigationDestination(
                                  icon: Icon(
                                    bottomNavigationTab.icon,
                                    color: context.tColors.background.onColor,
                                    size: 20,
                                  ),
                                  label: bottomNavigationTab.label,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                body: isInitialised ? body : kWidgetsNothing,
              );
            case SupportedPlatform.web:
              return Scaffold(
                backgroundColor: context.tColors.background,
                body: isInitialised
                    ? ValueListenableBuilder<NavigationTab>(
                        valueListenable: model.currentNavigationTab,
                        builder: (context, currentNavigationTab, child) {
                          final navBarWidth = context.tSizes.navBarWidth;
                          return SizedBox(
                            width: context.tSizes.width,
                            height: context.tSizes.height,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: navBarWidth,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Gap(kSizesAppPadding),
                                        SizedBox(
                                          width: context.tSizes.navBarWidth,
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Placeholder'),
                                            ],
                                          ),
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: context.tSizes.navBarWidth,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(kSizesAppPadding),
                                              child: AutoSizeText(
                                                'Placeholder',
                                                style: context.tTexts.sectionHeader,
                                                maxLines: 1,
                                                textScaleFactor: context.rTools.scaledPerWidth(1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        for (final navigationTab in model.navigationTabs)
                                          _ShellMenuItem(
                                            navigationTab: navigationTab,
                                            statefulNavigationShell: statefulNavigationShell,
                                            currentNavigationTab: currentNavigationTab,
                                            badgeNumber: switch (navigationTab) {
                                              NavigationTab.home => null,
                                              NavigationTab.settings => null,
                                            },
                                          ),
                                        const Spacer(),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Logo Placeholder'),
                                          ],
                                        ),
                                        const Gap(80),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    color: context.tColors.border,
                                  ),
                                  SizedBox(
                                    width: context.tSizes.width - navBarWidth - 1,
                                    child: statefulNavigationShell,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : kWidgetsNothing,
              );
          }
        },
        viewModelBuilder: () => ShellViewModel.locate,
      );
}
