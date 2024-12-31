import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/features/home/routing/home_router.dart';
import 'package:veto/data/models/base_view_model.dart';

import '../../../features/auth/services/auth_step_service.dart';
import '../../enums/step_result.dart';
import '../../globals/g_user_id.dart';
import '../../routing/core_router.dart';
import '../../services/local_storage_service.dart';

class StartupViewModel extends BaseViewModel with Loglytics {
  StartupViewModel();

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static StartupViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(() => StartupViewModel());

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _localStorageService = LocalStorageService.locate;
  final _authStepService = AuthStepService.locate;
  final _homeRouter = HomeRouter.locate;
  final _coreRouter = CoreRouter.locate;

  // 🎬 INIT & DISPOSE --------- --------------------------------------------------------------- \\

  @override
  Future<void> initialise() async {
    super.initialise();
    super.initialise();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (gHasAuth) {
          await _authStepService.isReady;
          final result = await _authStepService.handleAuthStep();
          switch (result) {
            case StepResult.didNavigate:
              break;
            case StepResult.didNothing:
              _homeRouter.goHomeView();
          }
          log.info('Startup step handled!');
        } else {
          _coreRouter.goAuthView();
        }
      },
    );
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
