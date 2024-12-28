import 'package:hive/hive.dart';

import '../dtos/local_storage_dto.dart';
import '../enums/auth_step.dart';
import '../enums/hive_adapters.dart';
import '../enums/navigation_tab.dart';
import '../enums/supported_language.dart';
import '../enums/supported_theme_mode.dart';

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
      id: fields[0] as String,
      createdAt: fields[1] as DateTime,
      updatedAt: fields[2] as DateTime,
      hasAuth: fields[3] as bool,
      createdBy: fields[4] as String,
      updatedBy: fields[5] as String,
      language: fields[6] as SupportedLanguage,
      themeMode: fields[7] as SupportedThemeMode,
      navigationTab: fields[8] as NavigationTab,
      didHappen: (fields[9] as List).cast<AuthStep>(),
      skippedVerifyEmailDate: fields[10] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalStorageDto obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.hasAuth)
      ..writeByte(4)
      ..write(obj.createdBy)
      ..writeByte(5)
      ..write(obj.updatedBy)
      ..writeByte(6)
      ..write(obj.language)
      ..writeByte(7)
      ..write(obj.themeMode)
      ..writeByte(8)
      ..write(obj.navigationTab)
      ..writeByte(9)
      ..write(obj.didHappen)
      ..writeByte(10)
      ..write(obj.skippedVerifyEmailDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalStorageDtoAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
