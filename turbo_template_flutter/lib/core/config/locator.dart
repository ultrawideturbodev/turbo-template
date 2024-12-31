part of 'app_setup.dart';

class Locator {
  static Future<void> _resetUserDataServices([GetIt? getIt]) async {
    getIt ??= GetIt.I;
    await getIt.allReady();
  }

  static void _registerAPIs() {
    UserProfilesApi.registerFactory();
    UsernamesApi.registerFactory();
    UsersApi.registerFactory();
    SettingsApi.registerFactory();
  }

  static void _registerRouters() {
    AuthStepRouter.registerFactory();
    BaseRouter.registerLazySingleton();
    CoreRouter.registerFactory();
    HomeRouter.registerFactory();
  }

  static void _registerViewModels() {
    SettingsViewModel.registerFactory();
    AcceptPrivacyViewModel.registerFactory();
    AuthViewModel.registerFactory();
    CreateUsernameViewModel.registerFactory();
    ForgotPasswordViewModel.registerFactory();
    OopsViewModel.registerFactory();
    ShellViewModel.registerFactory();
    StartupViewModel.registerFactory();
    VerifyEmailViewModel.registerFactory();
  }

  static void _registerFactories() {
    AuthStepService.registerFactory();
    EmailService.registerFactory();
    SettingsService.registerLazySingleton();
    UrlLauncherService.registerFactory();
  }

  static void _registerLazySingletons() {
    VibrateService.registerLazySingleton();
    AuthService.registerLazySingleton();
    ConnectionService.registerLazySingleton();
    FeedbackService.registerLazySingleton();
    LanguageService.registerLazySingleton();
    LocalStorageService.registerLazySingleton();
    NavigationTabService.registerLazySingleton();
    NotificationService.registerLazySingleton();
    PermissionsService.registerLazySingleton();
    ThemeService.registerLazySingleton();
    UserService.registerLazySingleton();
  }

  static void _registerSingletons() {}

  static void _registerForms() {
    ForgotPasswordForm.registerFactory();
    LoginForm.registerFactory();
    RegisterForm.registerFactory();
    CreateUsernameForm.registerFactory();
  }
}
