import 'package:cloud_firestore_api/abstracts/writeable.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class WriteableId<T extends Object> extends Writeable {
  WriteableId({
    this.isLocalDefault = false,
  });
  T get id;

  /// Used to indicate default local values.
  @JsonKey(includeToJson: false, includeFromJson: false)
  final bool isLocalDefault;
}
