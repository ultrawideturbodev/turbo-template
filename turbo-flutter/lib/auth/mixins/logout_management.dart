import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/auth/services/auth_service.dart';
import 'package:turbo_template/state/globals/g_busy.dart';
import 'package:turbo_template/state/config/app_setup.dart';
import 'package:turbo_template/routing/routers/core_router.dart';
import 'package:turbo_template/feedback/services/dialog_service.dart';
import 'package:turbo_template/feedback/services/toast_service.dart';
import 'package:veto/data/models/base_view_model.dart';

mixin LogoutManagement on BaseViewModel {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  final _dialogService = DialogService.lazyLocate;
  final _authService = AuthService.lazyLocate;
  final _coreRouter = CoreRouter.lazyLocate;
  final _toastService = ToastService.lazyLocate;

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<void> onLogoutPressed() async {
    try {
      final shouldLogout = await _dialogService().showOkCancelDialog(
        title: 'Logout',
        message: 'Are you sure you want to logout?',
        context: context,
      );

      if (shouldLogout == true) {
        try {
          gSetBusy();
          final response = await _authService().logout();
          await response.when(
            success: (response) async {
              _toastService().showToast(
                context: context,
                title: 'Logged out',
                subtitle: 'Please come back soon!',
              );
              await onLogout();
              navAfterLogout();
            },
            fail: (response) {
              _toastService().showToast(
                context: context,
                title: 'Unable to log you out',
                subtitle: 'Something went wrong. Please try again later.',
              );
            },
          );
        } catch (error, stackTrace) {
          Log(location: 'LogoutMixin').error(
            '$error caught while logging out',
            error: error,
            stackTrace: stackTrace,
          );
        } finally {
          gSetIdle();
        }
      }
    } catch (error, stackTrace) {
      Log(location: 'LogoutMixin').error(
        'Unexpected ${error.runtimeType} caught while logging out.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> onLogout() async {}

  void navAfterLogout() => _coreRouter().goAuthView();
}
