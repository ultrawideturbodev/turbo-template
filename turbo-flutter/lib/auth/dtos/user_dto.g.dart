// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      id: json['id'] as String,
      acceptedPrivacyAndTermsAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['acceptedPrivacyAndTermsAt'],
          const TimestampConverter().fromJson),
      addressCity: json['addressCity'] as String?,
      addressPostalCode: json['addressPostalCode'] as String?,
      addressStreet: json['addressStreet'] as String?,
      addressStreetNumber: json['addressStreetNumber'] as String?,
      addressStreetNumberAddition:
          json['addressStreetNumberAddition'] as String?,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      email: json['email'] as String,
      phone: json['phone'] as String?,
      geoPoint: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['geoPoint'], const GeoPointConverter().fromJson),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
      trialEnd: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['trialEnd'], const TimestampConverter().fromJson),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      userLevel: json['userLevel'] == null
          ? null
          : UserLevelDto.fromJson(json['userLevel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'acceptedPrivacyAndTermsAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.acceptedPrivacyAndTermsAt,
          const TimestampConverter().toJson),
      'addressCity': instance.addressCity,
      'addressPostalCode': instance.addressPostalCode,
      'addressStreet': instance.addressStreet,
      'addressStreetNumber': instance.addressStreetNumber,
      'addressStreetNumberAddition': instance.addressStreetNumberAddition,
      'email': instance.email,
      'phone': instance.phone,
      'geoPoint': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.geoPoint, const GeoPointConverter().toJson),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'trialEnd': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.trialEnd, const TimestampConverter().toJson),
      'tags': instance.tags,
      'userLevel': instance.userLevel?.toJson(),
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

UpdateUserDtoRequest _$UpdateUserDtoRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateUserDtoRequest(
      acceptedPrivacyAndTermsAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['acceptedPrivacyAndTermsAt'],
          const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$UpdateUserDtoRequestToJson(
        UpdateUserDtoRequest instance) =>
    <String, dynamic>{
      if (_$JsonConverterToJson<Timestamp, DateTime>(
              instance.acceptedPrivacyAndTermsAt,
              const TimestampConverter().toJson)
          case final value?)
        'acceptedPrivacyAndTermsAt': value,
    };
