import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../auth/views/auth/auth_view.dart';
import '../../auth/views/forgot_password/forgot_password_view.dart';
import '../abstracts/base_navigation.dart';
import '../enums/navigation_tab.dart';
import '../extensions/string_extension.dart';
import '../views/oops/oops_view.dart';

class CoreRouter extends BaseNavigation {
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  @override
  NavigationTab? get navigationTab => null;

  @override
  String get root => AuthView.path;

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void goOopsView() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        go(
          location: OopsView.path.asRootPath,
        );
      },
    );
  }

  void goAuthView() => go(
        location: root,
        extra: [],
      );

  Future<void> pushForgotPasswordView() async => push(
        location: ForgotPasswordView.path.asRootPath,
      );

  static CoreRouter get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(CoreRouter.new);
}
