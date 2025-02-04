import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'package:turbo_template/turbo/constants/k_widgets.dart';
import 'package:turbo_template/turbo/enums/emoji.dart';
import 'package:turbo_template/turbo/models/origin_arguments.dart';
import 'package:turbo_template/turbo/views/placeholder/placeholder_arguments.dart';
import 'package:turbo_template/turbo/views/placeholder/placeholder_origin.dart';
import 'package:turbo_template/turbo/views/placeholder/placeholder_view_model.dart';
import 'package:turbo_template/turbo/widgets/emoji_header.dart';
import 'package:turbo_template/turbo/widgets/turbo_app_bar.dart';
import 'package:turbo_template/turbo/widgets/turbo_scroll_view.dart';
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
        return Scaffold(
          headers: [
            TurboAppBar(
              context: context,
              header: const EmojiHeader.scaffoldTitle(
                emoji: Emoji.unicorn,
                title: 'Placeholder',
              ),
            )
          ],
          child: const TurboScrollView(
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
