import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loglytics/loglytics.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/auth/forms/create_username_form.dart';
import 'package:turbo_template/auth/routing/auth_step_router.dart';
import 'package:turbo_template/auth/views/accept_privacy/accept_privacy_view_model.dart';
import 'package:turbo_template/auth/views/create_username/create_username_view_model.dart';
import 'package:turbo_template/auth/views/verify_email/verify_email_view_model.dart';
import 'package:turbo_template/feedback/services/dialog_service.dart';
import 'package:turbo_template/feedback/services/sheet_service.dart';
import 'package:turbo_template/feedback/services/vibrate_service.dart';
import 'package:turbo_template/forms/forms/t_search_form.dart';
import 'package:turbo_template/home/routers/home_router.dart';
import 'package:turbo_template/home/views/home/home_view_model.dart';
import 'package:turbo_template/localizations/strings/gen/l10n.dart';
import 'package:turbo_template/settings/apis/settings_api.dart';
import 'package:turbo_template/settings/forms/t_example_form.dart';
import 'package:turbo_template/settings/routing/settings_router.dart';
import 'package:turbo_template/settings/services/settings_service.dart';
import 'package:turbo_template/settings/views/settings_view_model.dart';
import 'package:turbo_template/state/views/placeholder/placeholder_router.dart';
import 'package:turbo_template/state/views/placeholder/placeholder_view_model.dart';
import 'package:url_strategy/url_strategy.dart';

import '../../auth/apis/user_profiles_api.dart';
import '../../auth/apis/usernames_api.dart';
import '../../auth/apis/users_api.dart';
import '../../auth/forms/forgot_password.dart';
import '../../auth/forms/login_form.dart';
import '../../auth/forms/register_form.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/services/auth_step_service.dart';
import '../../auth/services/email_service.dart';
import '../../auth/services/permissions_service.dart';
import '../../auth/services/user_service.dart';
import '../../auth/views/auth/auth_view_model.dart';
import '../../auth/views/forgot_password/forgot_password_view_model.dart';
import '../../environment/enums/environment.dart';
import '../../environment/services/package_info_service.dart';
import '../../feedback/services/toast_service.dart';
import '../../http/services/connection_service.dart';
import '../../http/services/url_launcher_service.dart';
import '../../local_storage/services/local_storage_service.dart';
import '../../localizations/services/language_service.dart';
import '../../routing/routers/core_router.dart';
import '../../routing/services/base_router_service.dart';
import '../../routing/services/navigation_tab_service.dart';
import '../../routing/shell/shell_view_model.dart';
import '../../ui/services/theme_service.dart';
import '../views/oops/oops_view_model.dart';

part 'locator.dart';

abstract class AppSetup with Loglytics {
  static bool _isInitialised = false;

  static Future<void> initialise() async {
    if (_isInitialised) return;
    final log = Log(location: 'AppSetup');
    log.info('Initialising app..');
    WidgetsFlutterBinding.ensureInitialized();
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
    await setupStrings();
    await _setupLoglytics();
    if (kIsWeb) {
      setPathUrlStrategy();
    }
    Locator._registerSingletons();
    Animate.restartOnHotReload = true;
    Provider.debugCheckInvalidValueType = null;
    final _localStorageService = LocalStorageService.locate;
    await _localStorageService.isReady;
    await LanguageService.locate.initialise();
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
}
