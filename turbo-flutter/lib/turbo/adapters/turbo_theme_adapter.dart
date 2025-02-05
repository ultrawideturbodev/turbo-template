import 'package:hive_ce/hive.dart';
import 'package:turbo_template/turbo/enums/turbo_theme.dart';

import '../enums/hive_adapters.dart';

class TurboThemeAdapter extends TypeAdapter<TurboTheme> {
  @override
  final int typeId = HiveAdapters.turboTheme.index;

  @override
  TurboTheme read(BinaryReader reader) => TurboTheme.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, TurboTheme obj) => writer.writeByte(obj.index);
}
