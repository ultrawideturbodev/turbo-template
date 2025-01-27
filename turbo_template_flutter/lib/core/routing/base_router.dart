import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:loglytics/loglytics.dart';

import '../../auth/enums/forgot_password_origin.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/views/accept_privacy/accept_privacy_view.dart';
import '../../auth/views/auth/auth_view.dart';
import '../../auth/views/create_username/create_username_view.dart';
import '../../auth/views/forgot_password/forgot_password_view.dart';
import '../../auth/views/verify_email/verify_email_view.dart';
import '../../home/views/home/home_view.dart';
import '../constants/k_durations.dart';
import '../dtos/extra_arguments.dart';
import '../enums/navigation_tab.dart';
import '../extensions/object_extension.dart';
import '../extensions/string_extension.dart';
import '../../local_storage/services/local_storage_service.dart';
import '../services/navigation_tab_service.dart';
import '../utils/transition_builders.dart';
import '../views/oops/oops_view.dart';
import '../views/shell/shell_view.dart';
import '../views/startup/startup_view.dart';

/// Origins should be routers to determine which router to use for navigation
/// Types should be used to determine logic
class BaseRouter with Loglytics {
  BaseRouter() {
    coreRouter.routerDelegate.addListener(onRouteChanged);
  }
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static BaseRouter get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(BaseRouter.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  String _route = '';
  String get route => _route;
  bool didInitialLocation = false;

  /// [CoreRouter]
  final coreRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: StartupView.path.asRootPath,
    routes: [
      acceptPrivacyView,
      authView,
      oopsView,
      createUsernameView,
      verifyEmailView,
      forgotPasswordView(origin: ForgotPasswordOrigin.core),
      startupView,
      shellView,
    ],
  );

  static Page<dynamic> _buildPage({required Widget child}) {
    if (kIsWeb || Platform.isAndroid) {
      return MaterialPage(child: child);
    } else {
      return CupertinoPage(child: child);
    }
  }

  static GoRoute get oopsView => GoRoute(
        path: OopsView.path.asRootPath,
        pageBuilder: (context, state) => const MaterialPage(
          child: OopsView(),
        ),
      );

  static GoRoute forgotPasswordView({required ForgotPasswordOrigin origin}) => GoRoute(
        path: ForgotPasswordView.path.asRootPath,
        pageBuilder: (context, state) => _buildPage(
          child: ForgotPasswordView(
            origin: origin,
          ),
        ),
      );

  static GoRoute get authView => GoRoute(
        path: AuthView.path.asRootPath,
        pageBuilder: (context, state) => _buildPage(
          child: const AuthView(),
        ),
      );

  static GoRoute get createUsernameView => GoRoute(
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

  static GoRoute get acceptPrivacyView => GoRoute(
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

  static GoRoute get verifyEmailView => GoRoute(
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

  /// Order of [StatefulShellBranch] is important.
  static StatefulShellRoute get shellView => StatefulShellRoute.indexedStack(
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
        ],
      );

  static GoRoute get homeRouter => GoRoute(
        path: HomeView.path.asRootPath,
        redirect: (context, state) => _onHomeAccess(
          context: context,
          state: state,
        ),
        pageBuilder: (context, state) => _buildPage(
          child: const HomeView(),
        ),
        routes: const [],
      );

  static FutureOr<String?> _onHomeAccess({
    required BuildContext context,
    required GoRouterState state,
  }) async {
    final localStoreService = LocalStorageService.locate;
    // if logged in go to home, otherwise onboarding
    if (localStoreService.hasAuth || await AuthService.locate.hasReadyAuth) {
      await localStoreService.updateHasAuth(hasAuth: true);

      if (!BaseRouter.locate.didInitialLocation) {
        BaseRouter.locate.didInitialLocation = true;
      }

      return null;
    } else {
      return StartupView.path.asRootPath;
    }
  }

  static GoRoute get startupView => GoRoute(
        path: StartupView.path.asRootPath,
        pageBuilder: (context, state) => _buildPage(
          child: const StartupView(),
        ),
      );

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  BuildContext get context => rootNavigatorKey.currentContext!;

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

  void _trySendScreenAnalytic({required String route}) {
    if (_route != route) {
      analytics.service.screen(subject: route);
      _route = route;
    }
  }

// 🏗️ HELPERS ------------------------------------------------------------------------------- \\
// 🪄 MUTATORS ----------------------------  -------------------------------------------------- \\
}

extension on GoRouterState {
  ExtraArguments? arguments() => extra?.asType<ExtraArguments>();
}
