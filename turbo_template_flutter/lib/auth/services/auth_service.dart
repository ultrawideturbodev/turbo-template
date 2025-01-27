import 'dart:async';

import 'package:feedback_response/feedback_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turbo_template/core/abstracts/sync_service.dart';
import 'package:turbo_template/core/annotations/called_by_mutex.dart';
import 'package:turbo_template/core/exceptions/unexpected_null_exception.dart';
import 'package:turbo_template/core/exceptions/unexpected_state_exception.dart';
import 'package:turbo_template/core/extensions/completer_extension.dart';
import 'package:turbo_template/core/extensions/map_extension.dart';
import 'package:turbo_template/core/extensions/string_extension.dart';
import 'package:turbo_template/core/utils/debouncer.dart';
import 'package:turbo_template/core/utils/mutex.dart';
import 'package:turbo_template/auth/enums/user_level.dart';
import 'package:turbo_template/auth/mixins/firebase_auth_exception_handler.dart';
import 'package:turbo_template/local_storage/services/local_storage_service.dart';

class AuthService extends SyncService<User?> with Loglytics, FirebaseAuthExceptionHandler {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static AuthService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(AuthService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _firebaseAuth = FirebaseAuth.instance;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\

  @override
  Stream<User?> Function() get stream => _firebaseAuth.userChanges;

  @override
  void Function(User? value) get onData => (user) => _mutex.lockAndRun(
        run: (unlock) async {
          try {
            log.debug('New user data received, user: ${user?.uid}');
            _lastUser = _currentUser.valueOrNull;
            _currentUser.add(user);
            if (user != null) {
              _hasAuth.update(true);
              _tryManageUserLevel(user);
              _hasLoggedOut = false;
              return;
            } else {
              _hasAuth.update(false);
              _claimsUserLevel.update(UserLevel.unknown);
              if (_hasLoggedOut) {
                _hasLoggedOut = false;
                return;
              }
              if (_lastUser != null) {
                throw UnexpectedStateException(
                  reason: 'User was unexpectedly logged out. _hasLoggedOut: $_hasLoggedOut',
                );
              }
            }
          } catch (error, stackTrace) {
            log.error(
              'Exception caught while processing received data in the auth service.',
              error: error,
              stackTrace: stackTrace,
            );
          } finally {
            _isReady.completeIfNotComplete(true);
            unlock();
          }
        },
      );

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  User? _lastUser;
  bool _hasLoggedOut = false;
  final _claimsUserLevel = Informer<UserLevel>(UserLevel.unknown);
  final _currentUser = BehaviorSubject<User?>();
  final _didManageUserLevel = Completer();
  final _hasAuth = Informer<bool>(false);

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  final _debouncer = Debouncer(duration: const Duration(milliseconds: 600));
  final _isReady = Completer<bool>();
  final _mutex = Mutex();

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  Future<bool> get hasReadyAuth async {
    await isReady;
    return _hasAuth.value;
  }

  Future<User?> get readyUser async {
    await isReady;
    return user;
  }

  Future get didManageUserLevel => _didManageUserLevel.future;
  Future<bool> get isReady => _isReady.future;
  Stream<User?> get currentUserStream => _currentUser.stream;
  String? get userId => user?.uid;
  User? get user => _currentUser.valueOrNull;
  ValueListenable<UserLevel> get claimsUserLevel => _claimsUserLevel;
  ValueListenable<bool> get hasAuth => _hasAuth;
  Future<bool> get hasVerifiedEmail async {
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  bool get hasVerifiedPhoneNumber => user?.phoneNumber?.nullIfEmpty != null;
  String? get email => user?.email;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  Future<void> _onLogout() async {
    await LocalStorageService.locate.dispose();
  }

  @CalledByMutex()
  void _tryManageUserLevel(User user) {
    if (_didManageUserLevel.isCompleted) return;
    _debouncer.run(
      () async {
        try {
          if (_didManageUserLevel.isCompleted) return;
          log.debug('Getting claims user level..');
          await user.getIdToken(true);
          final decodedToken = await user.getIdTokenResult();
          final claims = decodedToken.claims;
          _claimsUserLevel.update(claims?.userLevel ?? UserLevel.free);
          _didManageUserLevel.completeIfNotComplete();
          log.debug('Claims user level: ${_claimsUserLevel.value}');
        } catch (error, stackTrace) {
          log.error(
            '$error caught while trying to get claims user level.',
            error: error,
            stackTrace: stackTrace,
          );
        }
      },
    );
  }

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<FeedbackResponse> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const UnexpectedNullException(
          reason: 'user should not be null when trying to delete account.',
        );
      }
      await user.delete();
      return FeedbackResponse.successNone();
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while trying to delete account.',
        error: error,
        stackTrace: stackTrace,
      );
      return FeedbackResponse.errorNone();
    }
  }

  Future<void> requestVerificationCode({
    required String phoneNumber,
    required PhoneVerificationCompleted verificationCompleted,
    required PhoneVerificationFailed verificationFailed,
    required PhoneCodeSent codeSent,
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
    int? forceResendingToken,
  }) async {
    try {
      log.info('Verifying phone number..');
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        forceResendingToken: forceResendingToken,
      );
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while trying to verify phone number.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<FeedbackResponse> linkAuthCredential({
    required AuthCredential authCredential,
  }) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw const UnexpectedNullException(
          reason: 'currentUser should not be null when trying to link phone auth credential.',
        );
      }
      await currentUser.linkWithCredential(authCredential);
      return FeedbackResponse.successNone();
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while trying to link phone auth credential.',
        error: error,
        stackTrace: stackTrace,
      );
      return FeedbackResponse.errorNone();
    }
  }

  Future<FeedbackResponse> logout() async {
    return _mutex.lockAndRun(
      run: (unlock) async {
        try {
          _hasLoggedOut = true;
          await _firebaseAuth.signOut();
          await _onLogout();
          _hasLoggedOut = _firebaseAuth.currentUser == null;
          if (_hasLoggedOut) {
            return FeedbackResponse.success(
              title: 'Logout successful',
              message: 'You are no longer logged in.',
              feedbackType: FeedbackType.notification,
            );
          } else {
            throw const UnexpectedStateException(
              reason: 'User should have been logged out, but was not.',
            );
          }
        } catch (error, stackTrace) {
          log.error(
            '${error.runtimeType} caught while logging out.',
            error: error,
            stackTrace: stackTrace,
          );
          _hasLoggedOut = _firebaseAuth.currentUser == null;
          return FeedbackResponse.error(
            title: 'Logout failed',
            message:
                'An unknown error occurred.${_hasLoggedOut ? ' But we were still able to log you out.' : 'We were not able to log you out.'}',
          );
        } finally {
          unlock();
        }
      },
    );
  }

  Future<FeedbackResponse> sendVerifyEmailEmail() async {
    try {
      log.info('Sending verify email email..');
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const UnexpectedNullException(
          reason: 'user should not be null when trying to send verify email email.',
        );
      }
      await user.sendEmailVerification();
      return FeedbackResponse.success(
        title: 'Verify email sent',
        message: 'Please check your email to verify your account.',
        feedbackType: FeedbackType.notification,
      );
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while trying to send verify email email.',
        error: error,
        stackTrace: stackTrace,
      );
      return FeedbackResponse.errorNone();
    }
  }
}
