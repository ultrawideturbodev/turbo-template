import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:loglytics/loglytics.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/auth/services/auth_service.dart';
import 'package:turbo_template/auth/views/accept_privacy/accept_privacy_view.dart';
import 'package:turbo_template/auth/views/auth/auth_view.dart';
import 'package:turbo_template/auth/views/create_username/create_username_view.dart';
import 'package:turbo_template/auth/views/forgot_password/forgot_password_view.dart';
import 'package:turbo_template/auth/views/verify_email/verify_email_view.dart';
import 'package:turbo_template/home/views/home/home_view.dart';
import 'package:turbo_template/data/constants/k_durations.dart';
import 'package:turbo_template/data/constants/k_keys.dart';
import 'package:turbo_template/routing/models/extra_arguments.dart';
import 'package:turbo_template/routing/enums/navigation_tab.dart';
import 'package:turbo_template/data/extensions/object_extension.dart';
import 'package:turbo_template/data/extensions/string_extension.dart';
import 'package:turbo_template/routing/services/navigation_tab_service.dart';
import 'package:turbo_template/animations/widgets/transition_builders.dart';
import 'package:turbo_template/state/views/oops/oops_view.dart';
import 'package:turbo_template/state/views/placeholder/placeholder_arguments.dart';
import 'package:turbo_template/state/views/placeholder/placeholder_origin.dart';
import 'package:turbo_template/state/views/placeholder/placeholder_view.dart';
import 'package:turbo_template/routing/shell/shell_view.dart';
import 'package:turbo_template/settings/views/settings_view.dart';
import 'package:turbo_template/settings/views/settings_view_arguments.dart';
import 'package:turbo_template/settings/views/settings_view_origin.dart';

