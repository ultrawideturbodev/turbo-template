import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/auth/mixins/firebase_auth_exception_handler.dart';
import 'package:turbo_template/auth/services/auth_service.dart';
import 'package:turbo_template/state/utils/block_debouncer.dart';

abstract class AuthSyncService<StreamValue> with FirebaseAuthExceptionHandler {
  AuthSyncService({
    bool initialiseStream = true,
  }) {
    if (initialiseStream) {
      tryInitialiseStream();
    }
  }

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _authService = AuthService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  Future<void> tryInitialiseStream() async {
    _log.info('Initialising AuthSyncService stream..');
    try {
      _userSubscription ??= _authService.currentUserStream.listen(
        (user) async {
          final userId = user?.uid;
          if (userId != null) {
            await onAuth?.call(user!);
            _subscription ??= (await stream(user!)).listen(
              (value) {
                onData(value, user);
              },
              onError: (error, stackTrace) {
                _log.error(
                  'Stream error occurred inside of stream!',
                  error: error,
                  stackTrace: stackTrace,
                );
                _tryRetry();
              },
              onDone: () => onDone(_nrOfRetry, _maxNrOfRetry),
            );
          } else {
            await _subscription?.cancel();
            _subscription = null;
            onData(null, null);
          }
        },
      );
    } catch (error, stack) {
      _log.error('Stream error occurred while setting up stream!', error: error, stackTrace: stack);
      _tryRetry();
    }
  }

  @mustCallSuper
  Future<void> dispose() async {
    _log.warning('Disposing AuthSyncService!');
    await _resetStream();
    _resetRetryTimer();
    _nrOfRetry = 0;
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  StreamSubscription? _subscription;
  StreamSubscription? _userSubscription;
  Timer? _retryTimer;
  final _maxNrOfRetry = 20;
  int _nrOfRetry = 0;

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  late final _log = Log(location: runtimeType.toString());
  final _blockDebouncer = BlockDebouncer(duration: 2.seconds);

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  FutureOr<Stream<StreamValue?>> Function(User user) get stream;
  void Function(StreamValue? value, User? user) get onData;
  FutureOr<void> Function(User user)? onAuth;
  bool get canSync => _blockDebouncer.canContinue;

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void tempBlockStreamUpdates([Future? future]) => _blockDebouncer.onChanged(future);

  Future<void> resetAndTryInitialiseStream() async {
    await _resetStream();
    await tryInitialiseStream();
  }

  void onDone(int nrOfRetry, int maxNrOfRetry) {
    _log.warning('AuthSyncService stream is done!');
  }

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  Future<void> _resetStream() async {
    await _userSubscription?.cancel();
    _userSubscription = null;
    await _subscription?.cancel();
    _subscription = null;
  }

  void _resetRetryTimer() {
    _retryTimer?.cancel();
    _retryTimer = null;
  }

  void _tryRetry() {
    if (_nrOfRetry < _maxNrOfRetry) {
      if (_retryTimer?.isActive ?? false) {
        _resetRetryTimer();
        _log.info('Retry reset!');
      }
      _log.info(
        'Initiating stream retry $_nrOfRetry/$_maxNrOfRetry for AuthSyncService in 10 seconds..',
      );
      _retryTimer = Timer(
        const Duration(seconds: 10),
        () {
          _nrOfRetry++;
          _resetStream();
          tryInitialiseStream();
          _retryTimer = null;
        },
      );
    } else {
      _resetStream();
    }
  }

// 📍 LOCATOR ------------------------------------------------------------------------------- \\
}
