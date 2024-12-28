import 'package:hive/hive.dart';

import '../../features/auth/adapters/auth_step_adapter.dart';
import '../adapters/date_format_adapter.dart';
import '../adapters/date_time_adapter.dart';
import '../adapters/emoji_adapter.dart';
import '../adapters/local_storage_adapter.dart';
import '../adapters/navigation_tab_adapter.dart';
import '../adapters/supported_language_adapter.dart';
import '../adapters/supported_theme_mode_adapter.dart';
import '../annotations/do_not_change_order.dart';

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
