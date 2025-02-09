import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_template/auth/enums/auth_step.dart';
import 'package:turbo_template/data/globals/g_now.dart';
import 'package:turbo_template/data/models/turbo_meta_vars.dart';
import 'package:turbo_template/localizations/enums/supported_language.dart';
import 'package:turbo_template/routing/enums/navigation_tab.dart';
import 'package:turbo_template/state/typedefs/update_current_def.dart';
import 'package:turbo_template/ui/enums/t_theme.dart';
import 'package:turbo_template/ui/enums/t_theme_mode.dart';

part 'local_storage_dto.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class LocalStorageDto {
  LocalStorageDto({
    required this.createdAt,
    required this.updatedAt,
    required this.navigationTab,
    required this.didHappen,
    required this.supportedLanguage,
    required this.turboThemeMode,
    required this.turboTheme,
  });

  factory LocalStorageDto.create({required TurboMetaVars vars}) => LocalStorageDto(
        createdAt: vars.now,
        updatedAt: vars.now,
        navigationTab: NavigationTab.defaultValue,
        didHappen: [],
        supportedLanguage: SupportedLanguage.defaultValue,
        turboThemeMode: TThemeMode.defaultValue,
        turboTheme: TTheme.defaultValue,
      );

  final DateTime createdAt;
  final DateTime updatedAt;
  final List<AuthStep> didHappen;
  final NavigationTab navigationTab;
  final SupportedLanguage supportedLanguage;
  final TThemeMode turboThemeMode;
  final TTheme turboTheme;

  LocalStorageDto copyWith({
    NavigationTab? navigationTab,
    UpdateCurrentDef<List<AuthStep>>? didHappen,
    DateTime? skippedVerifyEmailDate,
    TThemeMode? turboThemeMode,
    SupportedLanguage? supportedLanguage,
    TTheme? turboTheme,
  }) {
    return LocalStorageDto(
      createdAt: createdAt,
      updatedAt: gNow,
      navigationTab: navigationTab ?? this.navigationTab,
      didHappen: didHappen?.call(this.didHappen) ?? this.didHappen,
      supportedLanguage: supportedLanguage ?? this.supportedLanguage,
      turboThemeMode: turboThemeMode ?? this.turboThemeMode,
      turboTheme: turboTheme ?? this.turboTheme,
    );
  }

  @override
  String toString() {
    return 'LocalStorageDto{createdAt: $createdAt, updatedAt: $updatedAt, didHappen: $didHappen, navigationTab: $navigationTab, supportedLanguage: $supportedLanguage, turboThemeMode: $turboThemeMode, turboTheme: $turboTheme}';
  }

  static const fromJsonFactory = _$LocalStorageDtoFromJson;
  factory LocalStorageDto.fromJson(Map<String, dynamic> json) => _$LocalStorageDtoFromJson(json);
  static const toJsonFactory = _$LocalStorageDtoToJson;
  Map<String, dynamic> toJson() => _$LocalStorageDtoToJson(this);
}
