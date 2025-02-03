import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:turbo_template/turbo/abstracts/base_navigation.dart';
import 'package:turbo_template/turbo/enums/navigation_tab.dart';
import 'package:turbo_template/turbo/extensions/string_extension.dart';
import 'package:turbo_template/settings/views/settings_view.dart';

class SettingsRouter extends BaseNavigation {
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  @override
  NavigationTab? get navigationTab => null;

  @override
  String get root => SettingsView.path.asRootPath;

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void goSettingsView({
    StatefulNavigationShell? statefulNavigationShell,
    bool shouldLaunchInboxPopup = false,
  }) {
    if (statefulNavigationShell != null) {
      goBranch(
        statefulNavigationShell: statefulNavigationShell,
      );
      if (kIsWeb) {
        // bug
        goBranch(
          statefulNavigationShell: statefulNavigationShell,
        );
      }
    } else {
      go(
        location: root,
        extra: const [],
      );
    }
  }

  static SettingsRouter get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(SettingsRouter.new);
}
