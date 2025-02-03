import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

abstract class Environment {
  static String? currentVersion;

  static const String _emulators = 'emulators';
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
        case _emulators:
          return EnvironmentType.emulators;
        case _prod:
        default:
          return EnvironmentType.prod;
      }
    }
    return _environmentOverride!;
  }

  static bool get isEmulators => current == EnvironmentType.emulators;
  static bool get isProd => current == EnvironmentType.prod;
}

enum EnvironmentType {
  emulators,
  prod;

  String get trailingCloudFunctionId {
    switch (this) {
      case EnvironmentType.emulators:
        return '';
      case EnvironmentType.prod:
        return '';
    }
  }

  FirebaseOptions get firebaseOptions {
    switch (this) {
      case EnvironmentType.emulators:
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
