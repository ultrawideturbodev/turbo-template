import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:veto/data/models/base_view_model.dart';

class HomeViewModel extends BaseViewModel with Loglytics {
  HomeViewModel();

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static HomeViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(() => HomeViewModel());

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

  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗 HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\
}
