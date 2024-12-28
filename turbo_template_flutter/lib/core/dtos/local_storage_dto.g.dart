// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalStorageDto _$LocalStorageDtoFromJson(Map<String, dynamic> json) =>
    LocalStorageDto(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      hasAuth: json['hasAuth'] as bool,
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      language: $enumDecodeNullable(
              _$SupportedLanguageEnumMap, json['language'],
              unknownValue: SupportedLanguage.en) ??
          SupportedLanguage.en,
      themeMode: $enumDecodeNullable(
              _$SupportedThemeModeEnumMap, json['themeMode'],
              unknownValue: SupportedThemeMode.light) ??
          SupportedThemeMode.light,
      navigationTab: $enumDecodeNullable(
              _$NavigationTabEnumMap, json['navigationTab'],
              unknownValue: NavigationTab.home) ??
          NavigationTab.home,
      didHappen: (json['didHappen'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$AuthStepEnumMap, e))
              .toList() ??
          [],
      skippedVerifyEmailDate: json['skippedVerifyEmailDate'] == null
          ? null
          : DateTime.parse(json['skippedVerifyEmailDate'] as String),
    );

Map<String, dynamic> _$LocalStorageDtoToJson(LocalStorageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'hasAuth': instance.hasAuth,
      'didHappen':
          instance.didHappen.map((e) => _$AuthStepEnumMap[e]!).toList(),
      'language': _$SupportedLanguageEnumMap[instance.language]!,
      'themeMode': _$SupportedThemeModeEnumMap[instance.themeMode]!,
      'navigationTab': _$NavigationTabEnumMap[instance.navigationTab]!,
      'skippedVerifyEmailDate':
          instance.skippedVerifyEmailDate?.toIso8601String(),
    };

const _$SupportedLanguageEnumMap = {
  SupportedLanguage.nl: 'nl',
  SupportedLanguage.en: 'en',
};

const _$SupportedThemeModeEnumMap = {
  SupportedThemeMode.dark: 'dark',
  SupportedThemeMode.light: 'light',
};

const _$NavigationTabEnumMap = {
  NavigationTab.home: 'home',
};

const _$AuthStepEnumMap = {
  AuthStep.createUserDoc: 'createUserDoc',
  AuthStep.acceptPrivacy: 'acceptPrivacy',
  AuthStep.createSettingsDoc: 'createSettingsDoc',
  AuthStep.createUsernameDoc: 'createUsernameDoc',
  AuthStep.createProfileDoc: 'createProfileDoc',
  AuthStep.verifyEmail: 'verifyEmail',
};
