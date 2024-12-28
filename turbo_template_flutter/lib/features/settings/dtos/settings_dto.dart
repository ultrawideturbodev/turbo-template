import 'package:cloud_firestore_api/cloud_firestore_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_template/core/abstracts/writeable_id.dart';
import 'package:turbo_template/core/converters/timestamp_converter.dart';
import 'package:turbo_template/core/globals/g_now.dart';

part 'settings_dto.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class SettingsDto extends WriteableId<String> {
  SettingsDto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.skippedVerifyEmailDate,
    super.isLocalDefault,
  });

  factory SettingsDto.defaultDto({
    required String userId,
  }) {
    final now = gNow;
    return SettingsDto(
      userId: userId,
      id: userId,
      createdAt: now,
      updatedAt: now,
      skippedVerifyEmailDate: null,
      isLocalDefault: true,
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
class UpdateSettingsDtoRequest extends Writeable {
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
