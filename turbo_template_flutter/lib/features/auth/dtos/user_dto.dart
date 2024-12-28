import 'package:json_annotation/json_annotation.dart';

import '../../../core/converters/geo_point_converter.dart';
import '../../../core/converters/timestamp_converter.dart';
import '../../../core/globals/g_now.dart';
import 'user_level_dto.dart';

part 'user_dto.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class UserDto {
  UserDto({
    required this.id,
    required this.acceptedPrivacyAndTermsAt,
    this.addressCity,
    this.addressPostalCode,
    this.addressStreet,
    this.addressStreetNumber,
    this.addressStreetNumberAddition,
    required this.createdAt,
    required this.email,
    this.phone,
    this.geoPoint,
    required this.updatedAt,
    this.trialEnd,
    required this.tags,
    required this.userLevel,
  });

  factory UserDto.defaultValue({
    required String userId,
    required String email,
    DateTime? acceptedPrivacyAndTermsAt,
    DateTime? trialEnd,
  }) {
    final now = gNow;
    return UserDto(
      acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt,
      id: userId,
      updatedAt: now,
      createdAt: now,
      email: email,
      trialEnd: trialEnd,
      tags: [],
      userLevel: UserLevelDto.defaultValue(userId: userId),
    );
  }

  @TimestampConverter()
  final DateTime? acceptedPrivacyAndTermsAt;
  final String? addressCity;
  final String? addressPostalCode;
  final String? addressStreet;
  final String? addressStreetNumber;
  final String? addressStreetNumberAddition;
  final String email;
  final String? phone;
  @GeoPointConverter()
  final GeoPoint? geoPoint;

  @JsonKey(includeFromJson: true, includeToJson: false)
  final String id;
  @JsonKey(includeFromJson: true, includeToJson: false)
  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;
  @TimestampConverter()
  final DateTime? trialEnd;
  @JsonKey(defaultValue: [])
  final List<String> tags;
  final UserLevelDto? userLevel;

  static const fromJsonFactory = _$UserDtoFromJson;
  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  static const toJsonFactory = _$UserDtoToJson;
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
