import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_template/core/enums/auth_step.dart';
import 'package:turbo_template/core/enums/navigation_tab.dart';
import 'package:turbo_template/core/enums/supported_language.dart';
import 'package:turbo_template/core/enums/supported_theme_mode.dart';
import 'package:turbo_template/core/globals/g_now.dart';
import 'package:turbo_template/core/globals/g_user_id.dart';
import 'package:turbo_template/core/models/turbo_meta_vars.dart';
import 'package:turbo_template/core/typedefs/current_value_updater.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class LocalStorageDto {
  LocalStorageDto({
    required this.createdAt,
    required this.updatedAt,
    required this.navigationTab,
    required this.didHappen,
    required this.hasAuth,
    required this.supportedLanguage,
    required this.supportedThemeMode,
  });

  factory LocalStorageDto.create({required TurboMetaVars vars}) => LocalStorageDto(
        createdAt: vars.now,
        updatedAt: vars.now,
        navigationTab: NavigationTab.defaultValue,
        didHappen: [],
        hasAuth: gHasAuth,
        supportedLanguage: SupportedLanguage.defaultValue,
        supportedThemeMode: SupportedThemeMode.defaultValue,
      );

  final DateTime createdAt;
  final DateTime updatedAt;
  final List<AuthStep> didHappen;
  final NavigationTab navigationTab;
  final bool hasAuth;
  final SupportedLanguage supportedLanguage;
  final SupportedThemeMode supportedThemeMode;

  LocalStorageDto copyWith({
    bool? hasAuth,
    NavigationTab? navigationTab,
    CurrentValueUpdater<List<AuthStep>>? didHappen,
    DateTime? skippedVerifyEmailDate,
    SupportedThemeMode? supportedThemeMode,
    SupportedLanguage? supportedLanguage,
  }) {
    return LocalStorageDto(
      createdAt: createdAt,
      updatedAt: gNow,
      navigationTab: navigationTab ?? this.navigationTab,
      didHappen: didHappen?.call(this.didHappen) ?? this.didHappen,
      hasAuth: hasAuth ?? this.hasAuth,
      supportedLanguage: supportedLanguage ?? this.supportedLanguage,
      supportedThemeMode: supportedThemeMode ?? this.supportedThemeMode,
    );
  }

  @override
  String toString() {
    return 'LocalStorageDto{createdAt: $createdAt, updatedAt: $updatedAt, didHappen: $didHappen, navigationTab: $navigationTab, hasAuth: $hasAuth, supportedLanguage: $supportedLanguage, supportedThemeMode: $supportedThemeMode}';
  }
}
