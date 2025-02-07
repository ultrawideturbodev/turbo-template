import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/config/turbo_button_config.dart';
import 'package:turbo_template/turbo/constants/k_widgets.dart';
import 'package:turbo_template/turbo/widgets/cards/turbo_card.dart';
import 'package:turbo_template/turbo/widgets/layout/turbo_app_bar.dart';
import 'package:turbo_template/turbo/widgets/layout/turbo_bread_crumb.dart';
import 'package:turbo_template/turbo/widgets/layout/turbo_bread_crumps.dart';
import 'package:turbo_template/turbo/widgets/layout/turbo_scaffold.dart';
import 'package:turbo_template/turbo/widgets/turbo_scroll_view.dart';
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
            ),
            TurboAppBar(
              leading: [
                TurboIconButtonConfig.goBack(
                  context: context,
                  onFail: null,
                ),
              ],
              title: model.title,
              subtitle: 'wow',
              trailing: [
                TurboIconButtonConfig.logout(onPressed: model.onLogoutPressed),
              ],
            ),
          ],
          child: TurboScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TurboCard(
                  type: TurboCtaCard(
                    title: 'wtf',
                    subtitle: 'cool',
                    onPrimaryPressed: TurboTextButtonConfig(
                      text: 'damn',
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel.locate,
    );
  }
}
