import 'package:flutter/foundation.dart';

enum SupportedPlatform {
  mobile,
  web,
  ;

  static SupportedPlatform get current {
    if (kIsWeb) {
      return SupportedPlatform.web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return SupportedPlatform.mobile;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'SupportedPlatform has not been configured for $defaultTargetPlatform - '
          'you can reconfigure this by running the Flutter CLI again.',
        );
    }
  }
}
