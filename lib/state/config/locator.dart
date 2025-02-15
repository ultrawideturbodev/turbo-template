part of 'app_setup.dart';

class Locator {
  static void _registerAPIs() {
    UserProfilesApi.registerFactory();
    UsernamesApi.registerFactory();
    UsersApi.registerFactory();
    SettingsApi.registerFactory();
  }

  static void _registerRouters() {
    AuthStepRouter.registerFactory();
    BaseRouterService.registerLazySingleton();
    SheetService.registerFactory();
    CoreRouter.registerFactory();
    HomeRouter.registerFactory();
    PlaceholderRouter.registerFactory();
    SettingsRouter.registerFactory();
  }

  static void _registerViewModels() {
    AcceptPrivacyViewModel.registerFactory();
    AuthViewModel.registerFactory();
    CreateUsernameViewModel.registerFactory();
    ForgotPasswordViewModel.registerFactory();
    HomeViewModel.registerFactory();
    OopsViewModel.registerFactory();
    PlaceholderViewModel.registerFactory();
    SettingsViewModel.registerFactory();
    ShellViewModel.registerFactory();
    VerifyEmailViewModel.registerFactory();
  }

  static void _registerFactories() {
    AuthStepService.registerFactory();
    EmailService.registerFactory();
    SettingsService.registerLazySingleton();
    UrlLauncherService.registerFactory();
  }

  static void _registerLazySingletons() {
    DialogService.registerLazySingleton();
    VibrateService.registerLazySingleton();
    AuthService.registerLazySingleton();
    ConnectionService.registerLazySingleton();
    LanguageService.registerLazySingleton();
    LocalStorageService.registerLazySingleton();
    NavigationTabService.registerLazySingleton();
    ToastService.registerLazySingleton();
    PermissionsService.registerLazySingleton();
    ThemeService.registerLazySingleton();
    UserService.registerLazySingleton();
  }

  static void _registerSingletons() {}

  static void _registerForms() {
    TSearchForm.registerFactory();
    TExampleForm.registerFactoryParam();
    ForgotPasswordForm.registerFactory();
    LoginForm.registerFactory();
    RegisterForm.registerFactory();
    CreateUsernameForm.registerFactory();
  }
}
