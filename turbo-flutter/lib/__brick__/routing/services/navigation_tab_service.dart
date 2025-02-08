import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:{{packageName.snakeCase()}}/home/views/home/home_view.dart';
import 'package:{{packageName.snakeCase()}}/routing/enums/navigation_tab.dart';
import 'package:{{packageName.snakeCase()}}/auth/services/auth_service.dart';
import 'package:{{packageName.snakeCase()}}/local_storage/services/local_storage_service.dart';
import 'package:{{packageName.snakeCase()}}/data/extensions/string_extension.dart';
import 'package:{{packageName.snakeCase()}}/state/views/placeholder/placeholder_view.dart';

class NavigationTabService with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static NavigationTabService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(
        NavigationTabService.new,
      );

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _authService = AuthService.locate;
  final _localStorageService = LocalStorageService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  void dispose() {
    log.info('Disposing BottomNavigationService..');
    _navigationTab.dispose();
    log.info('BottomNavigationService disposed!');
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  final _navigationTab = Informer(NavigationTab.defaultValue);

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  NavigationTab get currentNavigationTab => _navigationTab.value;
  ValueListenable<bool> get hasAuth => _authService.hasAuth;
  ValueListenable<NavigationTab> get navigationTab => _navigationTab;
  String get initialLocation {
    final initialTab = _localStorageService.navigationTab;
    onGo(navigationTab: initialTab);
    switch (initialTab) {
      case NavigationTab.home:
        return HomeView.path.asRootPath;
      case NavigationTab.placeholder:
        return PlaceholderView.path.asRootPath;
    }
  }

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void updateNavigationTab({required NavigationTab navigationTab}) {
    _navigationTab.update(navigationTab);
    _localStorageService.updateNavigationTab(
      navigationTab: navigationTab,
    );
    log.info('Navigation tab updated to $navigationTab!');
  }

  void onGo({required NavigationTab navigationTab}) {
    if (this.navigationTab.value != navigationTab) {
      updateNavigationTab(
        navigationTab: navigationTab,
      );
    }
  }

// 🏗 HELPERS ------------------------------------------------------------------------------- \\
// 📍 LOCATOR ------------------------------------------------------------------------------- \\
}
