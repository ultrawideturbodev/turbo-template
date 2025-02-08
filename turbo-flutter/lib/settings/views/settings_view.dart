import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/routing/models/origin_arguments.dart';
import 'package:turbo_template/settings/views/settings_view_arguments.dart';
import 'package:turbo_template/settings/views/settings_view_model.dart';
import 'package:turbo_template/settings/views/settings_view_origin.dart';
import 'package:turbo_template/typography/widgets/emoji_header.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/ui/enums/emoji.dart';
import 'package:turbo_template/ui/widgets/turbo_app_bar.dart';
import 'package:veto/data/models/base_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
    required this.arguments,
    required this.origin,
  });

  final SettingsViewArguments arguments;
  final SettingsViewOrigin origin;

  static const String path = 'settings-view';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>(
      isReactive: false,
      argumentBuilder: () => OriginArguments(data: arguments, origin: origin),
      builder: (context, model, isInitialised, child) {
        if (!isInitialised) return kWidgetsNothing;
        return const Scaffold(
          headers: [
            TurboAppBar(
              header: 'Settings',
            )
          ],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [],
            ),
          ),
        );
      },
      viewModelBuilder: () => SettingsViewModel.locate,
    );
  }
}
