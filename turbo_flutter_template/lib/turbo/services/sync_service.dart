import 'dart:async';

import 'package:loglytics/loglytics.dart';

abstract class SyncService<T extends Object?> {
  SyncService({
    bool initialiseStream = true,
  }) {
    if (initialiseStream) {
      tryInitialiseStream();
    }
  }

  StreamSubscription? _subscription;
  Timer? _retryTimer;
  final int _maxNrOfRetry = 20;
  int _nrOfRetry = 0;

  late final Log _log = Log(location: runtimeType.toString());

  Stream<T> Function() get stream;
  void Function(T value) get onData;
  void onDone(int nrOfRetry, int maxNrOfRetry) {
    _log.warning('$runtimeType stream is done!');
  }

  Future<void> tryInitialiseStream() async {
    await _resetStream();
    _log.info('Initialising $runtimeType stream..');
    try {
      _subscription = stream().listen(
        onData,
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
    } catch (error, stack) {
      _log.error('Stream error occurred while setting up stream!', error: error, stackTrace: stack);
      _tryRetry();
    }
    _log.info('$runtimeType stream initialised!');
  }

  Future<void> dispose() async {
    _log.warning('Disposing $runtimeType!');
    await _resetStream();
    _resetRetryTimer();
    _nrOfRetry = 0;
  }

  Future<void> _resetStream() async {
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
        'Initiating stream retry $_nrOfRetry/$_maxNrOfRetry for $runtimeType in 10 seconds..',
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
}
