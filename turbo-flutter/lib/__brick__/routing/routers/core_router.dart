import 'package:get_it/get_it.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:{{packageName.snakeCase()}}/auth/views/auth/auth_view.dart';
import 'package:{{packageName.snakeCase()}}/auth/views/forgot_password/forgot_password_view.dart';
import 'package:{{packageName.snakeCase()}}/routing/abstracts/base_navigation.dart';
import 'package:{{packageName.snakeCase()}}/routing/enums/navigation_tab.dart';
import 'package:{{packageName.snakeCase()}}/data/extensions/string_extension.dart';
import 'package:{{packageName.snakeCase()}}/state/views/oops/oops_view.dart';

class CoreRouter extends BaseNavigation {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static CoreRouter Function() get lazyLocate => () => GetIt.I.get<CoreRouter>();
  static CoreRouter get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(CoreRouter.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\

  @override
  NavigationTab? get navigationTab => null;

  @override
  String get root => AuthView.path;

  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
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
}
