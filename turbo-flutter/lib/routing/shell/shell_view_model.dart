import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/auth/services/auth_service.dart';
import 'package:turbo_template/auth/services/user_service.dart';
import 'package:turbo_template/home/routers/home_router.dart';
import 'package:turbo_template/state/views/placeholder/placeholder_router.dart';
import 'package:turbo_template/routing/enums/navigation_tab.dart';
import 'package:turbo_template/routing/routers/core_router.dart';
import 'package:turbo_template/feedback/services/dialog_service.dart';
import 'package:turbo_template/routing/services/navigation_tab_service.dart';
import 'package:turbo_template/settings/routing/settings_router.dart';
import 'package:veto/data/mixins/busy_service_management.dart';
import 'package:veto/data/models/base_view_model.dart';

class ShellViewModel extends BaseViewModel with Loglytics, BusyServiceManagement {
  static ShellViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(ShellViewModel.new);

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _dialogService = DialogService.locate;
  final _homeRouter = HomeRouter.locate;
  final _placeholderRouter = PlaceholderRouter.locate;
  final _navigationTabService = NavigationTabService.locate;
  final _settingsRouter = SettingsRouter.locate;
  late final _authService = AuthService.locate;
  late final _coreRouter = CoreRouter.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> initialise() async {
    try {
      log.info('Initialising ShellViewModel..');
      log.info('Waiting for auth services to be ready..');
      final authService = AuthService.locate;
      final userService = UserService.locate;
      await Future.wait([
        authService.didManageUserLevel,
        userService.isReady,
      ]);
      super.initialise();
      log.info('ShellViewModel initialised');
    } catch (error, stackTrace) {
      log.error(
        '$error caught while initialising ShellViewModel',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
  }

  @override
  Future<void> dispose() async {
    log.info('Disposing ShellViewModel..');
    super.dispose();
    log.info('ShellViewModel disposed!');
  }

  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  final _menuIsExpanded = Informer<bool>(true);
  // TODO(brian): Save this in local storage | 06/02/2025

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  List<NavigationTab> get navigationTabs => NavigationTab.values;
  ValueListenable<NavigationTab> get currentNavigationTab => _navigationTabService.navigationTab;
  ValueListenable<bool> get menuIsExpanded => _menuIsExpanded;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void toggleMenuExpandedState() => _menuIsExpanded.updateCurrent((value) => !value);

  void onNavigationTap(
    NavigationTab navigationTab, {
    required BuildContext context,
    required StatefulNavigationShell statefulNavigationShell,
  }) {
    if (currentNavigationTab.value == navigationTab) {
      toggleMenuExpandedState();
      return;
    }
    log.info('Navigating to $navigationTab');
    switch (navigationTab) {
      case NavigationTab.home:
        _homeRouter.goHomeView();
        break;
      case NavigationTab.placeholder:
        _placeholderRouter.goPlaceholderView(
          statefulNavigationShell: statefulNavigationShell,
        );
        break;
      case NavigationTab.settings:
        _settingsRouter.goSettingsView(
          statefulNavigationShell: statefulNavigationShell,
        );
        break;
    }
    log.info('Navigated to $navigationTab');
  }
}
