import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_template/data/abstracts/has_id.dart';
import 'package:turbo_template/firebase/firestore/converters/timestamp_converter.dart';
import 'package:turbo_template/data/enums/gender.dart';
import 'package:turbo_template/data/globals/g_now.dart';
import 'package:turbo_template/data/globals/g_user_id.dart';

part 'user_profile_dto.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class UserProfileDto extends HasId {
  UserProfileDto({
    required this.id,
    required this.bio,
    required this.birthDate,
    required this.createdAt,
    required this.name,
    required this.imageUrl,
    required this.userId,
    required this.updatedAt,
    required this.gender,
    required this.username,
  });

  factory UserProfileDto.defaultValue({
    required String userId,
    required String username,
  }) {
    final now = gNow;
    return UserProfileDto(
      id: userId,
      userId: userId,
      createdAt: now,
      updatedAt: now,
      name: null,
      bio: null,
      birthDate: null,
      imageUrl: null,
      gender: null,
      username: username,
    );
  }

  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  final String id;

  final String userId;
  final String? bio;
  final String? imageUrl;
  final String? name;
  final String? username;
  final int? birthDate;
  final Gender? gender;

  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;

  static const fromJsonFactory = _$UserProfileDtoFromJson;
  factory UserProfileDto.fromJson(Map<String, dynamic> json) => _$UserProfileDtoFromJson(json);
  static const toJsonFactory = _$UserProfileDtoToJson;
  Map<String, dynamic> toJson() => _$UserProfileDtoToJson(this);
}

extension UserProfileDtoExtension on UserProfileDto {
  String get nameLabel => name ?? username ?? 'Turbo Doe';
  bool get isSelf => gUserId == id;
}
