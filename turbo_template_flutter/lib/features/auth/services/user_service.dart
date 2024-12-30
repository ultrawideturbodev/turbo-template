import 'dart:async';

import 'package:feedback_response/feedback_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/core/abstracts/document_service.dart';

import '../apis/users_api.dart';
import '../dtos/user_dto.dart';

class UserService extends DocumentService<UserDto, UsersApi> with Loglytics {
  UserService() : super(api: UsersApi.locate);

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static UserService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(UserService.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  DateTime? get acceptedPrivacyAndTermsAt => doc.value?.acceptedPrivacyAndTermsAt;
  String? get email => doc.value?.email;
  ValueListenable<UserDto?> get userDto => doc;

  @override
  FutureOr<Stream<UserDto?>> Function(User user) get stream =>
      (user) => api.findDocStreamWithConverter(id: user.uid);

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\

  Future<FeedbackResponse> updateAcceptedPrivacy({
    required DateTime acceptedPrivacyAndTermsAt,
  }) =>
      updateDoc(
        doc: (current) => current!.copyWith(
          acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt,
        ),
      );

  Future<FeedbackResponse> createUser({
    required String userId,
    required String email,
    required DateTime? acceptedPrivacyAndTermsAt,
    required DateTime? trialEnd,
  }) =>
      createDoc(
        doc: UserDto.defaultValue(
          userId: userId,
          email: email,
          acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt,
          trialEnd: trialEnd,
        ),
      );
}
