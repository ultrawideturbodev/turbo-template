import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_firestore_api/abstracts/turbo_writeable.dart';
import 'package:turbo_firestore_api/abstracts/turbo_writeable_id.dart';
import 'package:turbo_firestore_api/models/turbo_auth_vars.dart';
import 'package:turbo_template/firebase/firestore/converters/timestamp_converter.dart';
import 'package:turbo_template/data/globals/g_now.dart';

part 'settings_dto.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class SettingsDto extends TurboWriteableId<String> {
  SettingsDto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.skippedVerifyEmailDate,
  });

  factory SettingsDto.create({
    required TurboAuthVars vars,
  }) {
    return SettingsDto(
      userId: vars.userId,
      id: vars.userId,
      createdAt: vars.now,
      updatedAt: vars.now,
      skippedVerifyEmailDate: null,
    );
  }

  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;
  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  final String id;
  final String userId;

  @TimestampConverter()
  final DateTime? skippedVerifyEmailDate;

  @override
  Map<String, dynamic> toJson() => _$SettingsDtoToJson(this);
  factory SettingsDto.fromJson(Map<String, dynamic> json) => _$SettingsDtoFromJson(json);
  static const fromJsonFactory = _$SettingsDtoFromJson;
  static const toJsonFactory = _$SettingsDtoToJson;

  SettingsDto copyWith({
    String? userId,
    DateTime? skippedVerifyEmailDate,
  }) =>
      SettingsDto(
        createdAt: createdAt,
        updatedAt: gNow,
        id: userId ?? id,
        userId: userId ?? this.userId,
        skippedVerifyEmailDate: skippedVerifyEmailDate ?? this.skippedVerifyEmailDate,
      );
}

extension SettingsDtoExtension on SettingsDto {
  UpdateSettingsDtoRequest get asUpdateSkippedVerifyEmailDateRequest => UpdateSettingsDtoRequest(
        skippedVerifyEmailDate: skippedVerifyEmailDate,
      );
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class UpdateSettingsDtoRequest extends TurboWriteable {
  UpdateSettingsDtoRequest({
    this.skippedVerifyEmailDate,
  });

  @TimestampConverter()
  final DateTime? skippedVerifyEmailDate;

  static const fromJsonFactory = _$UpdateSettingsDtoRequestFromJson;
  factory UpdateSettingsDtoRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateSettingsDtoRequestFromJson(json);
  static const toJsonFactory = _$UpdateSettingsDtoRequestToJson;
  @override
  Map<String, dynamic> toJson() => _$UpdateSettingsDtoRequestToJson(this);
}
