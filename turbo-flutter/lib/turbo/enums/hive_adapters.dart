import 'package:hive_ce/hive.dart';
import 'package:turbo_template/auth/adapters/auth_step_adapter.dart';
import 'package:turbo_template/turbo/adapters/date_format_adapter.dart';
import 'package:turbo_template/turbo/adapters/date_time_adapter.dart';
import 'package:turbo_template/turbo/adapters/emoji_adapter.dart';
import 'package:turbo_template/turbo/adapters/local_storage_adapter.dart';
import 'package:turbo_template/turbo/adapters/navigation_tab_adapter.dart';
import 'package:turbo_template/turbo/adapters/supported_language_adapter.dart';
import 'package:turbo_template/turbo/adapters/turbo_theme_adapter.dart';
import 'package:turbo_template/turbo/adapters/turbo_theme_mode_adapter.dart';
import 'package:turbo_template/turbo/annotations/do_not_change_order.dart';

@DoNotChangeOrder()
enum HiveAdapters {
  dateTime,
  navigationTab,
  supportedLanguage,
  turboThemeMode,
  authStep,
  emoji,
  dateFormat,
  localStorageDto,
  turboTheme,
  ;

  void registerAdapter() {
    switch (this) {
      case HiveAdapters.dateTime:
        Hive.registerAdapter(DateTimeAdapter());
        break;
      case HiveAdapters.navigationTab:
        Hive.registerAdapter(NavigationTabAdapter());
        break;
      case HiveAdapters.supportedLanguage:
        Hive.registerAdapter(SupportedLanguageAdapter());
        break;
      case HiveAdapters.turboThemeMode:
        Hive.registerAdapter(TurboThemeModeAdapter());
        break;
      case HiveAdapters.authStep:
        Hive.registerAdapter(AuthStepAdapter());
        break;
      case HiveAdapters.emoji:
        Hive.registerAdapter(EmojiAdapter());
        break;
      case HiveAdapters.dateFormat:
        Hive.registerAdapter(DateFormatAdapter());
        break;
      case HiveAdapters.localStorageDto:
        Hive.registerAdapter(LocalStorageDtoAdapter());
        break;
      case HiveAdapters.turboTheme:
        Hive.registerAdapter(TurboThemeAdapter());
        break;
    }
  }
}
