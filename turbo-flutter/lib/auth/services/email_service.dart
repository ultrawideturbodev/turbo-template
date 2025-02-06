import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_response/turbo_response.dart';

import '../mixins/firebase_auth_exception_handler.dart';

class EmailService with Loglytics, FirebaseAuthExceptionHandler {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static EmailService get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(EmailService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _firebaseAuth = FirebaseAuth.instance;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<TurboResponse<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      log.info('Logging in user with email: $email and password.');
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user != null) {
        log.info('Logging in user with email and password was successful!');
        return TurboResponse.success(
          title: 'Account created',
          result: user,
        );
      } else {
        log.error('Logging in user with email and password failed!');
        return const TurboResponse.failAsBool(
          title: 'Login failed',
          message: 'An unknown error has occurred, please try again.',
        );
      }
    } on FirebaseAuthException catch (error) {
      final code = error.code;
      log.warning('Unable to register user! Reason: $code.');
      return tryHandleFirebaseAuthException(
        firebaseAuthException: error,
        log: log,
      );
    } catch (error, stackTrace) {
      log.error(
        'Unknown exception caught while trying to login.',
        error: error,
        stackTrace: stackTrace,
      );
      return const TurboResponse.failAsBool(
        title: 'Login failed',
        message: 'An unknown error has occurred, please try again.',
      );
    }
  }

  Future<TurboResponse<User>> register({
    required String email,
    required String password,
  }) async {
    try {
      log.info('Registering user with email: $email and password..');
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user != null) {
        log.info('Registering user with email and password was successful!');
        return TurboResponse.success(
          title: 'Account created',
          result: user,
        );
      } else {
        log.error('Registering user with email and password failed!');
        return const TurboResponse.failAsBool(
          title: 'Register failed',
          message: 'An unknown error has occurred, please try again.',
        );
      }
    } on FirebaseAuthException catch (error) {
      final code = error.code;
      log.warning('Unable to register user! Reason: $code.');
      return tryHandleFirebaseAuthException(
        firebaseAuthException: error,
        log: log,
      );
    } catch (error, stackTrace) {
      log.error(
        'Unknown exception caught while trying to register.',
        error: error,
        stackTrace: stackTrace,
      );
      return const TurboResponse.failAsBool(
        title: 'Register failed',
        message: 'An unknown error has occurred, please try again.',
      );
    }
  }

// 🏗️ HELPERS ------------------------------------------------------------------------------- \\
}
