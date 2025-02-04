import 'package:hive_ce/hive.dart';
import 'package:turbo_template/turbo/enums/auth_step.dart';
import 'package:turbo_template/turbo/enums/hive_adapters.dart';
import 'package:turbo_template/turbo/enums/navigation_tab.dart';
import 'package:turbo_template/turbo/enums/supported_language.dart';
import 'package:turbo_template/local_storage/dtos/local_storage_dto.dart';
import 'package:turbo_template/turbo/enums/turbo_theme_mode.dart';

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
      supportedLanguage: fields[4] as SupportedLanguage,
      turboThemeMode: fields[5] as TurboThemeMode,
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
      ..write(obj.turboThemeMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalStorageDtoAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
