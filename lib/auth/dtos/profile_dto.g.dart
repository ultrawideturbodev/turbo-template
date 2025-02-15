// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) => ProfileDto(
      id: json['id'] as String,
      bio: json['bio'] as String?,
      birthDate: (json['birthDate'] as num?)?.toInt(),
      created:
          const TimestampConverter().fromJson(json['created'] as Timestamp),
      name: json['name'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      imageUrl: json['imageUrl'] as String?,
      userId: json['userId'] as String,
      geoPoint: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['geoPoint'], const GeoPointConverter().fromJson),
      username: json['username'] as String,
      updated:
          const TimestampConverter().fromJson(json['updated'] as Timestamp),
    );

Map<String, dynamic> _$ProfileDtoToJson(ProfileDto instance) =>
    <String, dynamic>{
      'bio': instance.bio,
      'birthDate': instance.birthDate,
      'created': const TimestampConverter().toJson(instance.created),
      'name': instance.name,
      'gender': _$GenderEnumMap[instance.gender],
      'imageUrl': instance.imageUrl,
      'userId': instance.userId,
      'username': instance.username,
      'geoPoint': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.geoPoint, const GeoPointConverter().toJson),
      'updated': const TimestampConverter().toJson(instance.updated),
    };

const _$GenderEnumMap = {
  Gender.female: 'female',
  Gender.male: 'male',
  Gender.nonBinary: 'nonBinary',
  Gender.preferNotToSay: 'preferNotToSay',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
