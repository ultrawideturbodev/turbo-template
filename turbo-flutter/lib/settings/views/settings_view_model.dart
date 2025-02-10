import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/routing/models/origin_arguments.dart';
import 'package:turbo_template/settings/forms/t_example_form.dart';
import 'package:turbo_template/settings/views/settings_view_origin.dart';
import 'package:veto/data/models/base_view_model.dart';

import 'settings_view_arguments.dart';

class SettingsViewModel
    extends BaseViewModel<OriginArguments<SettingsViewOrigin, SettingsViewArguments>>
    with Loglytics {
  SettingsViewModel();

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static SettingsViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(() => SettingsViewModel());

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  late final _form = TExampleForm.locate(initialValue: null);

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> initialise() async {
    super.initialise();
  }

  @override
  Future<void> dispose() async {
    _form.dispose();
    super.dispose();
  }

  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  SettingsViewOrigin get origin => arguments.origin;
  SettingsViewArguments get args => arguments.data;
  TExampleForm get form => _form;

  // 🏗 HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\
}
