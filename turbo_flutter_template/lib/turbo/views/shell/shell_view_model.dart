import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/home/routing/home_router.dart';
import 'package:veto/data/mixins/busy_service_management.dart';
import 'package:veto/data/models/base_view_model.dart';

import '../../../auth/services/auth_service.dart';
import '../../../auth/services/user_service.dart';
import '../../enums/navigation_tab.dart';
import '../../services/navigation_tab_service.dart';

class ShellViewModel extends BaseViewModel with Loglytics, BusyServiceManagement {
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _homeRouter = HomeRouter.locate;
  final _navigationTabService = NavigationTabService.locate;

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

  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  List<NavigationTab> get navigationTabs => NavigationTab.values;
  ValueListenable<NavigationTab> get currentNavigationTab => _navigationTabService.navigationTab;

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void onNavigationTap(
    NavigationTab navigationTab, {
    required BuildContext context,
    required StatefulNavigationShell statefulNavigationShell,
  }) {
    log.info('Navigating to $navigationTab');
    switch (navigationTab) {
      case NavigationTab.home:
        _homeRouter.goHomeView();
        break;
      case NavigationTab.theSecond:
        // TODO: Implement navigation for theSecond tab
        statefulNavigationShell.goBranch(navigationTab.index);
        break;
      case NavigationTab.theActionButton:
        // TODO: Implement navigation for theActionButton tab
        statefulNavigationShell.goBranch(navigationTab.index);
        break;
      case NavigationTab.theThird:
        // TODO: Implement navigation for theThird tab
        statefulNavigationShell.goBranch(navigationTab.index);
        break;
      case NavigationTab.theFourth:
        // TODO: Implement navigation for theFourth tab
        statefulNavigationShell.goBranch(navigationTab.index);
        break;
    }
    log.info('Navigated to $navigationTab');
  }

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static ShellViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(ShellViewModel.new);
}
