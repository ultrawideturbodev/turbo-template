import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:provider/provider.dart';
import 'package:turbo_template/features/auth/routing/auth_step_router.dart';
import 'package:turbo_template/features/auth/views/accept_privacy/accept_privacy_view_model.dart';
import 'package:turbo_template/features/auth/views/create_username/create_username_view_model.dart';
import 'package:turbo_template/features/auth/views/verify_email/verify_email_view_model.dart';
import 'package:turbo_template/features/settings/services/settings_service.dart';
import 'package:url_strategy/url_strategy.dart';

import '../../../core/strings/gen/l10n.dart';
import '../../features/auth/apis/user_profiles_api.dart';
import '../../features/auth/apis/usernames_api.dart';
import '../../features/auth/apis/users_api.dart';
import '../../features/auth/forms/forgot_password.dart';
import '../../features/auth/forms/login_form.dart';
import '../../features/auth/forms/register_form.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/auth/services/auth_step_service.dart';
import '../../features/auth/services/email_service.dart';
import '../../features/auth/services/permissions_service.dart';
import '../../features/auth/services/user_service.dart';
import '../../features/auth/views/auth/auth_view_model.dart';
import '../../features/auth/views/forgot_password/forgot_password_view_model.dart';
import '../../features/home/routing/home_router.dart';
import '../enums/environment.dart';
import '../routing/base_router.dart';
import '../routing/core_router.dart';
import '../services/connection_service.dart';
import '../services/feedback_service.dart';
import '../services/language_service.dart';
import '../services/local_storage_service.dart';
import '../services/navigation_tab_service.dart';
import '../services/notification_service.dart';
import '../services/package_info_service.dart';
import '../services/theme_service.dart';
import '../services/url_launcher_service.dart';
import '../views/oops/oops_view_model.dart';
import '../views/shell/shell_view_model.dart';
import '../views/startup/startup_view_model.dart';

part 'locator.dart';

abstract class AppSetup with Loglytics {
  static bool _isInitialised = false;

  static Future<void> initialise() async {
    if (_isInitialised) return;
    final log = Log(location: 'AppSetup');
    log.info('Initialising app..');
    WidgetsFlutterBinding.ensureInitialized();
    await setupStrings();
    await Firebase.initializeApp(
      options: Environment.current.firebaseOptions,
    );
    await trySetCurrentVersion(packageInfoService: PackageInfoService());
    Locator._registerRouters();
    Locator._registerAPIs();
    Locator._registerViewModels();
    Locator._registerFactories();
    Locator._registerLazySingletons();
    Locator._registerForms();
    await _setupLoglytics();
    if (kIsWeb) {
      setPathUrlStrategy();
    }
    Locator._registerSingletons();
    Animate.restartOnHotReload = true;
    Provider.debugCheckInvalidValueType = null;
    final _localStorageService = LocalStorageService.locate;
    await _localStorageService.initialise();
    log.info('App initialised!');
    _isInitialised = true;
  }

  @visibleForTesting
  static Future<void> trySetCurrentVersion({
    required PackageInfoService packageInfoService,
  }) async {
    try {
      Environment.currentVersion = await packageInfoService.version;
    } catch (error, stackTrace) {
      Log(location: 'App Setup').error(
        'Unexpected ${error.runtimeType} caught while trying to set current version!',
        error: error,
        stackTrace: stackTrace,
      );
      Environment.currentVersion = '0.0.4';
    }
  }

  static Future<void> _setupLoglytics() async {
    if (Loglytics.isActive) {
      await Loglytics.disposeMe();
    }
    Loglytics.setUp(
      logLevel: LogLevel.debug,
      logTime: false,
      addAnalyticsToCrashReports: true,
      maxLinesStackTrace: 100,
      analyticsInterface: null,
      crashReportsInterface: null,
      analytics: (analyticsFactory) {},
    );
  }

  static Future<void> setupStrings() async => await Strings.load(
        resolveLocale(PlatformDispatcher.instance.locales, const <Locale>[
          Locale.fromSubtags(languageCode: 'nl'),
        ]),
      );

  static Locale resolveLocale(List<Locale>? preferredLocales, Iterable<Locale> supportedLocales) {
    for (final locale in preferredLocales ?? const <Locale>[]) {
      // Check if the current device locale is supported
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return supportedLocale;
        }
      }
    }
    return supportedLocales.first;
  }

  static Future<void> reset({required BuildContext context, GetIt? getIt}) async {
    final log = Log(location: 'AppSetup');
    log.info('Resetting app..');
    getIt ??= GetIt.I;
    await Locator._resetUserDataServices(getIt);
    _isInitialised = false;
  }
}
