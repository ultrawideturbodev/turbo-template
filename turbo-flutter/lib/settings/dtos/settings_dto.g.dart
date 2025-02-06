// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsDto _$SettingsDtoFromJson(Map<String, dynamic> json) => SettingsDto(
      id: json['id'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
      userId: json['userId'] as String,
      skippedVerifyEmailDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['skippedVerifyEmailDate'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$SettingsDtoToJson(SettingsDto instance) =>
    <String, dynamic>{
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'userId': instance.userId,
      'skippedVerifyEmailDate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.skippedVerifyEmailDate, const TimestampConverter().toJson),
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

UpdateSettingsDtoRequest _$UpdateSettingsDtoRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateSettingsDtoRequest(
      skippedVerifyEmailDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['skippedVerifyEmailDate'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$UpdateSettingsDtoRequestToJson(
        UpdateSettingsDtoRequest instance) =>
    <String, dynamic>{
      if (_$JsonConverterToJson<Timestamp, DateTime>(
              instance.skippedVerifyEmailDate,
              const TimestampConverter().toJson)
          case final value?)
        'skippedVerifyEmailDate': value,
    };
