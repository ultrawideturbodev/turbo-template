import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../abstracts/json_values.dart';
import '../enums/auth_step.dart';
import '../enums/navigation_tab.dart';
import '../enums/supported_language.dart';
import '../enums/supported_theme_mode.dart';
import '../globals/g_now.dart';
import '../globals/g_user_id.dart';
import '../typedefs/current_value_updater.dart';

part 'local_storage_dto.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class LocalStorageDto extends LocalStorageValue<LocalStorageDto> {
  LocalStorageDto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.hasAuth,
    required this.createdBy,
    required this.updatedBy,
    required this.language,
    required this.themeMode,
    required this.navigationTab,
    required this.didHappen,
    this.skippedVerifyEmailDate,
  });

  factory LocalStorageDto.defaultDto({required String userId}) {
    final now = gNow;
    return LocalStorageDto(
      id: userId,
      createdAt: now,
      updatedAt: now,
      hasAuth: false,
      createdBy: userId,
      updatedBy: userId,
      language: SupportedLanguage.defaultValue,
      themeMode: SupportedThemeMode.defaultValue,
      navigationTab: NavigationTab.defaultValue,
      didHappen: [],
    );
  }

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String updatedBy;

  final bool hasAuth;

  @JsonKey(defaultValue: [])
  final List<AuthStep> didHappen;

  @JsonKey(
    defaultValue: SupportedLanguage.defaultValue,
    unknownEnumValue: SupportedLanguage.defaultValue,
  )
  final SupportedLanguage language;
  @JsonKey(
    defaultValue: SupportedThemeMode.defaultValue,
    unknownEnumValue: SupportedThemeMode.defaultValue,
  )
  final SupportedThemeMode themeMode;
  @JsonKey(
    defaultValue: NavigationTab.defaultValue,
    unknownEnumValue: NavigationTab.defaultValue,
  )
  final NavigationTab navigationTab;

  final DateTime? skippedVerifyEmailDate;

  static const fromJsonFactory = _$LocalStorageDtoFromJson;
  factory LocalStorageDto.fromJson(Map<String, dynamic> json) => _$LocalStorageDtoFromJson(json);
  static const toJsonFactory = _$LocalStorageDtoToJson;

  @override
  Map<String, dynamic> toJson() => _$LocalStorageDtoToJson(this);

  LocalStorageDto copyWith({
    bool? hasAuth,
    SupportedLanguage? language,
    SupportedThemeMode? themeMode,
    NavigationTab? navigationTab,
    CurrentValueUpdater<List<AuthStep>>? didHappen,
    DateTime? skippedVerifyEmailDate,
  }) {
    return LocalStorageDto(
      id: id,
      createdAt: createdAt,
      hasAuth: hasAuth ?? this.hasAuth,
      createdBy: createdBy,
      updatedAt: gNow,
      updatedBy: gUserId,
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      navigationTab: navigationTab ?? this.navigationTab,
      didHappen: didHappen?.call(this.didHappen) ?? this.didHappen,
      skippedVerifyEmailDate: skippedVerifyEmailDate ?? this.skippedVerifyEmailDate,
    );
  }

  @override
  String toString() {
    return 'LocalStorageDto{'
        'id: $id, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'createdBy: $createdBy, '
        'updatedBy: $updatedBy, '
        'hasAuth: $hasAuth, '
        'didHappen: $didHappen, '
        'language: $language, '
        'themeMode: $themeMode, '
        'navigationTab: $navigationTab, '
        'skippedVerifyEmailDate: $skippedVerifyEmailDate}';
  }

  @override
  String get toJsonString => jsonEncode(toJson());
}
