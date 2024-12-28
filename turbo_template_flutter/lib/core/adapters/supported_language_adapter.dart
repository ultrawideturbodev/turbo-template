import 'package:hive/hive.dart';

import '../enums/hive_adapters.dart';
import '../enums/supported_language.dart';

class SupportedLanguageAdapter extends TypeAdapter<SupportedLanguage> {
  @override
  final int typeId = HiveAdapters.supportedLanguage.index;

  @override
  SupportedLanguage read(BinaryReader reader) => SupportedLanguage.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, SupportedLanguage obj) => writer.writeByte(obj.index);
}
