import 'package:cached_network_image/cached_network_image.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';
import 'package:turbo_template/ui/abstracts/turbo_button_type.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/extensions/wrapper_extensions.dart';
import 'package:turbo_template/ui/widgets/turbo_card.dart';
import 'package:turbo_template/ui/widgets/turbo_list_item.dart';
import 'package:turbo_template/ui/widgets/turbo_app_bar.dart';
import 'package:turbo_template/ui/widgets/turbo_bread_crumb.dart';
import 'package:turbo_template/ui/widgets/turbo_bread_crumps.dart';
import 'package:turbo_template/ui/widgets/turbo_scaffold.dart';
import 'package:turbo_template/ui/widgets/turbo_gap.dart';
import 'package:turbo_template/ui/widgets/turbo_scroll_view.dart';
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
        return TurboScaffold(
          headers: [
            TurboAppBar(
              leading: [
                TIconButton.goBack(
                  context: context,
                  onFail: null,
                ),
              ],
              title: model.title,
              subtitle: 'wow',
              trailing: [
                TIconButton.theme(
                  onPressed: model.onThemeModePressed,
                  themeMode: context.turboProvider.themeMode,
                ),
                TIconButton.logout(onPressed: model.onLogoutPressed),
              ],
            ),
            TurboBreadCrumbs(
              turboBreadCrumbs: [
                TurboTextCrumb(
                  text: 'Home',
                  onPressed: () {
                    print('wtf');
                  },
                ),
                const TurboMoreDotsCrumb(),
                const TurboTextCrumb(text: 'wtf'),
                const TurboTextCrumb(text: 'wtf'),
              ],
            ).wrapMargin(
              edgeInsets: const EdgeInsets.only(
                left: kSizesAppPadding,
                bottom: kSizesAppPadding,
              ),
            ),
          ],
          child: TurboScrollView(
            child: Column(
              children: [
                TurboCard(
                  type: TCtaCard(
                    title: 'wtf',
                    subtitle: 'cool',
                    onPrimaryPressed: TTextButton(
                      text: 'damn',
                      onPressed: () {},
                    ),
                    onSecondaryPressed: TTextButton(
                      text: 'damn',
                      onPressed: () {},
                    ),
                  ),
                ),
                const TGap.section(),
                Column(
                  children: [
                    TurboListItem(
                      type: TPlainListItem(
                        title: 'wtf',
                        subtitle: 'nice',
                        trailing: [
                          TIconButton.goBack(
                            context: context,
                            onFail: null,
                          ),
                          TTextButton(
                            text: 'text',
                            onPressed: () {},
                          )
                        ],
                      ),
                    ).wrapHoPadding(),
                    const TGap.listItem(),
                    TurboListItem(
                      type: TAvatarListItem(
                        avatar: Avatar(
                          initials: Avatar.getInitials('Brian Manuputty'),
                        ),
                        title: 'wtf',
                        subtitle: 'nice',
                        trailing: [
                          TIconButton.goBack(
                            context: context,
                            onFail: null,
                          ),
                          TTextButton(
                            text: 'text',
                            onPressed: () {},
                          )
                        ],
                      ),
                    ).wrapCard(),
                  ],
                ),
                const TGap.section(),
              ],
            ).wrapHoPadding(),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel.locate,
    );
  }
}
