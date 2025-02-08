import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_firestore_api/abstracts/turbo_writeable.dart';
import 'package:turbo_firestore_api/abstracts/turbo_writeable_id.dart';
import 'package:turbo_firestore_api/models/turbo_auth_vars.dart';
import 'package:turbo_template/auth/dtos/user_level_dto.dart';
import 'package:turbo_template/firebase/firestore/converters/geo_point_converter.dart';
import 'package:turbo_template/firebase/firestore/converters/timestamp_converter.dart';
import 'package:turbo_template/data/globals/g_now.dart';

part 'user_dto.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class UserDto extends TurboWriteableId<String> {
  UserDto({
    required this.id,
    required this.acceptedPrivacyAndTermsAt,
    required this.addressCity,
    required this.addressPostalCode,
    required this.addressStreet,
    required this.addressStreetNumber,
    required this.addressStreetNumberAddition,
    required this.createdAt,
    required this.email,
    required this.phone,
    required this.geoPoint,
    required this.updatedAt,
    required this.trialEnd,
    required this.tags,
    required this.userLevel,
  });

  factory UserDto.create({
    required TurboAuthVars vars,
    required String email,
    DateTime? acceptedPrivacyAndTermsAt,
    DateTime? trialEnd,
  }) =>
      UserDto(
        acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt,
        id: vars.userId,
        updatedAt: vars.now,
        createdAt: vars.now,
        email: email,
        trialEnd: trialEnd,
        tags: [],
        userLevel: UserLevelDto.defaultValue(userId: vars.userId),
        addressCity: null,
        addressPostalCode: null,
        addressStreet: null,
        addressStreetNumber: null,
        addressStreetNumberAddition: null,
        geoPoint: null,
        phone: null,
      );

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

  @override
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
    DateTime? updatedAt,
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
class UpdateUserDtoRequest extends TurboWriteable {
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
