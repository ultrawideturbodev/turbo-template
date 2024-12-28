// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Strings {
  Strings();

  static Strings? _current;

  static Strings get current {
    assert(_current != null,
        'No instance of Strings was loaded. Try to initialize the Strings delegate before accessing Strings.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Strings> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Strings();
      Strings._current = instance;

      return instance;
    });
  }

  static Strings of(BuildContext context) {
    final instance = Strings.maybeOf(context);
    assert(instance != null,
        'No instance of Strings present in the widget tree. Did you add Strings.delegate in localizationsDelegates?');
    return instance!;
  }

  static Strings? maybeOf(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while trying to logout. Please try again later.`
  String get anErrorOccurredWhileTryingToLogoutPleaseTryAgain {
    return Intl.message(
      'An error occurred while trying to logout. Please try again later.',
      name: 'anErrorOccurredWhileTryingToLogoutPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred. Please try again later.`
  String get anUnknownErrorOccurredPleaseTryAgainLater {
    return Intl.message(
      'An unknown error occurred. Please try again later.',
      name: 'anUnknownErrorOccurredPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `apr`
  String get apr {
    return Intl.message(
      'apr',
      name: 'apr',
      desc: '',
      args: [],
    );
  }

  /// `april`
  String get april {
    return Intl.message(
      'april',
      name: 'april',
      desc: '',
      args: [],
    );
  }

  /// `aug`
  String get aug {
    return Intl.message(
      'aug',
      name: 'aug',
      desc: '',
      args: [],
    );
  }

  /// `august`
  String get august {
    return Intl.message(
      'august',
      name: 'august',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Click here to log in`
  String get clickHereToLogin {
    return Intl.message(
      'Click here to log in',
      name: 'clickHereToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get confirmYourPassword {
    return Intl.message(
      'Confirm your password',
      name: 'confirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `dec`
  String get dec {
    return Intl.message(
      'dec',
      name: 'dec',
      desc: '',
      args: [],
    );
  }

  /// `december`
  String get december {
    return Intl.message(
      'december',
      name: 'december',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get enterAValidEmail {
    return Intl.message(
      'Enter a valid email',
      name: 'enterAValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterYourEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterYourPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `feb`
  String get feb {
    return Intl.message(
      'feb',
      name: 'feb',
      desc: '',
      args: [],
    );
  }

  /// `february`
  String get february {
    return Intl.message(
      'february',
      name: 'february',
      desc: '',
      args: [],
    );
  }

  /// `Fill in your email address and we will send you a link to reset your password.`
  String get fillInYourEmailAddressAndWeWillSendYou {
    return Intl.message(
      'Fill in your email address and we will send you a link to reset your password.',
      name: 'fillInYourEmailAddressAndWeWillSendYou',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `fri`
  String get fri {
    return Intl.message(
      'fri',
      name: 'fri',
      desc: '',
      args: [],
    );
  }

  /// `friday`
  String get friday {
    return Intl.message(
      'friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `If {email} is registered with us, a password reset email has been sent.`
  String ifRegisteredWeSend(Object email) {
    return Intl.message(
      'If $email is registered with us, a password reset email has been sent.',
      name: 'ifRegisteredWeSend',
      desc: '',
      args: [email],
    );
  }

  /// `jan`
  String get jan {
    return Intl.message(
      'jan',
      name: 'jan',
      desc: '',
      args: [],
    );
  }

  /// `january`
  String get january {
    return Intl.message(
      'january',
      name: 'january',
      desc: '',
      args: [],
    );
  }

  /// `jul`
  String get jul {
    return Intl.message(
      'jul',
      name: 'jul',
      desc: '',
      args: [],
    );
  }

  /// `july`
  String get july {
    return Intl.message(
      'july',
      name: 'july',
      desc: '',
      args: [],
    );
  }

  /// `jun`
  String get jun {
    return Intl.message(
      'jun',
      name: 'jun',
      desc: '',
      args: [],
    );
  }

  /// `june`
  String get june {
    return Intl.message(
      'june',
      name: 'june',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Logout failed`
  String get logoutFailed {
    return Intl.message(
      'Logout failed',
      name: 'logoutFailed',
      desc: '',
      args: [],
    );
  }

  /// `mar`
  String get mar {
    return Intl.message(
      'mar',
      name: 'mar',
      desc: '',
      args: [],
    );
  }

  /// `march`
  String get march {
    return Intl.message(
      'march',
      name: 'march',
      desc: '',
      args: [],
    );
  }

  /// `may`
  String get may {
    return Intl.message(
      'may',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `mon`
  String get mon {
    return Intl.message(
      'mon',
      name: 'mon',
      desc: '',
      args: [],
    );
  }

  /// `monday`
  String get monday {
    return Intl.message(
      'monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `nov`
  String get nov {
    return Intl.message(
      'nov',
      name: 'nov',
      desc: '',
      args: [],
    );
  }

  /// `november`
  String get november {
    return Intl.message(
      'november',
      name: 'november',
      desc: '',
      args: [],
    );
  }

  /// `oct`
  String get oct {
    return Intl.message(
      'oct',
      name: 'oct',
      desc: '',
      args: [],
    );
  }

  /// `october`
  String get october {
    return Intl.message(
      'october',
      name: 'october',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get passwordDoesNotMatch {
    return Intl.message(
      'Password does not match',
      name: 'passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email to verify your account.`
  String get pleaseCheckYourEmailToVerifyYourAccount {
    return Intl.message(
      'Please check your email to verify your account.',
      name: 'pleaseCheckYourEmailToVerifyYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please read and accept our privacy policy`
  String get pleaseReadAndAcceptOurPrivacyPolicy {
    return Intl.message(
      'Please read and accept our privacy policy',
      name: 'pleaseReadAndAcceptOurPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `sat`
  String get sat {
    return Intl.message(
      'sat',
      name: 'sat',
      desc: '',
      args: [],
    );
  }

  /// `saturday`
  String get saturday {
    return Intl.message(
      'saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `sep`
  String get sep {
    return Intl.message(
      'sep',
      name: 'sep',
      desc: '',
      args: [],
    );
  }

  /// `september`
  String get september {
    return Intl.message(
      'september',
      name: 'september',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again later.`
  String get somethingWentWrongPleaseTryAgainLater {
    return Intl.message(
      'Something went wrong, please try again later.',
      name: 'somethingWentWrongPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `sun`
  String get sun {
    return Intl.message(
      'sun',
      name: 'sun',
      desc: '',
      args: [],
    );
  }

  /// `sunday`
  String get sunday {
    return Intl.message(
      'sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `thu`
  String get thu {
    return Intl.message(
      'thu',
      name: 'thu',
      desc: '',
      args: [],
    );
  }

  /// `thursday`
  String get thursday {
    return Intl.message(
      'thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `tue`
  String get tue {
    return Intl.message(
      'tue',
      name: 'tue',
      desc: '',
      args: [],
    );
  }

  /// `tuesday`
  String get tuesday {
    return Intl.message(
      'tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Error`
  String get unknownError {
    return Intl.message(
      'Unknown Error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Verification email sent`
  String get verificationEmailSent {
    return Intl.message(
      'Verification email sent',
      name: 'verificationEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `wed`
  String get wed {
    return Intl.message(
      'wed',
      name: 'wed',
      desc: '',
      args: [],
    );
  }

  /// `wednesday`
  String get wednesday {
    return Intl.message(
      'wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Your password must be at least 8 characters long.`
  String get yourPasswordMustBeAtLeast8CharactersLong {
    return Intl.message(
      'Your password must be at least 8 characters long.',
      name: 'yourPasswordMustBeAtLeast8CharactersLong',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `your@email.com`
  String get emailHint {
    return Intl.message(
      'your@email.com',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Vul je e-mailadres in`
  String get fillInYourEmail {
    return Intl.message(
      'Vul je e-mailadres in',
      name: 'fillInYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid e-mail address`
  String get pleaseEnterAValidEmailAddress {
    return Intl.message(
      'Please enter a valid e-mail address',
      name: 'pleaseEnterAValidEmailAddress',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Strings> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'nl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
