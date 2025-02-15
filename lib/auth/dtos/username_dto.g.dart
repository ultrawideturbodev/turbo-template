// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'username_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsernameDto _$UsernameDtoFromJson(Map<String, dynamic> json) => UsernameDto(
      id: json['id'] as String,
      documentReference: const DocumentReferenceConverter()
          .fromJson(json['documentReference'] as DocumentReference<Object?>),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$UsernameDtoToJson(UsernameDto instance) =>
    <String, dynamic>{
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'userId': instance.userId,
    };
