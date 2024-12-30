import 'package:firebase_core/firebase_core.dart';
import 'package:turbo_template/core/enums/environment.dart';
import '../config/emulator_config.dart';

class AppSetup {
  static Future<void> initialise() async {
    await Firebase.initializeApp(
      options: Environment.current.firebaseOptions,
    );
    EmulatorConfig.configureEmulators();
  }
}
