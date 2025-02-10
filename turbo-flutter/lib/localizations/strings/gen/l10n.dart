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

  /// `Forgot password`
  String get forgotPassword {
    return Intl.message(
      'Forgot password',
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

  /// `Fill in your email`
  String get fillInYourEmail {
    return Intl.message(
      'Fill in your email',
      name: 'fillInYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get pleaseEnterAValidEmailAddress {
    return Intl.message(
      'Please enter a valid email address',
      name: 'pleaseEnterAValidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Shopping List`
  String get shoppingList {
    return Intl.message(
      'Shopping List',
      name: 'shoppingList',
      desc: '',
      args: [],
    );
  }

  /// `Household`
  String get household {
    return Intl.message(
      'Household',
      name: 'household',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get areYouSureYouWantToLogout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'areYouSureYouWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `stranger`
  String get stranger {
    return Intl.message(
      'stranger',
      name: 'stranger',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get unavailable {
    return Intl.message(
      'Unavailable',
      name: 'unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Username is already taken.`
  String get usernameIsAlreadyTaken {
    return Intl.message(
      'Username is already taken.',
      name: 'usernameIsAlreadyTaken',
      desc: '',
      args: [],
    );
  }

  /// `Already in use`
  String get alreadyInUse {
    return Intl.message(
      'Already in use',
      name: 'alreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Username is already in use, please choose a different one.`
  String get usernameIsAlreadyInUsePleaseChooseADifferentOne {
    return Intl.message(
      'Username is already in use, please choose a different one.',
      name: 'usernameIsAlreadyInUsePleaseChooseADifferentOne',
      desc: '',
      args: [],
    );
  }

  /// `Deleting failed`
  String get deletingFailed {
    return Intl.message(
      'Deleting failed',
      name: 'deletingFailed',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while deleting old usernames, please try again.`
  String get somethingWentWrongWhileDeletingOldUsernamesPleaseTryAgain {
    return Intl.message(
      'Something went wrong while deleting old usernames, please try again.',
      name: 'somethingWentWrongWhileDeletingOldUsernamesPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Database Failure`
  String get databaseFailure {
    return Intl.message(
      'Database Failure',
      name: 'databaseFailure',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while trying to create your profile, please try again.`
  String get somethingWentWrongWhileTryingToCreateYourProfilePlease {
    return Intl.message(
      'Something went wrong while trying to create your profile, please try again.',
      name: 'somethingWentWrongWhileTryingToCreateYourProfilePlease',
      desc: '',
      args: [],
    );
  }

  /// `Hello @{username}`
  String helloUsername(Object username) {
    return Intl.message(
      'Hello @$username',
      name: 'helloUsername',
      desc: '',
      args: [username],
    );
  }

  /// `What name suits you best?`
  String get whatNameSuitsYouBest {
    return Intl.message(
      'What name suits you best?',
      name: 'whatNameSuitsYouBest',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy and terms of service accepted`
  String get privacyPolicyAndTermsOfServiceAccepted {
    return Intl.message(
      'Privacy policy and terms of service accepted',
      name: 'privacyPolicyAndTermsOfServiceAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Unable to accept, please try again later.`
  String get unableToAcceptPleaseTryAgainLater {
    return Intl.message(
      'Unable to accept, please try again later.',
      name: 'unableToAcceptPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Dutch`
  String get dutch {
    return Intl.message(
      'Dutch',
      name: 'dutch',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Edit Language`
  String get editLanguage {
    return Intl.message(
      'Edit Language',
      name: 'editLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Verify Email`
  String get verifyEmail {
    return Intl.message(
      'Verify Email',
      name: 'verifyEmail',
      desc: '',
      args: [],
    );
  }

  /// `''We noticed you have not verified your email address yet, please check your inbox and follow the instructions to verify your email address.''`
  String get weNoticedYouHaveNotVerifiedYourEmailAddressYet {
    return Intl.message(
      '\'\'We noticed you have not verified your email address yet, please check your inbox and follow the instructions to verify your email address.\'\'',
      name: 'weNoticedYouHaveNotVerifiedYourEmailAddressYet',
      desc: '',
      args: [],
    );
  }

  /// `''Send Email''`
  String get sendEmail {
    return Intl.message(
      '\'\'Send Email\'\'',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `''Skip''`
  String get skip {
    return Intl.message(
      '\'\'Skip\'\'',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Email verified`
  String get emailVerified {
    return Intl.message(
      'Email verified',
      name: 'emailVerified',
      desc: '',
      args: [],
    );
  }

  /// `Email not yet verified`
  String get emailNotYetVerified {
    return Intl.message(
      'Email not yet verified',
      name: 'emailNotYetVerified',
      desc: '',
      args: [],
    );
  }

  /// `We have resent the verification email. Please check your inbox and try again.`
  String get weHaveResentTheVerificationEmailPleaseCheckYourInbox {
    return Intl.message(
      'We have resent the verification email. Please check your inbox and try again.',
      name: 'weHaveResentTheVerificationEmailPleaseCheckYourInbox',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Inbox`
  String get inbox {
    return Intl.message(
      'Inbox',
      name: 'inbox',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get thisFieldIsRequired {
    return Intl.message(
      'This field is required',
      name: 'thisFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Failed to accept invite, please try again later and contact us if the problem persists.`
  String get failedToAcceptInvitePleaseTryAgainLaterAndContact {
    return Intl.message(
      'Failed to accept invite, please try again later and contact us if the problem persists.',
      name: 'failedToAcceptInvitePleaseTryAgainLaterAndContact',
      desc: '',
      args: [],
    );
  }

  /// `Failed to decline invite right now, please try again later and contact us if the problem persist.`
  String get failedToDeclineInviteRightNowPleaseTryAgainLater {
    return Intl.message(
      'Failed to decline invite right now, please try again later and contact us if the problem persist.',
      name: 'failedToDeclineInviteRightNowPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Invite`
  String get invite {
    return Intl.message(
      'Invite',
      name: 'invite',
      desc: '',
      args: [],
    );
  }

  /// `Portal legendary it people clearly sanskrit theorists worm hole origin sky visitors times origin soloman manipulation.`
  String get inviteHouseholdMessage {
    return Intl.message(
      'Portal legendary it people clearly sanskrit theorists worm hole origin sky visitors times origin soloman manipulation.',
      name: 'inviteHouseholdMessage',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get usernameFieldLabel {
    return Intl.message(
      'Username',
      name: 'usernameFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `@turbodoe`
  String get usernameFieldHint {
    return Intl.message(
      '@turbodoe',
      name: 'usernameFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Change Name`
  String get changeName {
    return Intl.message(
      'Change Name',
      name: 'changeName',
      desc: '',
      args: [],
    );
  }

  /// `Enter the new name for the household. This will be visible to all members.`
  String get enterTheNewNameForTheHouseholdThisWillBe {
    return Intl.message(
      'Enter the new name for the household. This will be visible to all members.',
      name: 'enterTheNewNameForTheHouseholdThisWillBe',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Members`
  String get members {
    return Intl.message(
      'Members',
      name: 'members',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get member {
    return Intl.message(
      'Member',
      name: 'member',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Household name must be at least 3 characters long`
  String get householdNameMustBeAtLeast3CharactersLong {
    return Intl.message(
      'Household name must be at least 3 characters long',
      name: 'householdNameMustBeAtLeast3CharactersLong',
      desc: '',
      args: [],
    );
  }

  /// `Household name must be at most 50 characters long`
  String get householdNameMustBeAtMost50CharactersLong {
    return Intl.message(
      'Household name must be at most 50 characters long',
      name: 'householdNameMustBeAtMost50CharactersLong',
      desc: '',
      args: [],
    );
  }

  /// `My Household`
  String get myHousehold {
    return Intl.message(
      'My Household',
      name: 'myHousehold',
      desc: '',
      args: [],
    );
  }

  /// `{username}'s Household`
  String usernamesHousehold(Object username) {
    return Intl.message(
      '$username\'s Household',
      name: 'usernamesHousehold',
      desc: '',
      args: [username],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Failed to remove member right now. Please try again later.`
  String get failedToRemoveMemberRightNowPleaseTryAgainLater {
    return Intl.message(
      'Failed to remove member right now. Please try again later.',
      name: 'failedToRemoveMemberRightNowPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Member removed!`
  String get memberRemoved {
    return Intl.message(
      'Member removed!',
      name: 'memberRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get leave {
    return Intl.message(
      'Leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `Leave Household`
  String get leaveHousehold {
    return Intl.message(
      'Leave Household',
      name: 'leaveHousehold',
      desc: '',
      args: [],
    );
  }

  /// `Remove member`
  String get removeMember {
    return Intl.message(
      'Remove member',
      name: 'removeMember',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to leave this household?`
  String get areYouSureYouWantToLeaveThisHousehold {
    return Intl.message(
      'Are you sure you want to leave this household?',
      name: 'areYouSureYouWantToLeaveThisHousehold',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this member?`
  String get areYouSureYouWantToRemoveThisMember {
    return Intl.message(
      'Are you sure you want to remove this member?',
      name: 'areYouSureYouWantToRemoveThisMember',
      desc: '',
      args: [],
    );
  }

  /// `You have left the household`
  String get youHaveLeftTheHousehold {
    return Intl.message(
      'You have left the household',
      name: 'youHaveLeftTheHousehold',
      desc: '',
      args: [],
    );
  }

  /// `You have automatically joined your old household if you had one.`
  String get youWillNoLongerHaveAccessToThisHouseholdYou {
    return Intl.message(
      'You have automatically joined your old household if you had one.',
      name: 'youWillNoLongerHaveAccessToThisHouseholdYou',
      desc: '',
      args: [],
    );
  }

  /// `Not sad, just empty.`
  String get emptyPlaceholderNotSadJustEmpty {
    return Intl.message(
      'Not sad, just empty.',
      name: 'emptyPlaceholderNotSadJustEmpty',
      desc: '',
      args: [],
    );
  }

  /// `A blank canvas awaits your masterpiece.`
  String get emptyPlaceholderBlankCanvas {
    return Intl.message(
      'A blank canvas awaits your masterpiece.',
      name: 'emptyPlaceholderBlankCanvas',
      desc: '',
      args: [],
    );
  }

  /// `Nothing here but possibilities.`
  String get emptyPlaceholderNothingHere {
    return Intl.message(
      'Nothing here but possibilities.',
      name: 'emptyPlaceholderNothingHere',
      desc: '',
      args: [],
    );
  }

  /// `Empty spaces are just rooms for growth.`
  String get emptyPlaceholderEmptySpaces {
    return Intl.message(
      'Empty spaces are just rooms for growth.',
      name: 'emptyPlaceholderEmptySpaces',
      desc: '',
      args: [],
    );
  }

  /// `The emptiness you see is the space for your next achievement.`
  String get emptyPlaceholderTheEmptiness {
    return Intl.message(
      'The emptiness you see is the space for your next achievement.',
      name: 'emptyPlaceholderTheEmptiness',
      desc: '',
      args: [],
    );
  }

  /// `An empty list is a clear sky; what will you build?`
  String get emptyPlaceholderAnEmptyList {
    return Intl.message(
      'An empty list is a clear sky; what will you build?',
      name: 'emptyPlaceholderAnEmptyList',
      desc: '',
      args: [],
    );
  }

  /// `This is not a void, it's a stage.`
  String get emptyPlaceholderNotAVoid {
    return Intl.message(
      'This is not a void, it\'s a stage.',
      name: 'emptyPlaceholderNotAVoid',
      desc: '',
      args: [],
    );
  }

  /// `No entries yet, but infinite potential.`
  String get emptyPlaceholderNoEntries {
    return Intl.message(
      'No entries yet, but infinite potential.',
      name: 'emptyPlaceholderNoEntries',
      desc: '',
      args: [],
    );
  }

  /// `Zero items, endless opportunity.`
  String get emptyPlaceholderZeroItems {
    return Intl.message(
      'Zero items, endless opportunity.',
      name: 'emptyPlaceholderZeroItems',
      desc: '',
      args: [],
    );
  }

  /// `The emptiness is not a lack, but a space to fill.`
  String get emptyPlaceholderTheEmptinessIsNotALack {
    return Intl.message(
      'The emptiness is not a lack, but a space to fill.',
      name: 'emptyPlaceholderTheEmptinessIsNotALack',
      desc: '',
      args: [],
    );
  }

  /// `No matches here. Reimagine your query.`
  String get noResultsPlaceholderNoMatches {
    return Intl.message(
      'No matches here. Reimagine your query.',
      name: 'noResultsPlaceholderNoMatches',
      desc: '',
      args: [],
    );
  }

  /// `Embrace this empty list as a moment of calm.`
  String get noResultsPlaceholderEmbraceThis {
    return Intl.message(
      'Embrace this empty list as a moment of calm.',
      name: 'noResultsPlaceholderEmbraceThis',
      desc: '',
      args: [],
    );
  }

  /// `The search is over, but the journey continues.`
  String get noResultsPlaceholderTheSearchIsOver {
    return Intl.message(
      'The search is over, but the journey continues.',
      name: 'noResultsPlaceholderTheSearchIsOver',
      desc: '',
      args: [],
    );
  }

  /// `Maybe what you're looking for is hidden in another perspective.`
  String get noResultsPlaceholderMaybeWhatYoureLooking {
    return Intl.message(
      'Maybe what you\'re looking for is hidden in another perspective.',
      name: 'noResultsPlaceholderMaybeWhatYoureLooking',
      desc: '',
      args: [],
    );
  }

  /// `Nothing found here.`
  String get noResultsPlaceholderNothingFound {
    return Intl.message(
      'Nothing found here.',
      name: 'noResultsPlaceholderNothingFound',
      desc: '',
      args: [],
    );
  }

  /// `In this moment, no results arise.`
  String get noResultsPlaceholderInThisMoment {
    return Intl.message(
      'In this moment, no results arise.',
      name: 'noResultsPlaceholderInThisMoment',
      desc: '',
      args: [],
    );
  }

  /// `Nothing matched your query.`
  String get noResultsPlaceholderNothingMatched {
    return Intl.message(
      'Nothing matched your query.',
      name: 'noResultsPlaceholderNothingMatched',
      desc: '',
      args: [],
    );
  }

  /// `Perhaps the answer lies elsewhere.`
  String get noResultsPlaceholderPerhapsTheAnswer {
    return Intl.message(
      'Perhaps the answer lies elsewhere.',
      name: 'noResultsPlaceholderPerhapsTheAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Consider a different approach or term.`
  String get noResultsPlaceholderConsiderADifferent {
    return Intl.message(
      'Consider a different approach or term.',
      name: 'noResultsPlaceholderConsiderADifferent',
      desc: '',
      args: [],
    );
  }

  /// `No results found.`
  String get noResultsPlaceholderNoResults {
    return Intl.message(
      'No results found.',
      name: 'noResultsPlaceholderNoResults',
      desc: '',
      args: [],
    );
  }

  /// `An empty list is a prompt for new perspectives.`
  String get noResultsPlaceholderAnEmptyList {
    return Intl.message(
      'An empty list is a prompt for new perspectives.',
      name: 'noResultsPlaceholderAnEmptyList',
      desc: '',
      args: [],
    );
  }

  /// `The outcome is clear: nothing found. How will you adapt?`
  String get noResultsPlaceholderTheOutcome {
    return Intl.message(
      'The outcome is clear: nothing found. How will you adapt?',
      name: 'noResultsPlaceholderTheOutcome',
      desc: '',
      args: [],
    );
  }

  /// `No answers here.`
  String get noResultsPlaceholderNoAnswers {
    return Intl.message(
      'No answers here.',
      name: 'noResultsPlaceholderNoAnswers',
      desc: '',
      args: [],
    );
  }

  /// `Seek in another direction with sharper focus.`
  String get noResultsPlaceholderSeekInAnother {
    return Intl.message(
      'Seek in another direction with sharper focus.',
      name: 'noResultsPlaceholderSeekInAnother',
      desc: '',
      args: [],
    );
  }

  /// `The search reveals absence.`
  String get noResultsPlaceholderTheSearchReveals {
    return Intl.message(
      'The search reveals absence.',
      name: 'noResultsPlaceholderTheSearchReveals',
      desc: '',
      args: [],
    );
  }

  /// `Perhaps it's time to ask a different question.`
  String get noResultsPlaceholderPerhapsItsTime {
    return Intl.message(
      'Perhaps it\'s time to ask a different question.',
      name: 'noResultsPlaceholderPerhapsItsTime',
      desc: '',
      args: [],
    );
  }

  /// `Perhaps it's time to take a different route.`
  String get noResultsPlaceholderPerhapsItsTimeToTake {
    return Intl.message(
      'Perhaps it\'s time to take a different route.',
      name: 'noResultsPlaceholderPerhapsItsTimeToTake',
      desc: '',
      args: [],
    );
  }

  /// `Maximum number of household members reached`
  String get maximumHouseholdMembersReached {
    return Intl.message(
      'Maximum number of household members reached',
      name: 'maximumHouseholdMembersReached',
      desc: '',
      args: [],
    );
  }

  /// `User is already invited`
  String get userIsAlreadyInvited {
    return Intl.message(
      'User is already invited',
      name: 'userIsAlreadyInvited',
      desc: '',
      args: [],
    );
  }

  /// `User is already a member`
  String get userIsAlreadyAMember {
    return Intl.message(
      'User is already a member',
      name: 'userIsAlreadyAMember',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get userNotFound {
    return Intl.message(
      'User not found',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Create Shopping List`
  String get createShoppingList {
    return Intl.message(
      'Create Shopping List',
      name: 'createShoppingList',
      desc: '',
      args: [],
    );
  }

  /// `Enter the name for the new shopping list. This will be visible to all members.`
  String get enterTheNameForTheNewShoppingList {
    return Intl.message(
      'Enter the name for the new shopping list. This will be visible to all members.',
      name: 'enterTheNameForTheNewShoppingList',
      desc: '',
      args: [],
    );
  }

  /// `Title must be at least 1 character long.`
  String get titleMustBeAtLeast1CharacterLong {
    return Intl.message(
      'Title must be at least 1 character long.',
      name: 'titleMustBeAtLeast1CharacterLong',
      desc: '',
      args: [],
    );
  }

  /// `Name can be at most {kLimitsMaxNameLength} characters long.`
  String nameCanBeAtMostKlimitsmaxnamelengthCharactersLong(
      Object kLimitsMaxNameLength) {
    return Intl.message(
      'Name can be at most $kLimitsMaxNameLength characters long.',
      name: 'nameCanBeAtMostKlimitsmaxnamelengthCharactersLong',
      desc: '',
      args: [kLimitsMaxNameLength],
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
