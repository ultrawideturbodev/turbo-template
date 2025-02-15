import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:loglytics/loglytics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turbo_firestore_api/extensions/completer_extension.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/auth/enums/auth_step.dart';
import 'package:turbo_template/auth/services/auth_service.dart';
import 'package:turbo_template/data/enums/hive_adapters.dart';
import 'package:turbo_template/data/globals/g_meta_vars.dart';
import 'package:turbo_template/data/globals/g_user_id.dart';
import 'package:turbo_template/local_storage/dtos/local_storage_dto.dart';
import 'package:turbo_template/local_storage/enums/box_type.dart';
import 'package:turbo_template/localizations/enums/supported_language.dart';
import 'package:turbo_template/routing/enums/navigation_tab.dart';
import 'package:turbo_template/state/annotations/called_by_mutex.dart';
import 'package:turbo_template/state/typedefs/update_current_def.dart';
import 'package:turbo_template/state/utils/mutex.dart';
import 'package:turbo_template/ui/enums/t_theme.dart';
import 'package:turbo_template/ui/enums/t_theme_mode.dart';

class LocalStorageService with Loglytics {
  LocalStorageService() {
    _initialise();
  }

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static LocalStorageService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(
        LocalStorageService.new,
        dispose: (param) async => await param.dispose(),
      );

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  Future<void> _initialise() async {
    await _mutex.lockAndRun(
      run: (unlock) async {
        try {
          final _authService = AuthService.locate;
          await _authService.isReady;
          log.debug('AuthService is ready');
          await _tryInitDirAndAdapters();
        } catch (error, stackTrace) {
          log.error(
            'Exception caught while initialising hive service',
            error: error,
            stackTrace: stackTrace,
          );
        } finally {
          _isReady.completeIfNotComplete();
          unlock();
        }
      },
    );
  }

