import 'package:turbo_template/core/extensions/string_extension.dart';

enum BoxType {
  localStorageDto,
  ;

  String get id => toString();

  String documentId({required String id}) => id.and(this);
}
