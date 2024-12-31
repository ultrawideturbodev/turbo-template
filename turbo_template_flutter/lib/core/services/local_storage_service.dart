import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turbo_template/core/abstracts/initialisable.dart';
import 'package:turbo_template/core/abstracts/json_values.dart';
import 'package:turbo_template/core/annotations/called_by_mutex.dart';
import 'package:turbo_template/core/constants/k_keys.dart';
import 'package:turbo_template/core/dtos/local_storage_dto.dart';
import 'package:turbo_template/core/enums/auth_step.dart';
import 'package:turbo_template/core/enums/hive_adapters.dart';
import 'package:turbo_template/core/enums/hive_box.dart';
import 'package:turbo_template/core/enums/navigation_tab.dart';
import 'package:turbo_template/core/enums/supported_language.dart';
import 'package:turbo_template/core/enums/supported_theme_mode.dart';
import 'package:turbo_template/core/extensions/future_extension.dart';
import 'package:turbo_template/core/globals/g_user_id.dart';
import 'package:turbo_template/core/typedefs/current_value_updater.dart';
import 'package:turbo_template/core/utils/mutex.dart';
import 'package:turbo_template/features/auth/services/auth_service.dart';

class LocalStorageService extends Initialisable with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static LocalStorageService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(LocalStorageService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> initialise() async {
    log.info('Initializing LocalStorageService');
    await _mutex.lockAndRun(
      run: (unlock) async {
        try {
          final _authService = AuthService.locate;
          await _authService.isReady;
          log.debug('AuthService is ready');
          await _tryInitDirAndAdapters();
          await _localStorageSanityCheck(userId: gUserId);
        } catch (error, stackTrace) {
          log.error(
            'Exception caught while initialising hive service',
            error: error,
            stackTrace: stackTrace,
          );
        } finally {
          super.initialise();
          unlock();
        }
      },
    );
  }

  @override
  Future<void> dispose() async {
    try {
      log.info('Disposing LocalStorageService');
      _localStorageDto.update(LocalStorageDto.defaultDto(userId: ''));
      await resetBoxes().withTimeout();
    } catch (error, stackTrace) {
      log.error(
        '$error caught while disposing LocalStorageService',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      super.dispose();
    }
  }

  Future<void> resetBoxes() async {
    log.info('Resetting boxes');
    await _mutex.lockAndRun(
      run: (unlock) async {
        try {
          for (final box in _boxes.values) {
            try {
              await box.clear();
              log.debug('Cleared box: ${box.name}');
            } catch (error, stackTrace) {
              log.error(
                '$error caught while clearing box',
                error: error,
                stackTrace: stackTrace,
              );
            }
          }
          _boxes.clear();
          log.debug('All boxes cleared');
        } catch (error, stackTrace) {
          log.error(
            'Exception caught while resetting boxes',
            error: error,
            stackTrace: stackTrace,
          );
        } finally {
          unlock();
        }
      },
    );
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  final Map<String, Box> _boxes = {};
  final _localStorageDto = Informer<LocalStorageDto>(LocalStorageDto.defaultDto(userId: gUserId));

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  final _mutex = Mutex();

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  LocalStorageDto? _fetchLocalStorageDto({required String userId}) {
    final rLocalStorage = _getBoxContent(
      hiveBox: HiveBox.localStorageDto,
      userId: userId,
    );
    return rLocalStorage == null ? null : LocalStorageDto.fromJson(rLocalStorage);
  }

  NavigationTab get navigationTab => _localStorageDto.value.navigationTab;
  SupportedLanguage get language => _localStorageDto.value.language;
  SupportedThemeMode get themeMode => _localStorageDto.value.themeMode;

  ValueListenable<LocalStorageDto> get localStorageDto => _localStorageDto;

  bool didHappen({required AuthStep authStep}) =>
      _localStorageDto.value.didHappen.contains(authStep);
  bool didNotHappen({required AuthStep authStep}) => !didHappen(authStep: authStep);
  bool get hasAuth => _localStorageDto.value.hasAuth;

  // 🏗 HELPERS ------------------------------------------------------------------------------- \\

  Future<void> _localStorageSanityCheck({required String userId}) async {
    final localStorageDto = _localStorageDto.value;
    if (localStorageDto.id != userId) {
      log.debug('Local doc is not from user, fetching from box');
      final hasLocalStorage = _hasBox(hiveBox: HiveBox.localStorageDto);
      final localStorageDto = hasLocalStorage ? _fetchLocalStorageDto(userId: userId) : null;
      if (localStorageDto == null) {
        log.debug('Local doc not found in box, creating new default');
        await _updateLocalStorage(
          (current) => LocalStorageDto.defaultDto(userId: userId),
          userId: userId,
          doSanityCheck: false,
          doAssertInitialised: false,
        );
      } else {
        log.debug('Local doc found in box, updating');
        _localStorageDto.update(localStorageDto);
      }
    }
  }

  FutureOr<Box<T>> _getBox<T>({
    required HiveBox hiveBox,
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

  Future<Box<T>> _initBox<T>({required HiveBox hiveBox, required String userId}) async {
    log.debug('Initializing box: ${hiveBox.id}');
    final box = await _openBox<T>(hiveBox: hiveBox);
    _addBoxInMemory(hiveBox: hiveBox, box: box);
    switch (hiveBox) {
      case HiveBox.localStorageDto:
        try {
          log.debug('Updating local device settings from box');
          final rLocalStorage = _getBoxContent(hiveBox: hiveBox, userId: userId);
          if (rLocalStorage != null) {
            _localStorageDto.update(LocalStorageDto.fromJson(rLocalStorage));
          }
        } catch (error, stackTrace) {
          log.error(
            '$error caught while updating local device settings from box',
            error: error,
            stackTrace: stackTrace,
          );
        }
    }
    return box;
  }

  Future<List<int>> get _encryptionKey async {
    log.debug('Getting encryption key');
    final encryptionKeyEncoded = await _flutterSecureStorage.read(
      key: kKeysHiveEncryptionKey,
    );
    if (encryptionKeyEncoded == null) {
      log.debug('Generating new encryption key');
      final encryptionKey = Hive.generateSecureKey();
      await _flutterSecureStorage.write(
        key: kKeysHiveEncryptionKey,
        value: base64UrlEncode(encryptionKey),
      );
      return encryptionKey;
    } else {
      log.debug('Using existing encryption key');
      return base64Url.decode(encryptionKeyEncoded);
    }
  }

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  bool _hasBox({required HiveBox hiveBox}) => _boxes.containsKey(hiveBox.id);
  Box<T> _forceGetBox<T>({required HiveBox hiveBox}) => _boxes[hiveBox.id] as Box<T>;

  Future<Box<T>> _openBox<T>({required HiveBox hiveBox}) async {
    log.debug('Opening box: ${hiveBox.id}');
    return await Hive.openBox<T>(
      hiveBox.id,
      encryptionCipher: HiveAesCipher(await _encryptionKey),
    );
  }

  void _addBoxInMemory<T>({
    required HiveBox hiveBox,
    required Box<T> box,
  }) {
    log.debug('Adding box to memory: ${hiveBox.id}');
    _boxes[hiveBox.id] = box;
  }

  Map<String, dynamic>? _getBoxContent({
    required HiveBox hiveBox,
    required String userId,
  }) {
    log.debug('Getting box content: ${hiveBox.id}, id: $userId');
    final source = _forceGetBox(hiveBox: hiveBox).get(
      hiveBox.documentId(id: userId),
    );
    if (source == null) {
      log.debug('Box content not found: ${hiveBox.id}, id: $userId');
      return null;
    }
    return jsonDecode(
      source,
    );
  }

  Future<void> _updateBoxContent<T extends LocalStorageValue>({
    required HiveBox hiveBox,
    required T value,
    required String userId,
  }) async {
    log.debug('Updating box content: ${hiveBox.id}, id: $userId');
    final box = await _getBox(hiveBox: hiveBox, userId: userId);
    await box.put(
      hiveBox.documentId(id: userId),
      value.toJsonString,
    );
  }

  @CalledByMutex()
  Future<void> _tryInitDirAndAdapters() async {
    try {
      log.debug('Initializing Hive directory and adapters');
      Hive.init(kIsWeb ? null : (await getApplicationDocumentsDirectory()).path);
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
      if (!Hive.isAdapterRegistered(hiveAdapter.index)) {
        log.debug('Registering adapter: ${hiveAdapter.name}');
        hiveAdapter.registerAdapter();
      }
    }
  }

  Future<void> _updateLocalStorage(
    CurrentValueUpdater<LocalStorageDto> dtoUpdater, {
    required String userId,
    bool doSanityCheck = true,
    bool doAssertInitialised = true,
  }) async {
    if (doAssertInitialised) {
      assertInitialised();
    }
    if (doSanityCheck) {
      await _localStorageSanityCheck(userId: userId);
    }
    log.info('Updating local device settings');
    try {
      const hiveBox = HiveBox.localStorageDto;
      final newValue = dtoUpdater(_localStorageDto.value);
      _localStorageDto.update(newValue);
      unawaited(_updateBoxContent(hiveBox: hiveBox, value: newValue, userId: userId));
    } catch (error, stackTrace) {
      log.error(
        '$error caught while updating local device settings',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

// 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<void> updateAuthStepHappened({
    required AuthStep authStep,
    bool didHappen = true,
  }) async {
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
  }

  Future<void> updateLanguage({
    required SupportedLanguage language,
  }) async {
    log.info('Updating language: $language');
    await _updateLocalStorage(
      (current) => current.copyWith(language: language),
      userId: gUserId,
    );
  }

  Future<void> updateThemeMode({
    required SupportedThemeMode themeMode,
  }) async {
    log.info('Updating theme mode: $themeMode');
    await _updateLocalStorage(
      (current) => current.copyWith(themeMode: themeMode),
      userId: gUserId,
    );
  }

  Future<void> updateHasAuth({
    required bool hasAuth,
  }) async {
    await isReady;
    log.info('Updating has auth: $hasAuth');
    await _updateLocalStorage(
      (current) => current.copyWith(hasAuth: hasAuth),
      userId: gUserId,
    );
  }

  Future<void> updateNavigationTab({
    required NavigationTab navigationTab,
  }) async {
    log.info('Updating navigation tab: $navigationTab');
    await _updateLocalStorage(
      (current) => current.copyWith(navigationTab: navigationTab),
      userId: gUserId,
    );
  }
}
