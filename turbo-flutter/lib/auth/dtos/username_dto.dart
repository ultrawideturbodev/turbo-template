import 'package:json_annotation/json_annotation.dart';

import 'package:turbo_template/firebase/firestore/converters/document_reference_converter.dart';
import 'package:turbo_template/firebase/firestore/converters/timestamp_converter.dart';

part 'username_dto.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class UsernameDto {
  UsernameDto({
    required this.id,
    required this.documentReference,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  @JsonKey(includeFromJson: true, includeToJson: false)
  final String id;
  @JsonKey(includeFromJson: true, includeToJson: false)
  @DocumentReferenceConverter()
  final DocumentReference documentReference;
  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;
  final String userId;

  static const fromJsonFactory = _$UsernameDtoFromJson;
  factory UsernameDto.fromJson(Map<String, dynamic> json) => _$UsernameDtoFromJson(json);
  static const toJsonFactory = _$UsernameDtoToJson;
  Map<String, dynamic> toJson() => _$UsernameDtoToJson(this);
}
