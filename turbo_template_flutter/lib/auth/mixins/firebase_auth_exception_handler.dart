import 'package:feedback_response/feedback_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loglytics/loglytics.dart';

import '../../core/constants/k_errors.dart';

/// A mixin that provides Firebase Auth exception handling functionality.
///
/// This mixin contains methods to handle various Firebase Auth exceptions and
/// convert them into user-friendly [FeedbackResponse] objects.
mixin FirebaseAuthExceptionHandler {
  /// Handles a [FirebaseAuthException] and returns an appropriate [FeedbackResponse].
  ///
  /// Takes a [firebaseAuthException] and [log] instance as required parameters.
  /// Returns a [FeedbackResponse] with a user-friendly error message based on the
  /// exception code.
  ///
  /// Throws nothing, always returns a [FeedbackResponse] even for unknown errors.
  FeedbackResponse<T> tryHandleFirebaseAuthException<T>({
    required FirebaseAuthException firebaseAuthException,
    required Log log,
  }) {
    log.debug('Starting to handle FirebaseAuthException');
    log.error('FirebaseAuthException code: ${firebaseAuthException.code}');
    log.error('FirebaseAuthException message: ${firebaseAuthException.message}');

    return switch (firebaseAuthException.code) {
      kInvalidLoginCredentials => FeedbackResponse.error(
          title: 'Invalid credentials',
          message: 'The credentials provided are invalid, please try again.',
        ),
      kErrorsAccountExistsWithDifferentCredentials => FeedbackResponse.error(
          title: 'Account already in use',
          message: 'The account is already in use, please try again.',
        ),
      kErrorsInvalidCredential => FeedbackResponse.error(
          title: 'Invalid credential',
          message: 'Something went wrong verifying the credential, please try again.',
        ),
      kErrorsOperationNotAllowed => FeedbackResponse.error(
          title: 'Operation not allowed',
          message:
              'The type of account corresponding to the credential is not enabled, please try again.',
        ),
      kErrorsUserDisabled => FeedbackResponse.error(
          title: 'Account disabled',
          message: 'The account corresponding to the credential is disabled, please try again.',
        ),
      kErrorsUserNotFound => FeedbackResponse.error(
          title: 'Account not found',
          message: 'The account corresponding to the credential was not found, please try again.',
        ),
      kErrorsWrongPassword => FeedbackResponse.error(
          title: 'Wrong password',
          message: 'The password is invalid, please try again.',
        ),
      kErrorsInvalidVerificationCode => FeedbackResponse.error(
          title: 'Invalid verification code',
          message: 'The verification code of the credential is invalid, please try again.',
        ),
      kErrorsInvalidVerificationId => FeedbackResponse.error(
          title: 'Invalid verification id',
          message: 'The verification id of the credential is invalid, please try again.',
        ),
      kErrorsInvalidEmail => FeedbackResponse.error(
          title: 'Invalid email',
          message: 'The email address provided is invalid, please try again.',
        ),
      kErrorsEmailAlreadyInUse => FeedbackResponse.error(
          title: 'Email already in use',
          message: 'The email used already exists, please use a different email or try to log in.',
        ),
      kErrorsWeakPassword => FeedbackResponse.error(
          title: 'Weak password',
          message: 'The password provided is too weak, please try again.',
        ),
      kErrorsInvalidPhoneNumber => FeedbackResponse.error(
          title: 'Invalid Phone Number',
          message: 'The phone number has an invalid format. Please input a valid phone number.',
        ),
      kErrorsCaptchaCheckFailed => FeedbackResponse.error(
          title: 'Captcha Check Failed',
          message:
              'The reCAPTCHA response token was invalid or expired, or the request contained an invalid API key. Please try again.',
        ),
      kErrorsQuotaExceeded => FeedbackResponse.error(
          title: 'Quota Exceeded',
          message:
              'The quota of SMS verification messages has been exceeded. This is done to prevent abuse. Please try again later.',
        ),
      kErrorsProviderAlreadyLinked => FeedbackResponse.error(
          title: 'Provider Already Linked',
          message:
              'The provider account is already linked to another user account. Please use a different account or unlink the existing one.',
        ),
      kErrorsCredentialAlreadyInUse => FeedbackResponse.error(
          title: 'Credential Already In Use',
          message:
              'The account corresponding to the credential already exists among your users, or is already linked to a Firebase User. Please use a different credential.',
        ),
      _ => FeedbackResponse.error(
          title: 'Unknown error',
          message: 'An unknown error has occurred, please try again.',
        ),
    };
  }
}