class BaseRouterService with Loglytics {
  BaseRouterService() {
    coreRouter.routerDelegate.addListener(onRouteChanged);
  }

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static BaseRouterService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(BaseRouterService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\

  void onRouteChanged({String? location}) {
    try {
      if (location != null) {
        _trySendScreenAnalytic(route: location);
        return;
      }
      final RouteMatch lastMatch = coreRouter.routerDelegate.currentConfiguration.last;
      final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
          ? lastMatch.matches
          : coreRouter.routerDelegate.currentConfiguration;
      final route = matchList.uri.toString();
      _trySendScreenAnalytic(route: route);
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while fetching location',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  String _route = '';
  bool didInitialLocation = false;

  // 🛣️ ROUTERS ------------------------------------------------------------------------------- \\

  final coreRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AuthView.path,
    routes: [
      acceptPrivacyView,
      authView,
      oopsView,
      createUsernameView,
      verifyEmailView,
      forgotPasswordView,
      shellView,
    ],
  );

  static GoRoute homeRouter = GoRoute(
    path: HomeView.path.asRootPath,
    redirect: (context, state) => _onAuthAccess(
      context: context,
      state: state,
      navigationTab: NavigationTab.home,
    ),
    pageBuilder: (context, state) => _buildPage(
      child: const HomeView(),
    ),
    routes: const [],
  );

  static GoRoute placeholderRouter = GoRoute(
    path: PlaceholderView.path.asRootPath,
    redirect: (context, state) => _onAuthAccess(
      context: context,
      state: state,
      navigationTab: NavigationTab.placeholder,
    ),
    pageBuilder: (context, state) => _buildPage(
      child: PlaceholderView(
        arguments: PlaceholderArguments(id: null),
        origin: PlaceholderOrigin.core,
      ),
    ),
    routes: const [],
  );

  static GoRoute settingsRouter = GoRoute(
    path: SettingsView.path.asRootPath,
    redirect: (context, state) => _onAuthAccess(
      context: context,
      state: state,
      navigationTab: NavigationTab.settings,
    ),
    pageBuilder: (context, state) => _buildPage(
      child: SettingsView(
        arguments: SettingsViewArguments(),
        origin: SettingsViewOrigin.core,
      ),
    ),
    routes: const [],
  );

  // 🎭 VIEWS --------------------------------------------------------------------------------- \\

  static StatefulShellRoute shellView = StatefulShellRoute.indexedStack(
    pageBuilder: (context, state, navigationShell) => _buildPage(
      child: ShellView(
        statefulNavigationShell: navigationShell,
      ),
    ),
    branches: [
      StatefulShellBranch(
        routes: [
          homeRouter,
        ],
      ),
      StatefulShellBranch(
        routes: [
          placeholderRouter,
        ],
      ),
      StatefulShellBranch(
        routes: [
          settingsRouter,
        ],
      ),
    ],
  );

  static GoRoute oopsView = GoRoute(
    path: OopsView.path.asRootPath,
    pageBuilder: (context, state) => const MaterialPage(
      child: OopsView(),
    ),
  );

  static GoRoute forgotPasswordView = GoRoute(
    path: ForgotPasswordView.path.asRootPath,
    pageBuilder: (context, state) => _buildPage(
      child: const ForgotPasswordView(),
    ),
  );

  static GoRoute authView = GoRoute(
    path: AuthView.path.asRootPath,
    pageBuilder: (context, state) => _buildPage(
      child: const AuthView(),
    ),
  );

  static GoRoute createUsernameView = GoRoute(
    path: CreateUsernameView.path.asRootPath,
    redirect: (context, state) {
      if (!AuthService.locate.hasAuth.value) {
        return AuthView.path.asRootPath;
      }
      return null;
    },
    pageBuilder: (context, state) => _buildPage(
      child: const CreateUsernameView(),
    ),
  );

  static GoRoute acceptPrivacyView = GoRoute(
    path: AcceptPrivacyView.path.asRootPath,
    redirect: (context, state) {
      if (!AuthService.locate.hasAuth.value) {
        return AuthView.path.asRootPath;
      }
      return null;
    },
    pageBuilder: (context, state) => _buildPage(
      child: const AcceptPrivacyView(),
    ),
  );

  static GoRoute verifyEmailView = GoRoute(
    path: VerifyEmailView.path.asRootPath,
    redirect: (context, state) {
      if (!AuthService.locate.hasAuth.value) {
        return AuthView.path.asRootPath;
      }
      return null;
    },
    pageBuilder: (context, state) => _buildPage(
      child: const VerifyEmailView(),
    ),
  );

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  String get route => _route;
  BuildContext get context => rootNavigatorKey.currentContext!;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  static FutureOr<String?> _onAuthAccess({
    required BuildContext context,
    required GoRouterState state,
    required NavigationTab? navigationTab,
  }) async {
    if (navigationTab != null) {
      NavigationTabService.locate.onGo(navigationTab: navigationTab);
    }
    if (await AuthService.locate.hasReadyAuth) {
      if (!BaseRouterService.locate.didInitialLocation) {
        BaseRouterService.locate.didInitialLocation = true;
      }
      return null;
    } else {
      return AuthView.path.asRootPath;
    }
  }

  static Page<dynamic> _buildPage({required Widget child, bool fullscreenDialog = false}) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return MaterialPage(
          child: child,
          fullscreenDialog: fullscreenDialog,
        );
      case TargetPlatform.iOS:
        return CupertinoPage(
          child: child,
          fullscreenDialog: fullscreenDialog,
        );
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
        return CustomTransitionPage(
          child: child,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          fullscreenDialog: fullscreenDialog,
          transitionDuration: kDurationsAnimationX0p5,
          reverseTransitionDuration: Duration.zero,
        );
    }
  }

  void _trySendScreenAnalytic({required String route}) {
    if (_route != route) {
      analytics.service.screen(subject: route);
      _route = route;
    }
  }

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\
}

extension on GoRouterState {
  ExtraArguments? arguments() => extra?.asType<ExtraArguments>();
  String? get id => pathParameters[kKeysId] ?? uri.queryParameters[kKeysId] ?? arguments()?.id;
}
