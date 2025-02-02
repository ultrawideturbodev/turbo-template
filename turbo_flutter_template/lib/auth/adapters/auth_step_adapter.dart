import 'package:hive_ce/hive.dart';
import 'package:turbo_template/turbo/enums/auth_step.dart';
import 'package:turbo_template/turbo/enums/hive_adapters.dart';

class AuthStepAdapter extends TypeAdapter<AuthStep> {
  @override
  final int typeId = HiveAdapters.authStep.index;

  @override
  AuthStep read(BinaryReader reader) => AuthStep.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, AuthStep obj) => writer.writeByte(obj.index);
}
