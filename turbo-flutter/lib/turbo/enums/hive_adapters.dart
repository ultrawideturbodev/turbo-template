import 'package:hive_ce/hive.dart';
import 'package:turbo_template/local_storage/dtos/local_storage_dto.dart';
import 'package:turbo_template/turbo/enums/auth_step.dart';
import 'package:turbo_template/turbo/enums/date_format.dart';
import 'package:turbo_template/turbo/enums/emoji.dart';
import 'package:turbo_template/turbo/enums/navigation_tab.dart';
import 'package:turbo_template/turbo/enums/supported_language.dart';
import 'package:turbo_template/turbo/enums/turbo_theme.dart';
import 'package:turbo_template/turbo/enums/turbo_theme_mode.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<DateTime>(),
  AdapterSpec<NavigationTab>(),
  AdapterSpec<SupportedLanguage>(),
  AdapterSpec<TurboThemeMode>(),
  AdapterSpec<AuthStep>(),
  AdapterSpec<Emoji>(),
  AdapterSpec<DateFormat>(),
  AdapterSpec<LocalStorageDto>(),
  AdapterSpec<TurboTheme>(),
])
enum HiveAdapters {
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
