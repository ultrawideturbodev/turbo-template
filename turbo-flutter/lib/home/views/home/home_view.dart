import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/config/turbo_button_config.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/ui/extensions/wrapper_extensions.dart';
import 'package:turbo_template/ui/widgets/t_logo.dart';
import 'package:turbo_template/ui/widgets/t_margin.dart';
import 'package:turbo_template/ui/widgets/t_app_bar.dart';
import 'package:turbo_template/ui/config/t_crumb_config.dart';
import 'package:turbo_template/ui/widgets/t_column.dart';
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
              title: model.title,
              trailing: [
                TButtonIconConfig.theme(
                  onPressed: model.onThemeModePressed,
                  themeMode: context.turboProvider.themeMode,
                ),
                TButtonIconConfig.logout(onPressed: model.onLogoutPressed),
              ],
            ),
          ],
          child: const TScrollView(
            child: TColumn(children: [
              TMargin.horizontal(
                top: kSizesAppPadding,
                child: TCard(
                  child: TCardColumn(
                    trailingTitle: TLogo(),
                    title: 'Shopping List Items',
                    subtitle: 'Items in your shopping list',
                    children: [
                      TListItem(title: 'Snoep', subtitle: 'Candy'),
                    ],
                  ),
                ),
              ),
              TMargin.horizontal(
                child: TCard(
                  child: TCardColumn(
                    trailingTitle: TLogo(),
                    title: 'Cleaning Schedule',
                    subtitle: 'We need to clean the house. Let\'s make a schedule. Shall we?',
                    children: [
                      TListItem(title: 'Snoep', subtitle: 'Candy'),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel.locate,
    );
  }
}
