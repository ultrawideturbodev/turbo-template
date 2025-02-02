// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileDto _$UserProfileDtoFromJson(Map<String, dynamic> json) =>
    UserProfileDto(
      id: json['id'] as String,
      bio: json['bio'] as String?,
      birthDate: (json['birthDate'] as num?)?.toInt(),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      userId: json['userId'] as String,
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      username: json['username'] as String?,
    );

Map<String, dynamic> _$UserProfileDtoToJson(UserProfileDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'bio': instance.bio,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'username': instance.username,
      'birthDate': instance.birthDate,
      'gender': _$GenderEnumMap[instance.gender],
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

const _$GenderEnumMap = {
  Gender.female: 'female',
  Gender.male: 'male',
  Gender.nonBinary: 'nonBinary',
  Gender.preferNotToSay: 'preferNotToSay',
};
