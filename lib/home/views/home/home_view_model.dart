import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/auth/mixins/logout_management.dart';
import 'package:turbo_template/settings/routing/settings_router.dart';
import 'package:turbo_template/ui/services/theme_service.dart';
import 'package:veto/data/models/base_view_model.dart';

class HomeViewModel extends BaseViewModel with Loglytics, LogoutManagement {
  HomeViewModel();

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static HomeViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(() => HomeViewModel());

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _settingsRouter = SettingsRouter.lazyLocate;
  final _themeService = ThemeService.lazyLocate;

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

  String get title => 'Home';

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void onSettingsPressed() {
    final settingsRouter = _settingsRouter();
    settingsRouter.goSettingsView();
  }

  void onThemeModePressed() {
    final themeService = _themeService();
    themeService.switchThemeMode();
  }
}
