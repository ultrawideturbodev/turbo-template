import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:{{packageName.snakeCase()}}/routing/abstracts/base_navigation.dart';
import 'package:{{packageName.snakeCase()}}/routing/enums/navigation_tab.dart';
import 'package:{{packageName.snakeCase()}}/data/extensions/string_extension.dart';
import 'package:{{packageName.snakeCase()}}/state/views/placeholder/placeholder_view.dart';

class PlaceholderRouter extends BaseNavigation {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static PlaceholderRouter get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(PlaceholderRouter.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\

  @override
  NavigationTab? get navigationTab => NavigationTab.placeholder;

  @override
  String get root => PlaceholderView.path.asRootPath;

  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  void goPlaceholderView({
    StatefulNavigationShell? statefulNavigationShell,
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
}
