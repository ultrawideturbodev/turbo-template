import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:turbo_template/environment/enums/environment.dart';

class EmulatorConfig {
  static const _localhost = 'localhost';
  static const _host = '127.0.0.1';

  static void configureEmulators() {
    if (kDebugMode && Environment.isEmulators) {
      const host = kIsWeb ? _localhost : _host;
      FirebaseAuth.instance.useAuthEmulator(host, 9099);
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
      FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
      FirebaseStorage.instance.useStorageEmulator(host, 9199);
    }
  }
}
