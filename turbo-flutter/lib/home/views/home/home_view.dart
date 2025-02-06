import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/turbo/constants/k_widgets.dart';
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  clipBehavior: Clip.none,
                  child: AppBar(
                    header: const Text('This is Header'),
                    subtitle: const Text('This is Subtitle'),
                    leading: [
                      OutlineButton(
                        density: ButtonDensity.icon,
                        onPressed: () {},
                        child: const Icon(Icons.arrow_back),
                      ),
                    ],
                    trailing: [
                      OutlineButton(
                        density: ButtonDensity.icon,
                        onPressed: () {},
                        child: const Icon(Icons.search),
                      ),
                      OutlineButton(
                        density: ButtonDensity.icon,
                        onPressed: () {},
                        child: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Breadcrumb(
                  separator: Breadcrumb.arrowSeparator,
                  children: [
                    TextButton(
                      onPressed: () {},
                      density: ButtonDensity.compact,
                      child: const Text('Home'),
                    ),
                    const MoreDots(),
                    TextButton(
                      onPressed: () => model.onLogoutPressed(context: context),
                      density: ButtonDensity.compact,
                      child: const Text('Components'),
                    ),
                    const Text('Breadcrumb'),
                  ],
                ),
              ],
            ),
          ],
          child: const TurboScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [],
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel.locate,
    );
  }
}
