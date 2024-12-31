part of 'app_setup.dart';

class Locator {
  static Future<void> _resetUserDataServices([GetIt? getIt]) async {
    getIt ??= GetIt.I;
    await getIt.allReady();
  }

  static void _registerAPIs() {
    UsersApi.registerFactory();
    UserProfilesApi.registerFactory();
    UsernamesApi.registerFactory();
    ForgotPasswordForm.registerFactory();
    UserProfilesApi.registerFactory();
    UsernamesApi.registerFactory();
    UsersApi.registerFactory();
  }

  static void _registerRouters() {
    BaseRouter.registerLazySingleton();
    CoreRouter.registerFactory();
    HomeRouter.registerFactory();
    AuthStepRouter.registerFactory();
    BaseRouter.registerLazySingleton();
    CoreRouter.registerFactory();
  }

  static void _registerViewModels() {
    AuthViewModel.registerFactory();
    ShellViewModel.registerFactory();
    StartupViewModel.registerFactory();
    ForgotPasswordViewModel.registerFactory();
    OopsViewModel.registerFactory();

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
    UrlLauncherService.registerFactory();
    AuthStepService.registerFactory();
    SettingsService.registerLazySingleton();
    EmailService.registerFactory();
  }

  static void _registerLazySingletons() {
    AuthService.registerLazySingleton();
    ConnectionService.registerLazySingleton();
    FeedbackService.registerLazySingleton();
    LocalStorageService.registerLazySingleton();
    LanguageService.registerLazySingleton();
    NavigationTabService.registerLazySingleton();
    NotificationService.registerLazySingleton();
    ThemeService.registerLazySingleton();
    UserService.registerLazySingleton();
    PermissionsService.registerLazySingleton();
  }

  static void _registerSingletons() {}

  static void _registerForms() {
    LoginForm.registerFactory();
    RegisterForm.registerFactory();
    ForgotPasswordForm.registerFactory();
  }
}
