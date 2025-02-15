// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalStorageDto _$LocalStorageDtoFromJson(Map<String, dynamic> json) =>
    LocalStorageDto(
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      navigationTab: $enumDecode(_$NavigationTabEnumMap, json['navigationTab']),
      didHappen: (json['didHappen'] as List<dynamic>)
          .map((e) => $enumDecode(_$AuthStepEnumMap, e))
          .toList(),
      supportedLanguage:
          $enumDecode(_$SupportedLanguageEnumMap, json['supportedLanguage']),
      turboThemeMode: $enumDecode(_$TThemeModeEnumMap, json['turboThemeMode']),
      turboTheme: $enumDecode(_$TThemeEnumMap, json['turboTheme']),
    );

Map<String, dynamic> _$LocalStorageDtoToJson(LocalStorageDto instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'didHappen':
          instance.didHappen.map((e) => _$AuthStepEnumMap[e]!).toList(),
      'navigationTab': _$NavigationTabEnumMap[instance.navigationTab]!,
      'supportedLanguage':
          _$SupportedLanguageEnumMap[instance.supportedLanguage]!,
      'turboThemeMode': _$TThemeModeEnumMap[instance.turboThemeMode]!,
      'turboTheme': _$TThemeEnumMap[instance.turboTheme]!,
    };

const _$NavigationTabEnumMap = {
  NavigationTab.home: 'home',
  NavigationTab.placeholder: 'placeholder',
};

const _$AuthStepEnumMap = {
  AuthStep.createUserDoc: 'createUserDoc',
  AuthStep.acceptPrivacy: 'acceptPrivacy',
  AuthStep.createSettingsDoc: 'createSettingsDoc',
  AuthStep.createUsernameDoc: 'createUsernameDoc',
  AuthStep.createProfileDoc: 'createProfileDoc',
  AuthStep.verifyEmail: 'verifyEmail',
};

const _$SupportedLanguageEnumMap = {
  SupportedLanguage.nl: 'nl',
  SupportedLanguage.en: 'en',
};

const _$TThemeModeEnumMap = {
  TThemeMode.dark: 'dark',
  TThemeMode.light: 'light',
};

const _$TThemeEnumMap = {
  TTheme.blue: 'blue',
  TTheme.violet: 'violet',
  TTheme.zinc: 'zinc',
};
