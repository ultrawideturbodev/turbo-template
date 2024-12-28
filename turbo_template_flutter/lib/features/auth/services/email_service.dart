import 'package:feedback_response/feedback_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';

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

  Future<FeedbackResponse<User>> login({
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
        return FeedbackResponse.success(
          title: 'Account created',
          feedbackType: FeedbackType.notification,
          result: user,
        );
      } else {
        log.error('Logging in user with email and password failed!');
        return FeedbackResponse.error(
          title: 'Login failed',
          message: 'An unknown error has occurred, please try again.',
          feedbackType: FeedbackType.dialog,
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
      return FeedbackResponse.error(
        title: 'Login failed',
        message: 'An unknown error has occurred, please try again.',
        feedbackType: FeedbackType.dialog,
      );
    }
  }

  Future<FeedbackResponse<User>> register({
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
        return FeedbackResponse.success(
          title: 'Account created',
          feedbackType: FeedbackType.notification,
          result: user,
        );
      } else {
        log.error('Registering user with email and password failed!');
        return FeedbackResponse.error(
          title: 'Register failed',
          message: 'An unknown error has occurred, please try again.',
          feedbackType: FeedbackType.dialog,
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
      return FeedbackResponse.error(
        title: 'Register failed',
        message: 'An unknown error has occurred, please try again.',
        feedbackType: FeedbackType.dialog,
      );
    }
  }

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
}
