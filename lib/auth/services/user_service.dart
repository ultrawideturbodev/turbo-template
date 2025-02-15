import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_firestore_api/apis/turbo_firestore_api.dart';
import 'package:turbo_firestore_api/services/turbo_document_service.dart';
import 'package:turbo_firestore_api/turbo_firestore_api.dart';
import 'package:turbo_response/turbo_response.dart';
import 'package:turbo_template/auth/apis/users_api.dart';
import 'package:turbo_template/auth/dtos/user_dto.dart';
import 'package:turbo_template/auth/requests/create_user_request.dart';

class UserService extends TurboDocumentService<UserDto, UsersApi> with Loglytics {
  UserService()
      : super(
          api: UsersApi.locate,
        );

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static UserService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(
        UserService.new,
        dispose: (param) async => await param.dispose(),
      );

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\

  @override
  Stream<UserDto?> Function(User user) get stream =>
      (user) => api.streamDocByIdWithConverter(id: user.uid);

  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  DateTime? get acceptedPrivacyAndTermsAt => doc.value?.acceptedPrivacyAndTermsAt;
  String? get email => doc.value?.email;
  ValueListenable<UserDto?> get userDto => doc;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<TurboResponse> createUser({
    required CreateDocDef<UserDto> doc,
  }) async =>
      createDoc(
        doc: doc,
      );

  Future<TurboResponse> updateAcceptedPrivacyAndTermsAt({
    required DateTime acceptedPrivacyAndTermsAt,
  }) async {
    return updateDoc(
      id: id!,
      doc: (current, vars) => current!.copyWith(
        acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt,
      ),
      remoteUpdateRequestBuilder: (doc) => UpdateUserDtoRequest(
        acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt,
      ),
    );
  }
}
