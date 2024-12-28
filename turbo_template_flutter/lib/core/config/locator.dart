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
  }

  static void _registerRouters() {
    BaseRouter.registerLazySingleton();
    CoreRouter.registerFactory();
    HomeRouter.registerFactory();
  }

  static void _registerViewModels() {
    AuthViewModel.registerFactory();
    ShellViewModel.registerFactory();
    StartupViewModel.registerFactory();
    ForgotPasswordViewModel.registerFactory();
    OopsViewModel.registerFactory();
  }

  static void _registerFactories() {
    UrlLauncherService.registerFactory();
    AuthStepService.registerFactory();
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
