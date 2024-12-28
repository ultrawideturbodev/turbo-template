import 'package:hive/hive.dart';

import '../enums/hive_adapters.dart';
import '../enums/navigation_tab.dart';

class NavigationTabAdapter extends TypeAdapter<NavigationTab> {
  @override
  final int typeId = HiveAdapters.navigationTab.index;

  @override
  NavigationTab read(BinaryReader reader) => NavigationTab.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, NavigationTab obj) => writer.writeByte(obj.index);
}
