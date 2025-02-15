import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/routing/models/origin_arguments.dart';
import 'package:turbo_template/state/views/placeholder/placeholder_arguments.dart';
import 'package:turbo_template/state/views/placeholder/placeholder_origin.dart';
import 'package:turbo_template/state/views/placeholder/placeholder_view_model.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/ui/widgets/t_scaffold.dart';
import 'package:turbo_template/ui/widgets/t_scroll_view.dart';
import 'package:veto/data/models/base_view_model.dart';

class PlaceholderView extends StatelessWidget {
  const PlaceholderView({
    super.key,
    required this.arguments,
    required this.origin,
  });

  final PlaceholderArguments arguments;
  final PlaceholderOrigin origin;

  static const String path = 'placeholder';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlaceholderViewModel>(
      isReactive: false,
      argumentBuilder: () => OriginArguments(data: arguments, origin: origin),
      builder: (context, model, isInitialised, child) {
        if (!isInitialised) return kWidgetsNothing;
        return TScaffold(
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
                      onPressed: () {},
                      density: ButtonDensity.compact,
                      child: const Text('Components'),
                    ),
                    const Text('Breadcrumb'),
                  ],
                ),
              ],
            ),
          ],
          child: const TScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [],
            ),
          ),
        );
      },
      viewModelBuilder: () => PlaceholderViewModel.locate,
    );
  }
}
