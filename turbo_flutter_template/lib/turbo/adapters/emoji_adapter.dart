import 'package:hive_ce/hive.dart';

import '../enums/emoji.dart';
import '../enums/hive_adapters.dart';

class EmojiAdapter extends TypeAdapter<Emoji> {
  @override
  final int typeId = HiveAdapters.emoji.index;

  @override
  Emoji read(BinaryReader reader) => Emoji.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, Emoji obj) => writer.writeByte(obj.index);
}
