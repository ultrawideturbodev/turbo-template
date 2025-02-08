const kErrorsAccountExistsWithDifferentCredentials = 'account-exists-with-different-credential';
const kErrorsCaptchaCheckFailed = 'captcha-check-failed';
const kErrorsCredentialAlreadyInUse = 'credential-already-in-use';
const kErrorsEmailAlreadyInUse = 'email-already-in-use';
const kErrorsInvalidCredential = 'invalid-credential';
const kErrorsInvalidEmail = 'invalid-email';
const kErrorsInvalidPhoneNumber = 'invalid-phone-number';
const kErrorsInvalidVerificationCode = 'invalid-verification-code';
const kErrorsInvalidVerificationId = 'invalid-verification-id';
const kErrorsOperationNotAllowed = 'operation-not-allowed';
const kErrorsProviderAlreadyLinked = 'provider-already-linked';
const kErrorsQuotaExceeded = 'quota-exceeded';
const kErrorsUserDisabled = 'user-disabled';
const kErrorsUserNotFound = 'user-not-found';
const kErrorsWeakPassword = 'weak-password';
const kErrorsWrongPassword = 'wrong-password';
const kInvalidLoginCredentials = 'INVALID_LOGIN_CREDENTIALS';
const kErrors = ConstErrors._();

class ConstErrors {
  const ConstErrors._();

  static const _unknown = 'An unknown error occurred';
  String get unknown => _unknown;

  static const _network = 'Network error occurred';
  String get network => _network;

  static const _invalidEmail = 'Invalid email address';
  String get invalidEmail => _invalidEmail;

  static const _invalidPassword = 'Invalid password';
  String get invalidPassword => _invalidPassword;

  static const _unauthorized = 'Unauthorized access';
  String get unauthorized => _unauthorized;

  static const _notFound = 'Resource not found';
  String get notFound => _notFound;

  static const _accountExistsWithDifferentCredentials = 'account-exists-with-different-credential';
  String get accountExistsWithDifferentCredentials => _accountExistsWithDifferentCredentials;

  static const _captchaCheckFailed = 'captcha-check-failed';
  String get captchaCheckFailed => _captchaCheckFailed;

  static const _credentialAlreadyInUse = 'credential-already-in-use';
  String get credentialAlreadyInUse => _credentialAlreadyInUse;

  static const _emailAlreadyInUse = 'email-already-in-use';
  String get emailAlreadyInUse => _emailAlreadyInUse;

  static const _invalidCredential = 'invalid-credential';
  String get invalidCredential => _invalidCredential;

  static const _invalidPhoneNumber = 'invalid-phone-number';
  String get invalidPhoneNumber => _invalidPhoneNumber;

  static const _invalidVerificationCode = 'invalid-verification-code';
  String get invalidVerificationCode => _invalidVerificationCode;

  static const _invalidVerificationId = 'invalid-verification-id';
  String get invalidVerificationId => _invalidVerificationId;

  static const _operationNotAllowed = 'operation-not-allowed';
  String get operationNotAllowed => _operationNotAllowed;

  static const _providerAlreadyLinked = 'provider-already-linked';
  String get providerAlreadyLinked => _providerAlreadyLinked;

  static const _quotaExceeded = 'quota-exceeded';
  String get quotaExceeded => _quotaExceeded;

  static const _userDisabled = 'user-disabled';
  String get userDisabled => _userDisabled;

  static const _userNotFound = 'user-not-found';
  String get userNotFound => _userNotFound;

  static const _weakPassword = 'weak-password';
  String get weakPassword => _weakPassword;

  static const _wrongPassword = 'wrong-password';
  String get wrongPassword => _wrongPassword;

  static const _invalidLoginCredentials = 'INVALID_LOGIN_CREDENTIALS';
  String get invalidLoginCredentials => _invalidLoginCredentials;
}
