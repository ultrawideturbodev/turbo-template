import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:loglytics/loglytics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turbo_template/core/abstracts/initialisable.dart';
import 'package:turbo_template/core/annotations/called_by_mutex.dart';
import 'package:turbo_template/core/constants/k_keys.dart';
import 'package:turbo_template/core/enums/auth_step.dart';
import 'package:turbo_template/core/enums/hive_adapters.dart';
import 'package:turbo_template/core/enums/navigation_tab.dart';
import 'package:turbo_template/core/globals/g_user_id.dart';
import 'package:turbo_template/core/typedefs/current_value_updater.dart';
import 'package:turbo_template/core/utils/mutex.dart';
import 'package:turbo_template/auth/services/auth_service.dart';
import 'package:turbo_template/local_storage/dtos/local_storage_dto.dart';
import 'package:turbo_template/local_storage/enums/box_type.dart';

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

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  final _mutex = Mutex();

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  LocalStorageDto get _localStorageDto => _getBoxContent(
        hiveBox: BoxType.localStorageDto,
        userId: gUserId,
      );

  NavigationTab get navigationTab => _localStorageDto.navigationTab;

  bool didHappen({required AuthStep authStep}) => _localStorageDto.didHappen.contains(authStep);
  bool didNotHappen({required AuthStep authStep}) => !didHappen(authStep: authStep);

  bool get hasAuth => _localStorageDto.hasAuth;

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

  bool _hasBox({required BoxType hiveBox}) => _boxes.containsKey(hiveBox.id);
  Box<T> _forceGetBox<T>({required BoxType hiveBox}) => _boxes[hiveBox.id] as Box<T>;

  Future<Box<T>> _openBox<T>({required BoxType hiveBox}) async {
    log.debug('Opening box: ${hiveBox.id}');
    return await Hive.openBox<T>(
      hiveBox.id,
      encryptionCipher: HiveAesCipher(await _encryptionKey),
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
    final source = _forceGetBox(hiveBox: hiveBox).get(
      hiveBox.documentId(id: userId),
    );
    if (source == null) {
      log.debug('Box content not found: ${hiveBox.id}, id: $userId');
      return null;
    }
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

  Future<void> updateHasAuth({
    required bool hasAuth,
  }) async {
    log.info('Updating has auth: $hasAuth');
    await _updateLocalStorage(
      (current) => current.copyWith(hasAuth: hasAuth),
      userId: gUserId,
    );
  }

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
