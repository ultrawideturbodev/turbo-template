import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:{{packageName.snakeCase()}}/routing/models/origin_arguments.dart';
import 'package:{{packageName.snakeCase()}}/state/views/placeholder/placeholder_arguments.dart';
import 'package:{{packageName.snakeCase()}}/state/views/placeholder/placeholder_origin.dart';
import 'package:veto/data/models/base_view_model.dart';

class PlaceholderViewModel
    extends BaseViewModel<OriginArguments<PlaceholderOrigin, PlaceholderArguments>> with Loglytics {
  PlaceholderViewModel._();

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static PlaceholderViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(PlaceholderViewModel._);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> initialise() async {
    super.initialise();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  PlaceholderOrigin get origin => arguments.origin;
  PlaceholderArguments get args => arguments.data;

  // 🏗 HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\
}
