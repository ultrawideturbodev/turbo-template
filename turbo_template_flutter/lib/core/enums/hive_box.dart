import '../globals/g_user_id.dart';

enum HiveBox {
  localStorageDto,
  ;

  String get id => toString();

  String documentId({required String? id}) => switch (this) {
        HiveBox.localStorageDto => '$gDeviceId${id != null ? '_$id' : ''}',
      };
}
