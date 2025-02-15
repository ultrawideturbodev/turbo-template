import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/data/constants/k_sizes.dart';
import 'package:turbo_template/data/enums/t_png.dart';
import 'package:turbo_template/state/extensions/context_extension.dart';
import 'package:turbo_template/ui/config/turbo_button_config.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/ui/enums/t_device_type.dart';
import 'package:turbo_template/ui/widgets/t_app_bar.dart';
import 'package:turbo_template/ui/widgets/t_card.dart';
import 'package:turbo_template/ui/widgets/t_card_column.dart';
import 'package:turbo_template/ui/widgets/t_column.dart';
import 'package:turbo_template/ui/widgets/t_list_item.dart';
import 'package:turbo_template/ui/widgets/t_margin.dart';
import 'package:turbo_template/ui/widgets/t_png_image.dart';
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
                if (context.data.deviceType == TDeviceType.mobile)
                  TButtonIconConfig.settings(onPressed: model.onSettingsPressed),
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
                    trailingTitle: TPngImage(png: TPng.shoppingBags),
                    title: 'Shopping List',
                    subtitle: 'Items in your shopping list',
                    children: [
                      TListItem(title: 'Snoep', subtitle: 'Candy'),
                      TListItem(title: 'Snoep', subtitle: 'Candy'),
                      TListItem(title: 'Snoep', subtitle: 'Candy'),
                    ],
                  ),
                ),
              ),
              TMargin.horizontal(
                child: TCard(
                  child: TCardColumn(
                    trailingTitle: TPngImage(png: TPng.soap),
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
