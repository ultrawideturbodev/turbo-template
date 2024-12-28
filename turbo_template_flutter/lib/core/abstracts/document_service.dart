import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_api/cloud_firestore_api.dart';
import 'package:feedback_response/feedback_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/core/typedefs/lazy_locator.dart';
import 'package:turbo_template/features/auth/abstracts/auth_sync_service.dart';

import '../extensions/completer_extension.dart';
import 'writeable_id.dart';

/// An abstract class representing a service for managing a single document with a string ID.
///
/// This class extends [AuthSyncService] and includes [Loglytics] functionality.
/// It provides methods for synchronizing and managing a single document of type [T],
/// where [T] is a type that extends [WriteableId].
abstract class DocumentService<T extends WriteableId<String>, API extends FirestoreApi<T>>
    extends AuthSyncService<T> with Loglytics {
  DocumentService({
    required this.api,
  });
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final API api;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  @mustCallSuper
  Future<void> dispose() {
    _doc.dispose();
    _isReady.completeIfNotComplete();
    return super.dispose();
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  late final _doc =
      Informer<T?>(initialValueLocator?.call() ?? defaultValueLocator?.call(), forceUpdate: true);
  final _isReady = Completer();

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\

  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  LazyLocator<T>? initialValueLocator;
  LazyLocator<T>? defaultValueLocator;
  ValueChanged<T?>? beforeLocalNotifyUpdate;
  ValueChanged<T?>? afterLocalNotifyUpdate;

  Future get isReady => _isReady.future;
  Listenable get listenable => _doc;
  ValueListenable<T?> get doc => _doc;
  bool get hasDoc => _doc.value != null;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  @override
  void Function(T? value, User? user) get onData {
    return (value, user) {
      final doc = value;
      if (user != null) {
        log.debug('Updating doc for user ${user.uid}');
        upsertLocalDoc(doc: doc);
        _isReady.completeIfNotComplete();
        log.debug('Updated doc');
      } else {
        log.debug('User is null, clearing doc');
        upsertLocalDoc(doc: doc);
      }
    };
  }

  // ⚙️ LOCAL MUTATORS ------------------------------------------------------------------------ \\

  @protected
  void deleteLocalDoc({
    required T doc,
    bool doNotifyListeners = true,
  }) {
    log.debug('Deleting local doc with id: ${doc.id}');
    if (doNotifyListeners) {
      beforeLocalNotifyUpdate?.call(doc);
    }
    _doc.update(null, doNotifyListeners: doNotifyListeners);
    if (doNotifyListeners) {
      afterLocalNotifyUpdate?.call(doc);
    }
  }

  @protected
  void createLocalDoc({
    required T doc,
    bool doNotifyListeners = true,
  }) {
    log.debug('Creating local doc with id: ${doc.id}');
    if (doNotifyListeners) {
      beforeLocalNotifyUpdate?.call(doc);
    }
    _doc.update(doc, doNotifyListeners: doNotifyListeners);
    if (doNotifyListeners) {
      afterLocalNotifyUpdate?.call(doc);
    }
  }

  @protected
  void updateLocalDoc({
    required T doc,
    bool doNotifyListeners = true,
  }) {
    log.debug('Updating local doc with id: ${doc.id}');
    if (doNotifyListeners) {
      beforeLocalNotifyUpdate?.call(doc);
    }
    _doc.update(doc, doNotifyListeners: doNotifyListeners);
    if (doNotifyListeners) {
      afterLocalNotifyUpdate?.call(doc);
    }
  }

  @protected
  void upsertLocalDoc({
    required T? doc,
    bool doNotifyListeners = true,
  }) {
    final pDoc = doc ?? defaultValueLocator?.call();
    log.debug('Updating local doc with id: ${pDoc?.id}');
    if (doNotifyListeners) {
      beforeLocalNotifyUpdate?.call(pDoc);
    }
    _doc.update(pDoc, doNotifyListeners: doNotifyListeners);
    if (doNotifyListeners) {
      afterLocalNotifyUpdate?.call(pDoc);
    }
  }

  // 🕹️ LOCAL & REMOTE MUTATORS --------------------------------------------------------------- \\

  @protected
  Future<FeedbackResponse<DocumentReference>> upsertDoc({
    required T doc,
    Writeable Function(T doc)? remoteUpdateRequestBuilder,
    bool doNotifyListeners = true,
    Transaction? transaction,
  }) async {
    try {
      log.debug('Upserting doc with id: ${doc.id}');
      upsertLocalDoc(doc: doc, doNotifyListeners: doNotifyListeners);
      final future = api.createDoc(
        merge: true,
        writeable: doc.isLocalDefault ? doc : remoteUpdateRequestBuilder?.call(doc) ?? doc,
        id: doc.id,
        transaction: transaction,
      );
      tempBlockStreamUpdates(future);
      return await future;
    } catch (error, stackTrace) {
      log.error(
        '$error caught while upserting doc',
        error: error,
        stackTrace: stackTrace,
      );
      return FeedbackResponse.errorNone();
    }
  }

  @protected
  Future<FeedbackResponse<void>> deleteDoc({
    required T doc,
    bool doNotifyListeners = true,
  }) async {
    try {
      log.debug('Deleting doc with id: ${doc.id}');
      deleteLocalDoc(doc: doc, doNotifyListeners: doNotifyListeners);
      final future = api.deleteDoc(
        id: doc.id,
      );
      tempBlockStreamUpdates(future);
      return await future;
    } catch (error, stackTrace) {
      log.error(
        '$error caught while deleting doc',
        error: error,
        stackTrace: stackTrace,
      );
      return FeedbackResponse.errorNone();
    }
  }

  @protected
  Future<FeedbackResponse<DocumentReference>> updateDoc({
    required T doc,
    Writeable Function(T doc)? remoteUpdateRequestBuilder,
    bool doNotifyListeners = true,
    Transaction? transaction,
  }) async {
    try {
      log.debug('Updating doc with id: ${doc.id}');
      upsertLocalDoc(doc: doc, doNotifyListeners: doNotifyListeners);
      final future = api.updateDoc(
        writeable: remoteUpdateRequestBuilder?.call(doc) ?? doc,
        id: doc.id,
        transaction: transaction,
      );
      tempBlockStreamUpdates(future);
      return await future;
    } catch (error, stackTrace) {
      log.error(
        '$error caught while updating doc',
        error: error,
        stackTrace: stackTrace,
      );
      return FeedbackResponse.errorNone();
    }
  }

  @protected
  Future<FeedbackResponse<DocumentReference>> createDoc({
    required T doc,
    bool doNotifyListeners = true,
    Transaction? transaction,
  }) async {
    try {
      log.debug('Creating doc with id: ${doc.id}');
      upsertLocalDoc(doc: doc, doNotifyListeners: doNotifyListeners);
      final future = api.createDoc(
        writeable: doc,
        id: doc.id,
        transaction: transaction,
      );
      tempBlockStreamUpdates(future);
      return await future;
    } catch (error, stackTrace) {
      log.error(
        '$error caught while creating doc',
        error: error,
        stackTrace: stackTrace,
      );
      return FeedbackResponse.errorNone();
    }
  }
}
