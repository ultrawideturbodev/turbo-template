import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:veto/data/models/base_view_model.dart';

class AcceptPrivacyViewModel extends BaseViewModel with Loglytics {
  AcceptPrivacyViewModel();

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static AcceptPrivacyViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(() => AcceptPrivacyViewModel());

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
