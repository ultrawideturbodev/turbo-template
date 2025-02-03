import '../enums/environment.dart';
import '../enums/supported_platform.dart';

SupportedPlatform get gPlatform => SupportedPlatform.current;
EnvironmentType get gEnvironment => Environment.current;
bool get gIsDev => Environment.isDev;
bool get gIsProd => Environment.isProd;
