import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/config/turbo_button_config.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/ui/extensions/wrapper_extensions.dart';
import 'package:turbo_template/ui/widgets/margin.dart';
import 'package:turbo_template/ui/widgets/t_app_bar.dart';
import 'package:turbo_template/ui/config/t_crumb_config.dart';
import 'package:turbo_template/ui/widgets/t_crumbs.dart';
import 'package:turbo_template/ui/widgets/t_card.dart';
import 'package:turbo_template/ui/widgets/t_card_column.dart';
import 'package:turbo_template/ui/widgets/t_gap.dart';
import 'package:turbo_template/ui/widgets/t_row.dart';
import 'package:turbo_template/ui/widgets/t_list_item.dart';
import 'package:turbo_template/ui/widgets/t_scaffold.dart';
import 'package:turbo_template/ui/widgets/t_scroll_view.dart';
import 'package:veto/data/models/base_view_model.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  static const String path = 'home';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>(
      builder: (context, model, isInitialised, child) {
        if (!isInitialised) return kWidgetsNothing;
        return TScaffold(
          headers: [
            TAppBar(
              leading: [
                TButtonIconConfig.goBack(
                  context: context,
                  onFail: null,
                ),
              ],
              title: model.title,
              subtitle: 'wow',
              trailing: [
                TButtonIconConfig.theme(
                  onPressed: model.onThemeModePressed,
                  themeMode: context.turboProvider.themeMode,
                ),
                TButtonIconConfig.logout(onPressed: model.onLogoutPressed),
              ],
            ),
            TCrumbs(
              tCrumbs: [
                TCrumbText(
                  text: 'Home',
                  onPressed: () {
                    print('wtf');
                  },
                ),
                const TCrumbDots(),
                const TCrumbText(text: 'wtf'),
                const TCrumbText(text: 'wtf'),
              ],
            ).wrapMargin(
              edgeInsets: const EdgeInsets.only(
                left: kSizesAppPadding,
                bottom: kSizesAppPadding,
              ),
            ),
          ],
          child: TScrollView(
            child: Margin.horizontal(
              child: Column(
                children: [
                  TCard(
                    child: TCardColumn(
                      title: 'wtf',
                      subtitle: 'cool',
                      onPrimaryPressed: TButtonTextConfig(
                        text: 'damn',
                        onPressed: () {},
                      ),
                      onSecondaryPressed: TButtonTextConfig(
                        text: 'damn',
                        onPressed: () {},
                      ),
                    ),
                  ),
                  const TGap.section(),
                  Column(
                    children: [
                      const Margin.horizontal(
                        child: TCard(
                          child: TListItem(
                            title: 'wtf',
                            subtitle: 'nice',
                            trailing: [],
                          ),
                        ),
                      ),
                      const TGap.listItem(),
                      TCard(
                        child: TListItemAvatar(
                          avatar: Avatar(
                            initials: Avatar.getInitials('Brian Manuputty'),
                          ),
                          title: 'wtf',
                          subtitle: 'nice',
                        ),
                      ),
                    ],
                  ),
                  const TGap.section(),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel.locate,
    );
  }
}
