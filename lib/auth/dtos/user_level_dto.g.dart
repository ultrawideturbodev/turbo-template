// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_level_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLevelDto _$UserLevelDtoFromJson(Map<String, dynamic> json) => UserLevelDto(
      startedAt:
          const TimestampConverter().fromJson(json['startedAt'] as Timestamp),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
      updatedBy: json['updatedBy'] as String,
      userLevel: $enumDecode(_$UserLevelEnumMap, json['userLevel']),
      userLevelDurationInDays: _$JsonConverterFromJson<int, Duration>(
          json['userLevelDurationInDays'],
          const DurationDaysConverter().fromJson),
    );

Map<String, dynamic> _$UserLevelDtoToJson(UserLevelDto instance) =>
    <String, dynamic>{
      'startedAt': const TimestampConverter().toJson(instance.startedAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'updatedBy': instance.updatedBy,
      'userLevel': _$UserLevelEnumMap[instance.userLevel]!,
      'userLevelDurationInDays': _$JsonConverterToJson<int, Duration>(
          instance.userLevelDurationInDays,
          const DurationDaysConverter().toJson),
    };

const _$UserLevelEnumMap = {
  UserLevel.unknown: 'unknown',
  UserLevel.free: 'free',
  UserLevel.friend: 'friend',
  UserLevel.premium: 'premium',
  UserLevel.admin: 'admin',
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
