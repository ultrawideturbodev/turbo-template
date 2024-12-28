import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';

import '../../../core/extensions/completer_extension.dart';
import '../abstracts/auth_sync_service.dart';
import '../apis/users_api.dart';
import '../dtos/user_dto.dart';

class UserService extends AuthSyncService<UserDto?> with Loglytics {
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static UserService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(UserService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _usersApi = UsersApi.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  Completer _hasUser = Completer();
  final _isReady = Completer();
  final _userDto = Informer<UserDto?>(null);

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  DateTime? get acceptedPrivacyAndTermsAt => _userDto.value?.acceptedPrivacyAndTermsAt;
  Future get hasUser => _hasUser.future;
  Future<void> get isReady => _isReady.future;
  Listenable get listenable => _userDto;
  String? get email => _userDto.value?.email;
  ValueListenable<UserDto?> get userDto => _userDto;

  @override
  Stream<UserDto?> Function(User user) get stream =>
          (user) => _usersApi.findDocStreamWithConverter(id: user.uid);

  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  @override
  void Function(UserDto? value, User? user) get onData => (value, user) {
    final userDto = value;
    if (user != null) {
      _userDto.update(userDto);
      _hasUser.completeIfNotComplete();
    } else {
      _userDto.update(null);
      _hasUser = Completer();
    }
    _isReady.completeIfNotComplete();
  };

// 🏗️ HELPERS ------------------------------------------------------------------------------- \\
// 📍 LOCATOR ------------------------------------------------------------------------------- \\
}
