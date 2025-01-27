import 'package:hive_ce/hive.dart';
import 'package:turbo_template/core/adapters/date_format_adapter.dart';
import 'package:turbo_template/core/adapters/date_time_adapter.dart';
import 'package:turbo_template/core/adapters/emoji_adapter.dart';
import 'package:turbo_template/core/adapters/local_storage_adapter.dart';
import 'package:turbo_template/core/adapters/navigation_tab_adapter.dart';
import 'package:turbo_template/core/adapters/supported_language_adapter.dart';
import 'package:turbo_template/core/adapters/supported_theme_mode_adapter.dart';
import 'package:turbo_template/core/annotations/do_not_change_order.dart';
import 'package:turbo_template/auth/adapters/auth_step_adapter.dart';

@DoNotChangeOrder()
enum HiveAdapters {
  dateTime,
  navigationTab,
  supportedLanguage,
  supportedThemeMode,
  authStep,
  emoji,
  dateFormat,
  localStorageDto,
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
      case HiveAdapters.supportedThemeMode:
        Hive.registerAdapter(SupportedThemeModeAdapter());
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
    }
  }
}
