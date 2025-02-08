import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_template/firebase/firestore/converters/duration_days_converter.dart';
import 'package:turbo_template/firebase/firestore/converters/timestamp_converter.dart';
import 'package:turbo_template/data/globals/g_now.dart';

import '../enums/user_level.dart';

part 'user_level_dto.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class UserLevelDto {
  UserLevelDto({
    required this.startedAt,
    required this.updatedAt,
    required this.updatedBy,
    required this.userLevel,
    required this.userLevelDurationInDays,
  });

  factory UserLevelDto.defaultValue({required String userId}) {
    final now = gNow;
    return UserLevelDto(
      startedAt: now,
      updatedAt: now,
      updatedBy: userId,
      userLevel: UserLevel.free,
      userLevelDurationInDays: null,
    );
  }

  @TimestampConverter()
  final DateTime startedAt;
  @TimestampConverter()
  final DateTime updatedAt;
  final String updatedBy;
  final UserLevel userLevel;
  @DurationDaysConverter()
  final Duration? userLevelDurationInDays;

  static const fromJsonFactory = _$UserLevelDtoFromJson;
  factory UserLevelDto.fromJson(Map<String, dynamic> json) => _$UserLevelDtoFromJson(json);
  static const toJsonFactory = _$UserLevelDtoToJson;
  Map<String, dynamic> toJson() => _$UserLevelDtoToJson(this);

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  bool get isExpired =>
      userLevelDurationInDays != null && startedAt.add(userLevelDurationInDays!).isBefore(gNow);
}
