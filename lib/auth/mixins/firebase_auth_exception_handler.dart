import 'package:firebase_auth/firebase_auth.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/state/constants/k_errors.dart';

/// A mixin that provides Firebase Auth exception handling functionality.
///
/// This mixin contains methods to handle various Firebase Auth exceptions and
/// convert them into user-friendly [TurboResponse] objects.
mixin FirebaseAuthExceptionHandler {
  /// Handles a [FirebaseAuthException] and returns an appropriate [TurboResponse].
  ///
  /// Takes a [firebaseAuthException] and [log] instance as required parameters.
  /// Returns a [TurboResponse] with a user-friendly error message based on the
  /// exception code.
  ///
  /// Throws nothing, always returns a [TurboResponse] even for unknown errors.
  TurboResponse<T> tryHandleFirebaseAuthException<T>({
    required FirebaseAuthException firebaseAuthException,
    required Log log,
  }) {
    log.debug('Starting to handle FirebaseAuthException');
    log.error('FirebaseAuthException code: ${firebaseAuthException.code}');
    log.error('FirebaseAuthException message: ${firebaseAuthException.message}');

    return switch (firebaseAuthException.code) {
      kInvalidLoginCredentials => const TurboResponse.failAsBool(
          title: 'Invalid credentials',
          message: 'The credentials provided are invalid, please try again.',
        ),
      kErrorsAccountExistsWithDifferentCredentials => const TurboResponse.failAsBool(
          title: 'Account already in use',
          message: 'The account is already in use, please try again.',
        ),
      kErrorsInvalidCredential => const TurboResponse.failAsBool(
          title: 'Invalid credential',
          message: 'Something went wrong verifying the credential, please try again.',
        ),
      kErrorsOperationNotAllowed => const TurboResponse.failAsBool(
          title: 'Operation not allowed',
          message:
              'The type of account corresponding to the credential is not enabled, please try again.',
        ),
      kErrorsUserDisabled => const TurboResponse.failAsBool(
          title: 'Account disabled',
          message: 'The account corresponding to the credential is disabled, please try again.',
        ),
      kErrorsUserNotFound => const TurboResponse.failAsBool(
          title: 'Account not found',
          message: 'The account corresponding to the credential was not found, please try again.',
        ),
      kErrorsWrongPassword => const TurboResponse.failAsBool(
          title: 'Wrong password',
          message: 'The password is invalid, please try again.',
        ),
      kErrorsInvalidVerificationCode => const TurboResponse.failAsBool(
          title: 'Invalid verification code',
          message: 'The verification code of the credential is invalid, please try again.',
        ),
      kErrorsInvalidVerificationId => const TurboResponse.failAsBool(
          title: 'Invalid verification id',
          message: 'The verification id of the credential is invalid, please try again.',
        ),
      kErrorsInvalidEmail => const TurboResponse.failAsBool(
          title: 'Invalid email',
          message: 'The email address provided is invalid, please try again.',
        ),
      kErrorsEmailAlreadyInUse => const TurboResponse.failAsBool(
          title: 'Email already in use',
          message: 'The email used already exists, please use a different email or try to log in.',
        ),
      kErrorsWeakPassword => const TurboResponse.failAsBool(
          title: 'Weak password',
          message: 'The password provided is too weak, please try again.',
        ),
      kErrorsInvalidPhoneNumber => const TurboResponse.failAsBool(
          title: 'Invalid Phone Number',
          message: 'The phone number has an invalid format. Please input a valid phone number.',
        ),
      kErrorsCaptchaCheckFailed => const TurboResponse.failAsBool(
          title: 'Captcha Check Failed',
          message:
              'The reCAPTCHA response token was invalid or expired, or the request contained an invalid API key. Please try again.',
        ),
      kErrorsQuotaExceeded => const TurboResponse.failAsBool(
          title: 'Quota Exceeded',
          message:
              'The quota of SMS verification messages has been exceeded. This is done to prevent abuse. Please try again later.',
        ),
      kErrorsProviderAlreadyLinked => const TurboResponse.failAsBool(
          title: 'Provider Already Linked',
          message:
              'The provider account is already linked to another user account. Please use a different account or unlink the existing one.',
        ),
      kErrorsCredentialAlreadyInUse => const TurboResponse.failAsBool(
          title: 'Credential Already In Use',
          message:
              'The account corresponding to the credential already exists among your users, or is already linked to a Firebase User. Please use a different credential.',
        ),
      _ => const TurboResponse.failAsBool(
          title: 'Unknown error',
          message: 'An unknown error has occurred, please try again.',
        ),
    };
  }
}
