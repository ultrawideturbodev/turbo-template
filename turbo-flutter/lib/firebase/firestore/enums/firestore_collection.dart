import 'package:turbo_template/data/constants/k_keys.dart';
import 'package:turbo_template/auth/dtos/user_dto.dart';
import 'package:turbo_template/auth/dtos/user_profile_dto.dart';
import 'package:turbo_template/auth/dtos/username_dto.dart';
import 'package:turbo_template/auth/services/user_service.dart';
import 'package:turbo_template/settings/dtos/settings_dto.dart';
import 'package:turbo_template/settings/services/settings_service.dart';

enum FirestoreCollection {
  userProfiles,
  users,
  usernames,
  settings,
  ;

  bool get tryAddLocalDocumentReference {
    switch (this) {
      case FirestoreCollection.usernames:
        return true;
      case FirestoreCollection.users:
      case FirestoreCollection.userProfiles:
      case FirestoreCollection.settings:
        return false;
    }
  }

  bool get isCollectionGroup {
    switch (this) {
      case FirestoreCollection.users:
      case FirestoreCollection.userProfiles:
      case FirestoreCollection.usernames:
      case FirestoreCollection.settings:
        return false;
    }
  }

  Map<String, dynamic> Function(T value)? toJson<T>() => switch (this) {
        FirestoreCollection.users => UserDto.toJsonFactory,
        FirestoreCollection.userProfiles => UserProfileDto.toJsonFactory,
        FirestoreCollection.usernames => UsernameDto.toJsonFactory,
        FirestoreCollection.settings => SettingsDto.toJsonFactory,
      } as Map<String, dynamic> Function(T value)?;

  T Function(Map<String, dynamic> json)? fromJson<T>() => switch (this) {
        FirestoreCollection.users => UserDto.fromJsonFactory,
        FirestoreCollection.userProfiles => UserProfileDto.fromJsonFactory,
        FirestoreCollection.usernames => UsernameDto.fromJsonFactory,
        FirestoreCollection.settings => SettingsDto.fromJsonFactory,
      } as T Function(Map<String, dynamic> json)?;

  String get collectionName {
    switch (this) {
      case FirestoreCollection.users:
      case FirestoreCollection.userProfiles:
      case FirestoreCollection.usernames:
      case FirestoreCollection.settings:
        return name;
    }
  }

  String get updatedFieldName {
    switch (this) {
      case FirestoreCollection.userProfiles:
      case FirestoreCollection.usernames:
      case FirestoreCollection.users:
      case FirestoreCollection.settings:
        return kKeysUpdatedAt;
    }
  }

  String get createdFieldName {
    switch (this) {
      case FirestoreCollection.userProfiles:
      case FirestoreCollection.usernames:
      case FirestoreCollection.users:
      case FirestoreCollection.settings:
        return kKeysCreatedAt;
    }
  }

  String get documentReferenceFieldName {
    switch (this) {
      case FirestoreCollection.users:
      case FirestoreCollection.userProfiles:
      case FirestoreCollection.usernames:
      case FirestoreCollection.settings:
        return kKeysDocumentReference;
    }
  }

  String get apiName {
    switch (this) {
      case FirestoreCollection.users:
        return 'UsersApi';
      case FirestoreCollection.userProfiles:
        return 'ProfilesApi';
      case FirestoreCollection.usernames:
        return 'UsernamesApi';
      case FirestoreCollection.settings:
        return 'SettingsApi';
    }
  }

  String path({
    String? userId,
  }) {
    switch (this) {
      case FirestoreCollection.users:
      case FirestoreCollection.userProfiles:
      case FirestoreCollection.usernames:
        return collectionName;
      case FirestoreCollection.settings:
        return '${FirestoreCollection.users.path()}/$userId/$collectionName';
    }
  }

  static Future<List> get isReady {
    final List<Future> futures = [];
    for (final collection in FirestoreCollection.values) {
      switch (collection) {
        case FirestoreCollection.userProfiles:
          break;
        case FirestoreCollection.users:
          futures.add(UserService.locate.isReady);
        case FirestoreCollection.usernames:
          break;
        case FirestoreCollection.settings:
          futures.add(SettingsService.locate.isReady);
          break;
      }
    }
    return Future.wait(futures);
  }
}
