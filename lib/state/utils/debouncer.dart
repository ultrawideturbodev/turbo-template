import 'dart:async';
import 'dart:ui';

import '../../data/constants/k_durations.dart';
import '../extensions/completer_extension.dart';

/// A utility class that helps control the rate of execution of callbacks by delaying them.
///
/// The Debouncer ensures that rapidly fired events don't trigger a callback too frequently
/// by waiting for a specified duration of inactivity before executing the callback.
///
/// Example:
/// ```dart
/// final debouncer = Debouncer(duration: Duration(milliseconds: 300));
///
/// // In a search field
/// searchField.onChanged = (value) {
///   debouncer.run(() {
///     // This will only execute 300ms after the last keystroke
///     performSearch(value);
///   });
/// };
/// ```
class Debouncer {
  Debouncer({
    Duration duration = kDurationsAnimation,
  }) : _duration = duration;

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final Duration _duration;

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  Completer? _isRunningCompleter;
  Timer? _timer;
  VoidCallback? _voidCallback;

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  /// Returns a Future that completes when the current debounced operation is finished.
  Future get isDone => _isRunningCompleter?.future ?? Future.value();

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  /// Schedules a callback to be run after the specified duration.
  ///
  /// If another call to [run] occurs before the duration expires, the timer is reset.
  void run(VoidCallback voidCallback) {
    _isRunningCompleter ??= Completer();
    _voidCallback = voidCallback;
    tryCancel();
    _timer = Timer(
      _duration,
      () {
        voidCallback();
        _voidCallback = null;
        _isRunningCompleter!.completeIfNotComplete();
        _isRunningCompleter = null;
      },
    );
  }

  /// Cancels any pending callback if one exists.
  void tryCancel() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  /// Cancels any pending callback and executes it immediately if one exists.
  void tryCancelAndRunNow() {
    tryCancel();
    _voidCallback?.call();
    _voidCallback = null;
  }
}
