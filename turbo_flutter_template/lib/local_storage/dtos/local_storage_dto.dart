import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_template/turbo/enums/auth_step.dart';
import 'package:turbo_template/turbo/enums/navigation_tab.dart';
import 'package:turbo_template/turbo/enums/supported_language.dart';
import 'package:turbo_template/turbo/enums/turbo_theme_mode.dart';
import 'package:turbo_template/turbo/globals/g_now.dart';
import 'package:turbo_template/turbo/globals/g_user_id.dart';
import 'package:turbo_template/turbo/models/turbo_meta_vars.dart';
import 'package:turbo_template/turbo/typedefs/current_value_updater.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class LocalStorageDto {
  LocalStorageDto({
    required this.createdAt,
    required this.updatedAt,
    required this.navigationTab,
    required this.didHappen,
    required this.hasAuth,
    required this.supportedLanguage,
    required this.turboThemeMode,
  });

  factory LocalStorageDto.create({required TurboMetaVars vars}) => LocalStorageDto(
        createdAt: vars.now,
        updatedAt: vars.now,
        navigationTab: NavigationTab.defaultValue,
        didHappen: [],
        hasAuth: gHasAuth,
        supportedLanguage: SupportedLanguage.defaultValue,
        turboThemeMode: TurboThemeMode.defaultValue,
      );

  final DateTime createdAt;
  final DateTime updatedAt;
  final List<AuthStep> didHappen;
  final NavigationTab navigationTab;
  final bool hasAuth;
  final SupportedLanguage supportedLanguage;
  final TurboThemeMode turboThemeMode;

  LocalStorageDto copyWith({
    bool? hasAuth,
    NavigationTab? navigationTab,
    CurrentValueUpdater<List<AuthStep>>? didHappen,
    DateTime? skippedVerifyEmailDate,
    TurboThemeMode? turboThemeMode,
    SupportedLanguage? supportedLanguage,
  }) {
    return LocalStorageDto(
      createdAt: createdAt,
      updatedAt: gNow,
      navigationTab: navigationTab ?? this.navigationTab,
      didHappen: didHappen?.call(this.didHappen) ?? this.didHappen,
      hasAuth: hasAuth ?? this.hasAuth,
      supportedLanguage: supportedLanguage ?? this.supportedLanguage,
      turboThemeMode: turboThemeMode ?? this.turboThemeMode,
    );
  }

  @override
  String toString() {
    return 'LocalStorageDto{createdAt: $createdAt, updatedAt: $updatedAt, didHappen: $didHappen, navigationTab: $navigationTab, hasAuth: $hasAuth, supportedLanguage: $supportedLanguage, turboThemeMode: $turboThemeMode}';
  }
}
