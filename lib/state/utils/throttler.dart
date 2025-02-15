import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:turbo_template/data/constants/k_durations.dart';

class Throttler {
  Throttler({this.duration = kDurationsAnimation});

  final Duration duration;
  Timer? _timer;
  bool _isThrottled = false;
  VoidCallback? _pendingAction;

  void run(VoidCallback action) {
    if (_isThrottled) {
      _pendingAction = action;
      return;
    }

    action();
    _isThrottled = true;

    _timer?.cancel();
    _timer = Timer(duration, () {
      _isThrottled = false;
      if (_pendingAction != null) {
        final pendingAction = _pendingAction;
        _pendingAction = null;
        pendingAction!();
      }
    });
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    _pendingAction = null;
  }
}
