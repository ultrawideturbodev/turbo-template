import 'package:cloud_firestore_api/cloud_firestore_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_template/core/abstracts/writeable_id.dart';
import 'package:turbo_template/core/converters/geo_point_converter.dart';
import 'package:turbo_template/core/converters/timestamp_converter.dart';
import 'package:turbo_template/core/globals/g_now.dart';
import 'package:turbo_template/features/auth/dtos/user_level_dto.dart';

part 'user_dto.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class UserDto extends WriteableId<String> {
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
  @override
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @override
  String toString() {
    return 'UserDto{acceptedPrivacyAndTermsAt: $acceptedPrivacyAndTermsAt, addressCity: $addressCity, addressPostalCode: $addressPostalCode, addressStreet: $addressStreet, addressStreetNumber: $addressStreetNumber, addressStreetNumberAddition: $addressStreetNumberAddition, email: $email, phone: $phone, geoPoint: $geoPoint, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, trialEnd: $trialEnd, tags: $tags, userLevel: $userLevel}';
  }

  UserDto copyWith({
    DateTime? acceptedPrivacyAndTermsAt,
    String? addressCity,
    String? addressPostalCode,
    String? addressStreet,
    String? addressStreetNumber,
    String? addressStreetNumberAddition,
    String? email,
    String? phone,
    GeoPoint? geoPoint,
    DateTime? trialEnd,
    List<String>? tags,
    UserLevelDto? userLevel,
  }) {
    return UserDto(
      acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt ?? this.acceptedPrivacyAndTermsAt,
      addressCity: addressCity ?? this.addressCity,
      addressPostalCode: addressPostalCode ?? this.addressPostalCode,
      addressStreet: addressStreet ?? this.addressStreet,
      addressStreetNumber: addressStreetNumber ?? this.addressStreetNumber,
      addressStreetNumberAddition: addressStreetNumberAddition ?? this.addressStreetNumberAddition,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      geoPoint: geoPoint ?? this.geoPoint,
      id: id,
      createdAt: createdAt,
      updatedAt: gNow,
      trialEnd: trialEnd ?? this.trialEnd,
      tags: tags ?? this.tags,
      userLevel: userLevel ?? this.userLevel,
    );
  }
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class UpdateUserDtoRequest extends Writeable {
  UpdateUserDtoRequest({
    this.acceptedPrivacyAndTermsAt,
  });

  @TimestampConverter()
  final DateTime? acceptedPrivacyAndTermsAt;

  static const fromJsonFactory = _$UpdateUserDtoRequestFromJson;
  factory UpdateUserDtoRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDtoRequestFromJson(json);
  static const toJsonFactory = _$UpdateUserDtoRequestToJson;
  @override
  Map<String, dynamic> toJson() => _$UpdateUserDtoRequestToJson(this);
}
