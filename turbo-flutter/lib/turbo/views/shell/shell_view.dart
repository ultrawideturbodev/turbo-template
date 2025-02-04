import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
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
                backgroundColor: context.t.colors.shellBackground,
                footers: const [
                  Text('wtf'),
                ],
                child: isInitialised ? body : kWidgetsNothing,
              );
            case SupportedPlatform.web:
              return Scaffold(
                backgroundColor: context.t.colors.background,
                child: isInitialised
                    ? ValueListenableBuilder<NavigationTab>(
                        valueListenable: model.currentNavigationTab,
                        builder: (context, currentNavigationTab, child) {
                          final sideNavBarWidth = context.t.config.sideNavBarWidth;
                          final sizes = context.t.sizes;
                          return SizedBox(
                            width: sizes.width,
                            height: sizes.height,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: sideNavBarWidth,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Gap(kSizesAppPadding),
                                        SizedBox(
                                          width: context.t.config.sideNavBarWidth,
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Placeholder'),
                                            ],
                                          ),
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: context.t.config.sideNavBarWidth,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(kSizesAppPadding),
                                              child: AutoSizeText(
                                                'Placeholder',
                                                style: context.t.texts.sectionHeader,
                                                maxLines: 1,
                                                textScaleFactor: context.t.tools.scaledPerWidth(1),
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
                                              NavigationTab.theSecond => null,
                                              NavigationTab.theActionButton => null,
                                              NavigationTab.theThird => null,
                                              NavigationTab.theFourth => null,
                                            },
                                          ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: kSizesAppPadding),
                                          child: Button.primary(
                                            onPressed: model.onLogoutPressed,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.logout),
                                                const Gap(8),
                                                Text(
                                                  'Logout',
                                                  style: context.t.texts.button,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Gap(16),
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
                                    color: context.t.colors.border,
                                  ),
                                  SizedBox(
                                    width: sizes.width - sideNavBarWidth - 1,
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
