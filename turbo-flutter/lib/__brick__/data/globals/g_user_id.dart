import 'package:firebase_auth/firebase_auth.dart';

import '../constants/k_values.dart';
import '../../state/exceptions/unexpected_null_exception.dart';

/// Returns the device identifier.
String get gDeviceId => kValuesDeviceId;

/// Returns the current user's unique identifier.
///
/// Returns [kValuesNoAuthId] if no user is currently signed in.
String get gUserId => gAuthUser?.uid ?? kValuesNoAuthId;

String gUserIdNotNull({required String when}) {
  final userId = gAuthUser?.uid;
  if (userId == null) {
    throw UnexpectedNullException(
      reason: 'userId should not be null when $when.',
    );
  }
  return userId;
}

/// Returns the current authenticated user.
///
/// Returns `null` if no user is currently signed in.
User? get gAuthUser => FirebaseAuth.instance.currentUser;

/// Returns whether a user is currently signed in.
bool get gHasAuth => gAuthUser != null;
