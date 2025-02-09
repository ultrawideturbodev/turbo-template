import 'package:hive_ce/hive.dart';
import 'package:turbo_template/local_storage/dtos/local_storage_dto.dart';
import 'package:turbo_template/auth/enums/auth_step.dart';
import 'package:turbo_template/ui/enums/date_format.dart';
import 'package:turbo_template/ui/enums/emoji.dart';
import 'package:turbo_template/routing/enums/navigation_tab.dart';
import 'package:turbo_template/localizations/enums/supported_language.dart';
import 'package:turbo_template/ui/enums/t_theme.dart';
import 'package:turbo_template/ui/enums/t_theme_mode.dart';

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

class NavigationTabAdapter extends TypeAdapter<NavigationTab> {
  @override
  final int typeId = HiveAdapters.navigationTab.index;

  @override
  NavigationTab read(BinaryReader reader) => NavigationTab.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, NavigationTab obj) => writer.writeByte(obj.index);
}

class SupportedLanguageAdapter extends TypeAdapter<SupportedLanguage> {
  @override
  final int typeId = HiveAdapters.supportedLanguage.index;

  @override
  SupportedLanguage read(BinaryReader reader) => SupportedLanguage.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, SupportedLanguage obj) => writer.writeByte(obj.index);
}

class TurboThemeModeAdapter extends TypeAdapter<TThemeMode> {
  @override
  final int typeId = HiveAdapters.turboThemeMode.index;

  @override
  TThemeMode read(BinaryReader reader) => TThemeMode.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, TThemeMode obj) => writer.writeByte(obj.index);
}

class AuthStepAdapter extends TypeAdapter<AuthStep> {
  @override
  final int typeId = HiveAdapters.authStep.index;

  @override
  AuthStep read(BinaryReader reader) => AuthStep.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, AuthStep obj) => writer.writeByte(obj.index);
}

class EmojiAdapter extends TypeAdapter<Emoji> {
  @override
  final int typeId = HiveAdapters.emoji.index;

  @override
  Emoji read(BinaryReader reader) => Emoji.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, Emoji obj) => writer.writeByte(obj.index);
}

class DateFormatAdapter extends TypeAdapter<DateFormat> {
  @override
  final int typeId = HiveAdapters.dateFormat.index;

  @override
  DateFormat read(BinaryReader reader) => DateFormat.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, DateFormat obj) => writer.writeByte(obj.index);
}

class TurboThemeAdapter extends TypeAdapter<TTheme> {
  @override
  final int typeId = HiveAdapters.turboTheme.index;

  @override
  TTheme read(BinaryReader reader) => TTheme.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, TTheme obj) => writer.writeByte(obj.index);
}

class LocalStorageDtoAdapter extends TypeAdapter<LocalStorageDto> {
  @override
  final int typeId = HiveAdapters.localStorageDto.index;

  @override
  LocalStorageDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalStorageDto(
      createdAt: fields[0] as DateTime,
      updatedAt: fields[1] as DateTime,
      navigationTab: fields[2] as NavigationTab,
      didHappen: (fields[3] as List).cast<AuthStep>(),
      supportedLanguage: fields[4] as SupportedLanguage,
      turboThemeMode: fields[5] as TThemeMode,
      turboTheme: fields[6] as TTheme,
    );
  }

  @override
  void write(BinaryWriter writer, LocalStorageDto obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.updatedAt)
      ..writeByte(2)
      ..write(obj.navigationTab)
      ..writeByte(3)
      ..write(obj.didHappen)
      ..writeByte(4)
      ..write(obj.supportedLanguage)
      ..writeByte(5)
      ..write(obj.turboThemeMode)
      ..writeByte(6)
      ..write(obj.turboTheme);
  }
}