  Future<void> dispose() async {
    _isReady.completeIfNotComplete();
    _isReady = Completer();
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  var _isReady = Completer();
  final Map<String, Box> _boxes = {};

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  final _mutex = Mutex();

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  Future get isReady => _isReady.future;
  LocalStorageDto get _localStorageDto =>
      _getBoxContent(
        hiveBox: BoxType.localStorageDto,
        userId: gUserId,
      ) ??
      LocalStorageDto.create(vars: gMetaVars);

  NavigationTab get navigationTab => _localStorageDto.navigationTab;

  bool didHappen({required AuthStep authStep}) => _localStorageDto.didHappen.contains(authStep);
  bool didNotHappen({required AuthStep authStep}) => !didHappen(authStep: authStep);

  SupportedLanguage get language => _localStorageDto.supportedLanguage;

  // 🏗 HELPERS ------------------------------------------------------------------------------- \\

  FutureOr<Box<T>> _getBox<T>({
    required BoxType hiveBox,
    required String userId,
  }) async {
    log.debug('Getting box: ${hiveBox.id}');
    if (_hasBox(hiveBox: hiveBox)) {
      log.debug('Box ${hiveBox.id} already exists, returning');
      return _forceGetBox<T>(hiveBox: hiveBox);
    }
    log.debug('Initializing box: ${hiveBox.id}');
    final box = await _initBox<T>(hiveBox: hiveBox, userId: userId);
    return box;
  }

  Future<Box<T>> _initBox<T>({required BoxType hiveBox, required String userId}) async {
    log.debug('Initializing box: ${hiveBox.id}');
    final box = await _openBox<T>(hiveBox: hiveBox);
    _addBoxInMemory(hiveBox: hiveBox, box: box);
    return box;
  }

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  bool _hasBox({required BoxType hiveBox}) => _boxes.containsKey(hiveBox.id);
  Box<T> _forceGetBox<T>({required BoxType hiveBox}) => _boxes[hiveBox.id] as Box<T>;

  Future<Box<T>> _openBox<T>({required BoxType hiveBox}) async {
    log.debug('Opening box: ${hiveBox.id}');
    return await Hive.openBox<T>(
      hiveBox.id,
    );
  }

  void _addBoxInMemory<T>({
    required BoxType hiveBox,
    required Box<T> box,
  }) {
    log.debug('Adding box to memory: ${hiveBox.id}');
    _boxes[hiveBox.id] = box;
  }

  T? _getBoxContent<T>({
    required BoxType hiveBox,
    required String userId,
  }) {
    log.debug('Getting box content: ${hiveBox.id}, id: $userId');
    if (!_hasBox(hiveBox: hiveBox)) {
      log.debug('Box content not found: ${hiveBox.id}, id: $userId');
      return null;
    }
    final source = _forceGetBox(hiveBox: hiveBox).get(
      hiveBox.documentId(id: userId),
    );
    return source;
  }

  Future<void> _updateBoxContent<T>({
    required BoxType hiveBox,
    required T value,
    required String userId,
  }) async {
    log.debug('Updating box content: ${hiveBox.id}, id: $userId');
    final box = await _getBox(hiveBox: hiveBox, userId: userId);
    await box.put(
      hiveBox.documentId(id: userId),
      value,
    );
  }

  @CalledByMutex()
  Future<void> _tryInitDirAndAdapters() async {
    try {
      log.debug('Initializing Hive directory and adapters');
      if (!kIsWeb) {
        Hive.init((await getApplicationDocumentsDirectory()).path);
      }
      _registerAdapters();
    } catch (error, stackTrace) {
      log.error(
        'Unexpected ${error.runtimeType} caught while initialising hive box',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @CalledByMutex()
  void _registerAdapters() {
    log.debug('Registering Hive adapters');
    for (final hiveAdapter in HiveAdapters.values) {
      hiveAdapter.registerAdapter();
    }
  }

  Future<void> _updateLocalStorage(
    UpdateCurrentDef<LocalStorageDto> dtoUpdater, {
    required String userId,
  }) async {
    log.info('Updating local device settings');
    try {
      const hiveBox = BoxType.localStorageDto;
      final newValue = dtoUpdater(_localStorageDto);
      await _updateBoxContent(hiveBox: hiveBox, value: newValue, userId: userId);
    } catch (error, stackTrace) {
      log.error(
        '$error caught while updating local device settings',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

// 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<TurboResponse> updateAuthStepHappened({
    required AuthStep authStep,
    bool didHappen = true,
  }) async {
    try {
      log.info('Updating auth step happened: $authStep : $didHappen');
      await _updateLocalStorage(
        userId: gUserId,
        (current) => current.copyWith(
          didHappen: (current) => switch (didHappen) {
            true => current..add(authStep),
            false => current..remove(authStep),
          }
              .toSet()
              .toList(),
        ),
      );
      return const TurboResponse.successAsBool();
    } catch (error, stackTrace) {
      log.error(
        '$error caught while updating auth step happened',
        error: error,
        stackTrace: stackTrace,
      );
      return const TurboResponse.failAsBool();
    }
  }

  Future<TurboResponse> updateNavigationTab({
    required NavigationTab navigationTab,
  }) async {
    try {
      log.info('Updating navigation tab: $navigationTab');
      await _updateLocalStorage(
        (current) => current.copyWith(navigationTab: navigationTab),
        userId: gUserId,
      );
      return const TurboResponse.successAsBool();
    } catch (error, stackTrace) {
      log.error(
        '$error caught while updating navigation tab',
        error: error,
        stackTrace: stackTrace,
      );
      return const TurboResponse.failAsBool();
    }
  }

  Future<TurboResponse> updateLanguage({
    required SupportedLanguage language,
  }) async {
    try {
      log.info('Updating language: $language');
      await _updateLocalStorage(
        (current) => current.copyWith(supportedLanguage: language),
        userId: gUserId,
      );
      return const TurboResponse.successAsBool();
    } catch (error, stackTrace) {
      log.error(
        '$error caught while updating language',
        error: error,
        stackTrace: stackTrace,
      );
      return const TurboResponse.failAsBool();
    }
  }

  Future<TurboResponse> updateTheme({
    required TTheme theme,
  }) async {
    try {
      log.info('Updating theme: $theme');
      await _updateLocalStorage(
        (current) => current.copyWith(turboTheme: theme),
        userId: gUserId,
      );
      return const TurboResponse.successAsBool();
    } catch (error, stackTrace) {
      log.error(
        '$error caught while updating theme',
        error: error,
        stackTrace: stackTrace,
      );
      return const TurboResponse.failAsBool();
    }
  }

  Future<TurboResponse> updateThemeMode({
    required TThemeMode themeMode,
  }) async {
    try {
      log.info('Updating theme mode: $themeMode');
      await _updateLocalStorage(
        (current) => current.copyWith(turboThemeMode: themeMode),
        userId: gUserId,
      );
      return const TurboResponse.successAsBool();
    } catch (error, stackTrace) {
      log.error(
        '$error caught while updating theme mode',
        error: error,
        stackTrace: stackTrace,
      );
      return const TurboResponse.failAsBool();
    }
  }
}
