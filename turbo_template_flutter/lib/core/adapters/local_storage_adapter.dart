import 'package:hive_ce/hive.dart';
import 'package:turbo_template/core/enums/auth_step.dart';
import 'package:turbo_template/core/enums/hive_adapters.dart';
import 'package:turbo_template/core/enums/navigation_tab.dart';
import 'package:turbo_template/core/enums/supported_language.dart';
import 'package:turbo_template/core/enums/supported_theme_mode.dart';
import 'package:turbo_template/local_storage/dtos/local_storage_dto.dart';

class LocalStorageDtoAdapter extends TypeAdapter<LocalStorageDto> {
  @override
  final int typeId = HiveAdapters.localStorageDto.index;

  @override
  LocalStorageDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    final List<dynamic>? authStepList = fields[3] as List?;
    final List<AuthStep> didHappen = authStepList?.whereType<AuthStep>().toList() ?? [];

    return LocalStorageDto(
      createdAt: fields[0] as DateTime,
      updatedAt: fields[1] as DateTime,
      navigationTab: fields[2] as NavigationTab,
      didHappen: didHappen,
      hasAuth: fields[4] as bool,
      supportedLanguage: fields[5] as SupportedLanguage,
      supportedThemeMode: fields[6] as SupportedThemeMode,
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
      ..write(obj.hasAuth)
      ..writeByte(5)
      ..write(obj.supportedLanguage)
      ..writeByte(6)
      ..write(obj.supportedThemeMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalStorageDtoAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
