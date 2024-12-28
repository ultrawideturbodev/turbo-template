import 'package:firebase_core/firebase_core.dart';
import '../config/emulator_config.dart';
import 'environment.dart';

class AppSetup {
  static Future<void> initialise() async {
    await Firebase.initializeApp(
      options: Environment.current.firebaseOptions,
    );
    EmulatorConfig.configureEmulators();
    // ... rest of initialization
  }
}
