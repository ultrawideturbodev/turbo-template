import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

abstract class Environment {
  static String? currentVersion;

  static const String _emulators = 'emulators';
  static const String _dev = 'dev';
  static const String _prod = 'prod';

  static const argumentKey = 'env';

  static EnvironmentType get current {
    switch (const String.fromEnvironment(
      Environment.argumentKey,
      defaultValue: _prod,
    )) {
      case _emulators:
        return EnvironmentType.emulators;
      case _dev:
        return EnvironmentType.dev;
      case _prod:
      default:
        return EnvironmentType.prod;
    }
  }

  static bool get isEmulators => current == EnvironmentType.emulators;
}

enum EnvironmentType {
  emulators,
  dev,
  prod;

  FirebaseOptions get firebaseOptions {
    switch (this) {
      case EnvironmentType.emulators:
      case EnvironmentType.dev:
      case EnvironmentType.prod:
        return DefaultFirebaseOptions.currentPlatform;
    }
  }
}
