import 'package:hive_ce/hive.dart';

import '../enums/hive_adapters.dart';
import '../enums/supported_theme_mode.dart';

class SupportedThemeModeAdapter extends TypeAdapter<SupportedThemeMode> {
  @override
  final int typeId = HiveAdapters.supportedThemeMode.index;

  @override
  SupportedThemeMode read(BinaryReader reader) => SupportedThemeMode.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, SupportedThemeMode obj) => writer.writeByte(obj.index);
}
