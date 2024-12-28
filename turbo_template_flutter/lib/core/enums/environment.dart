import 'package:firebase_core/firebase_core.dart';

abstract class Environment {
  static String? currentVersion;

  static const String _dev = 'dev';
  static const String _prod = 'prod';

  static const argumentKey = 'env';

  static EnvironmentType? _environmentOverride;
  static void environmentOverride({required EnvironmentType environmentType}) =>
      _environmentOverride = environmentType;

  static EnvironmentType get current {
    if (_environmentOverride == null) {
      switch (const String.fromEnvironment(
        Environment.argumentKey,
        defaultValue: _prod,
      )) {
        case _dev:
          return EnvironmentType.dev;
        case _prod:
        default:
          return EnvironmentType.prod;
      }
    }
    return _environmentOverride!;
  }

  static bool get isDev => current == EnvironmentType.dev;
  static bool get isProd => current == EnvironmentType.prod;
}

enum EnvironmentType {
  testDev,
  dev,
  prod,
  ;

  String get trailingCloudFunctionId {
    switch (this) {
      case EnvironmentType.dev:
      case EnvironmentType.testDev:
        return '';
      case EnvironmentType.prod:
        return '';
    }
  }

  FirebaseOptions get firebaseOptions {
    switch (this) {
      case EnvironmentType.dev:
      case EnvironmentType.testDev:
      case EnvironmentType.prod:
        return const FirebaseOptions(
          apiKey: 'AIzaSyDhMDKVCB40EPENxi2xy7Bnd7ZGFoQkX4I',
          appId: '1:255511613386:ios:c514e21a2b06dcef9d0933',
          messagingSenderId: '255511613386',
          projectId: 'turbo-firebase-template',
          storageBucket: 'turbo-firebase-template.firebasestorage.app',
          iosBundleId: 'com.ultrawideturbolife.turboTemplate',
        );
    }
  }
}
