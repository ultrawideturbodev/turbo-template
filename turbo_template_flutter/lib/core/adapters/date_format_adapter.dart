import 'package:hive/hive.dart';

import '../enums/date_format.dart';
import '../enums/hive_adapters.dart';

class DateFormatAdapter extends TypeAdapter<DateFormat> {
  @override
  final int typeId = HiveAdapters.dateFormat.index;

  @override
  DateFormat read(BinaryReader reader) => DateFormat.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, DateFormat obj) => writer.writeByte(obj.index);
}
