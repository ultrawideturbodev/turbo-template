import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';

import 'package:turbo_template/state/extensions/completer_extension.dart';
import 'package:turbo_template/state/utils/debouncer.dart';
import 'package:turbo_template/state/utils/mutex.dart';

/// Enforces permissions for the current user based on our Firestore security rules.
class PermissionsService extends ChangeNotifier with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static PermissionsService get locate => GetIt.I.get();

  static void registerLazySingleton() => GetIt.I.registerLazySingleton(
        PermissionsService.new,
        dispose: (param) => param.dispose(),
      );

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  void dispose() {
    log.info('Disposing PermissionsService..');
    _debouncer.tryCancel();
    super.dispose();
    log.info('PermissionsService disposed!');
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  bool _didUpdateIsAdmin = false;
  bool _didUpdateUserInfo = false;
  bool _isAdmin = false;

  final _isReady = Completer();
  late String _userId;

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  final _debouncer = Debouncer();
  final _mutex = Mutex();

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  bool get isAdmin => _isAdmin;
  Future get isReady => _isReady.future;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  void _reset() {
    try {
      log.info('Resetting permissions..');
      _isAdmin = false;
      _userId = '';
      notifyListeners();
      log.info('Permissions reset!');
    } catch (error, stackTrace) {
      log.error(
        '$error caught while resetting permissions..',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void updateIsAdmin({required bool isAdmin}) => _mutex.lockAndRun(
        run: (unlock) async {
          try {
            log.info('Updating isAdmin to "$isAdmin"..');
            _debouncer.tryCancel();
            _isAdmin = isAdmin;
            _didUpdateIsAdmin = true;
            if (_didUpdateUserInfo) {
              _isReady.completeIfNotComplete();
            }
            notifyListeners();
          } catch (error, stackTrace) {
            log.error(
              'Exception caught while updating isAdmin',
              error: error,
              stackTrace: stackTrace,
            );
          } finally {
            unlock();
          }
        },
      );

  void updateUserInfo({
    required String userId,
  }) {
    _mutex.lockAndRun(
      run: (unlock) async {
        try {
          log.info('Updating user info..');
          _debouncer.tryCancel();
          _userId = userId;
          _didUpdateUserInfo = true;
          if (_didUpdateIsAdmin) {
            _isReady.completeIfNotComplete();
          }
          notifyListeners();
        } catch (error, stackTrace) {
          log.error(
            'Exception caught while updating user info!',
            error: error,
            stackTrace: stackTrace,
          );
        } finally {
          unlock();
        }
      },
    );
  }

  void reset() => _debouncer.run(
        () {
          _reset();
        },
      );
}
