import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/auth/mixins/logout_management.dart';
import 'package:turbo_template/auth/services/auth_service.dart';
import 'package:turbo_template/turbo/routing/core_router.dart';
import 'package:turbo_template/turbo/services/dialog_service.dart';
import 'package:veto/data/models/base_view_model.dart';

class HomeViewModel extends BaseViewModel with Loglytics, LogoutManagement {
  HomeViewModel();

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static HomeViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(() => HomeViewModel());

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _dialogService = DialogService.lazyLocate;
  final _authService = AuthService.lazyLocate;
  final _coreRouter = CoreRouter.lazyLocate;


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

  // 🏗 HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

}
