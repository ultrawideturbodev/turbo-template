import 'package:hive_ce/hive.dart';
import 'package:turbo_template/turbo/enums/turbo_theme_mode.dart';

import '../enums/hive_adapters.dart';

class TurboThemeModeAdapter extends TypeAdapter<TurboThemeMode> {
  @override
  final int typeId = HiveAdapters.turboThemeMode.index;

  @override
  TurboThemeMode read(BinaryReader reader) => TurboThemeMode.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, TurboThemeMode obj) => writer.writeByte(obj.index);
}
