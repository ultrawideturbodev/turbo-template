import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_api/cloud_firestore_api.dart';
import 'package:feedback_response/feedback_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:informers/informer.dart';
import 'package:loglytics/loglytics.dart';
import 'package:turbo_template/core/abstracts/tu_api.dart';
import 'package:turbo_template/core/abstracts/writeable_id.dart';
import 'package:turbo_template/core/extensions/completer_extension.dart';
import 'package:turbo_template/core/extensions/list_extension.dart';
import 'package:turbo_template/features/auth/abstracts/auth_sync_service.dart';

abstract class BeforeAndAfterCollectionService<T extends WriteableId<String>, API extends TuApi<T>>
    extends CollectionService<T, API> {
  BeforeAndAfterCollectionService({required super.api});

  void beforeSyncNotifyUpdate(List<T> docs);
  void afterSyncNotifyUpdate(List<T> docs);

  @override
  void Function(List<T>? value, User? user) get onData {
    return (value, user) {
      final docs = value ?? [];
      if (user != null) {
        log.debug('Updating docs for user ${user.uid}');
        beforeSyncNotifyUpdate(docs);
        _docsPerId.update(docs.toIdMap((element) => element.id));
        _isReady.completeIfNotComplete();
        afterSyncNotifyUpdate(docs);
        log.debug('Updated ${docs.length} docs');
      } else {
        log.debug('User is null, clearing docs');
        _docsPerId.update({});
      }
    };
  }
}

abstract class BeforeCollectionService<T extends WriteableId<String>, API extends TuApi<T>>
    extends CollectionService<T, API> {
  BeforeCollectionService({required super.api});

  void beforeSyncNotifyUpdate(List<T> docs);

  @override
  void Function(List<T>? value, User? user) get onData {
    return (value, user) {
      final docs = value ?? [];
      if (user != null) {
        log.debug('Updating docs for user ${user.uid}');
        beforeSyncNotifyUpdate(docs);
        _docsPerId.update(docs.toIdMap((element) => element.id));
        _isReady.completeIfNotComplete();
        log.debug('Updated ${docs.length} docs');
      } else {
        log.debug('User is null, clearing docs');
        _docsPerId.update({});
      }
    };
  }
}

abstract class AfterCollectionService<T extends WriteableId<String>, API extends TuApi<T>>
    extends CollectionService<T, API> {
  AfterCollectionService({required super.api});

  void afterSyncNotifyUpdate(List<T> docs);

  @override
  void Function(List<T>? value, User? user) get onData {
    return (value, user) {
      final docs = value ?? [];
      if (user != null) {
        log.debug('Updating docs for user ${user.uid}');
        _docsPerId.update(docs.toIdMap((element) => element.id));
        _isReady.completeIfNotComplete();
        afterSyncNotifyUpdate(docs);
        log.debug('Updated ${docs.length} docs');
      } else {
        log.debug('User is null, clearing docs');
        _docsPerId.update({});
      }
    };
  }
}

/// An abstract class representing a service for managing a collection of objects with string IDs.
///
/// This class extends [AuthSyncService] and includes [Loglytics] functionality.
/// It provides methods for synchronizing and managing a collection of objects of type [T],
/// where [T] is a type that extends [WriteableId].
///
/// The service uses a [TuApi] to interact with [FirebaseFirestore].
abstract class CollectionService<T extends WriteableId<String>, API extends TuApi<T>>
    extends AuthSyncService<List<T>> with Loglytics {
  CollectionService({
    required this.api,
  });

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final API api;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> dispose() {
    _docsPerId.dispose();
    _isReady.completeIfNotComplete();
    return super.dispose();
  }

  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\

  final _docsPerId = Informer<Map<String, T>>({}, forceUpdate: true);
  final _isReady = Completer();

  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\

  Future get isReady => _isReady.future;
  Listenable get listenable => _docsPerId;
  T findById(String id) => _docsPerId.value[id]!;
  T? tryFindById(String? id) => _docsPerId.value[id];
  ValueListenable<Map<String, T>> get docsPerId => _docsPerId;
  bool get hasDocs => _docsPerId.value.isNotEmpty;

  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\

  @override
  void Function(List<T>? value, User? user) get onData {
    return (value, user) {
      final docs = value ?? [];
      if (user != null) {
        log.debug('Updating docs for user ${user.uid}');
        _docsPerId.update(docs.toIdMap((element) => element.id));
        _isReady.completeIfNotComplete();
        log.debug('Updated ${docs.length} docs');
      } else {
        log.debug('User is null, clearing docs');
        _docsPerId.update({});
      }
    };
  }

  // ⚙️ LOCAL MUTATORS ------------------------------------------------------------------------ \\

  /// Deletes a local document from the collection.
  ///
  /// [doc] The document to delete
  /// [doNotifyListeners] Whether to notify listeners after deletion
  @protected
  void deleteLocalDoc({
    required T doc,
    bool doNotifyListeners = true,
  }) {
    log.debug('Deleting local doc with id: ${doc.id}');
    _docsPerId.updateCurrent(
      (value) => value..remove(doc.id),
      doNotifyListeners: doNotifyListeners,
    );
  }

  /// Deletes multiple local documents from the collection.
  ///
  /// [docs] The documents to delete
  /// [doNotifyListeners] Whether to notify listeners after deletion
  @protected
  void deleteLocalDocs({
    required List<T> docs,
    bool doNotifyListeners = true,
  }) {
    log.debug('Deleting ${docs.length} local docs');
    for (final doc in docs) {
      deleteLocalDoc(doc: doc, doNotifyListeners: false);
    }
    if (doNotifyListeners) _docsPerId.rebuild();
  }

  /// Upserts a local document in the collection.
  ///
  /// [doc] The document to upsert
  /// [doNotifyListeners] Whether to notify listeners after upsert
  @protected
  void upsertLocalDoc({
    required T doc,
    bool doNotifyListeners = true,
  }) {
    log.debug('Upserting local doc with id: ${doc.id}');
    _docsPerId.updateCurrent(
      (value) => value
        ..update(
          doc.id,
          (_) => doc,
          ifAbsent: () => doc,
        ),
      doNotifyListeners: doNotifyListeners,
    );
  }

  /// Updates a local document in the collection.
  ///
  /// [doc] The document to update
  /// [doNotifyListeners] Whether to notify listeners after update
  @protected
  void updateLocalDoc({
    required T doc,
    bool doNotifyListeners = true,
  }) {
    log.debug('Updating local doc with id: ${doc.id}');
    _docsPerId.updateCurrent(
      (value) => value..update(doc.id, (_) => doc),
      doNotifyListeners: doNotifyListeners,
    );
  }

  /// Creates a local document in the collection.
  ///
  /// [doc] The document to create
  /// [doNotifyListeners] Whether to notify listeners after creation
  @protected
  void createLocalDoc({
    required T doc,
    bool doNotifyListeners = true,
  }) {
    log.debug('Creating local doc with id: ${doc.id}');
    _docsPerId.updateCurrent(
      (value) => value..[doc.id] = doc,
      doNotifyListeners: doNotifyListeners,
    );
  }

  /// Upserts multiple local documents in the collection.
  ///
  /// [docs] The documents to upsert
  /// [doNotifyListeners] Whether to notify listeners after upsert
  @protected
  void upsertLocalDocs({
    required List<T> docs,
    bool doNotifyListeners = true,
  }) {
    log.debug('Upserting ${docs.length} local docs');
    for (final doc in docs) {
      upsertLocalDoc(doc: doc, doNotifyListeners: false);
    }
    if (doNotifyListeners) _docsPerId.rebuild();
  }

  /// Updates multiple local documents in the collection.
  ///
  /// [docs] The documents to update
  /// [doNotifyListeners] Whether to notify listeners after update
  @protected
  void updateLocalDocs({
    required List<T> docs,
    bool doNotifyListeners = true,
  }) {
    log.debug('Updating ${docs.length} local docs');
    for (final doc in docs) {
      updateLocalDoc(doc: doc, doNotifyListeners: false);
    }
    if (doNotifyListeners) _docsPerId.rebuild();
  }

  /// Creates multiple local documents in the collection.
  ///
  /// [docs] The documents to create
  /// [doNotifyListeners] Whether to notify listeners after creation
  @protected
  void createLocalDocs({
    required List<T> docs,
    bool doNotifyListeners = true,
  }) {
    log.debug('Creating ${docs.length} local docs');
    for (final doc in docs) {
      createLocalDoc(doc: doc, doNotifyListeners: false);
    }
    if (doNotifyListeners) _docsPerId.rebuild();
  }

  // 🕹️ LOCAL & REMOTE MUTATORS --------------------------------------------------------------- \\

  /// Updates a document both locally and remotely.
  ///
  /// [doc] The document to update
  /// [transaction] Optional transaction for atomic operations
  /// [remoteUpdateRequestBuilder] Optional request builder for remote update
  /// [doNotifyListeners] Whether to notify listeners after update
  @protected
  Future<FeedbackResponse<DocumentReference>> updateDoc({
    Transaction? transaction,
    Writeable Function(T doc)? remoteUpdateRequestBuilder,
    bool doNotifyListeners = true,
    required T doc,
  }) async {
    try {
      log.debug('Updating doc with id: ${doc.id}');
      updateLocalDoc(
        doc: doc,
        doNotifyListeners: doNotifyListeners,
      );
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

  /// Creates a document both locally and remotely.
  ///
  /// [doc] The document to create
  /// [transaction] Optional transaction for atomic operations
  /// [doNotifyListeners] Whether to notify listeners after creation
  @protected
  Future<FeedbackResponse<DocumentReference>> createDoc({
    Transaction? transaction,
    bool doNotifyListeners = true,
    required T doc,
  }) async {
    try {
      log.debug('Creating doc with id: ${doc.id}');
      createLocalDoc(
        doc: doc,
        doNotifyListeners: doNotifyListeners,
      );
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

  /// Updates multiple documents both locally and remotely.
  ///
  /// [docs] The documents to update
  /// [transaction] Optional transaction for atomic operations
  /// [remoteUpdateRequestBuilder] Optional request builder for remote updates
  /// [doNotifyListeners] Whether to notify listeners after update
  @protected
  Future<FeedbackResponse> updateDocs({
    Writeable Function(T doc)? remoteUpdateRequestBuilder,
    bool doNotifyListeners = true,
    required List<T> docs,
    Transaction? transaction,
  }) async {
    try {
      log.debug('Updating ${docs.length} docs');
      updateLocalDocs(docs: docs, doNotifyListeners: doNotifyListeners);
      if (transaction != null) {
        for (final doc in docs) {
          await api.updateDoc(
            id: doc.id,
            transaction: transaction,
            writeable: remoteUpdateRequestBuilder?.call(doc) ?? doc,
          );
        }
        return FeedbackResponse.successNone();
      } else {
        final batch = api.writeBatch;
        for (final doc in docs) {
          await api.batchUpdateDoc(
            id: doc.id,
            writeBatch: batch,
            writeable: remoteUpdateRequestBuilder?.call(doc) ?? doc,
          );
        }
        final future = batch.commit();
        tempBlockStreamUpdates(future);
        await future;
        return FeedbackResponse.successNone();
      }
    } catch (error, stackTrace) {
      log.error(
        '${error.runtimeType} caught while updating docs',
        error: error,
        stackTrace: stackTrace,
      );
      return FeedbackResponse.errorNone();
    }
  }

  /// Creates multiple documents both locally and remotely.
  ///
  /// [docs] The documents to create
  /// [transaction] Optional transaction for atomic operations
  /// [doNotifyListeners] Whether to notify listeners after creation
  @protected
  Future<FeedbackResponse> createDocs({
    bool doNotifyListeners = true,
    required List<T> docs,
    Transaction? transaction,
  }) async {
    try {
      log.debug('Creating ${docs.length} docs');
      createLocalDocs(docs: docs, doNotifyListeners: doNotifyListeners);
      if (transaction != null) {
        for (final doc in docs) {
          await api.createDoc(
            id: doc.id,
            transaction: transaction,
            writeable: doc,
          );
        }
        return FeedbackResponse.successNone();
      } else {
        final batch = api.writeBatch;
        for (final doc in docs) {
          await api.batchCreateDoc(
            id: doc.id,
            writeBatch: batch,
            writeable: doc,
          );
        }
        final future = batch.commit();
        tempBlockStreamUpdates(future);
        await future;
        return FeedbackResponse.successNone();
      }
    } catch (error, stackTrace) {
      log.error(
        '${error.runtimeType} caught while creating docs',
        error: error,
        stackTrace: stackTrace,
      );
      return FeedbackResponse.errorNone();
    }
  }

  /// Deletes a document both locally and remotely.
  ///
  /// [doc] The document to delete
  /// [transaction] Optional transaction for atomic operations
  /// [doNotifyListeners] Whether to notify listeners after deletion
  @protected
  Future<FeedbackResponse<void>> deleteDoc({
    required T doc,
    bool doNotifyListeners = true,
    Transaction? transaction,
  }) async {
    try {
      log.debug('Deleting doc with id: ${doc.id}');
      deleteLocalDoc(doc: doc, doNotifyListeners: doNotifyListeners);
      final future = api.deleteDoc(
        id: doc.id,
        transaction: transaction,
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

  /// Deletes multiple documents both locally and remotely.
  ///
  /// [docs] The documents to delete
  /// [transaction] Optional transaction for atomic operations
  /// [doNotifyListeners] Whether to notify listeners after deletion
  @protected
  Future<FeedbackResponse> deleteDocs({
    required List<T> docs,
    bool doNotifyListeners = true,
    Transaction? transaction,
  }) async {
    try {
      log.debug('Deleting ${docs.length} docs');
      deleteLocalDocs(docs: docs, doNotifyListeners: doNotifyListeners);
      if (transaction != null) {
        for (final doc in docs) {
          await api.deleteDoc(
            id: doc.id,
            transaction: transaction,
          );
        }
        return FeedbackResponse.successNone();
      } else {
        final batch = api.writeBatch;
        for (final doc in docs) {
          await api.batchDeleteDoc(
            id: doc.id,
            writeBatch: batch,
          );
        }
        final future = batch.commit();
        tempBlockStreamUpdates(future);
        await future;
        return FeedbackResponse.successNone();
      }
    } catch (error, stackTrace) {
      log.error(
        '${error.runtimeType} caught while deleting docs',
        error: error,
        stackTrace: stackTrace,
      );
      return FeedbackResponse.errorNone();
    }
  }

  /// Upserts a document both locally and remotely.
  ///
  /// [doc] The document to upsert
  /// [transaction] Optional transaction for atomic operations
  /// [remoteUpdateRequestBuilder] Optional request builder for remote upsert
  /// [doNotifyListeners] Whether to notify listeners after upsert
  @protected
  Future<FeedbackResponse<DocumentReference>> upsertDoc({
    Transaction? transaction,
    Writeable Function(T doc)? remoteUpdateRequestBuilder,
    bool doNotifyListeners = true,
    required T doc,
  }) async {
    try {
      log.debug('Upserting doc with id: ${doc.id}');
      upsertLocalDoc(
        doc: doc,
        doNotifyListeners: doNotifyListeners,
      );
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

  /// Upserts multiple documents both locally and remotely.
  ///
  /// [docs] The documents to upsert
  /// [transaction] Optional transaction for atomic operations
  /// [remoteUpdateRequestBuilder] Optional request builder for remote upserts
  /// [doNotifyListeners] Whether to notify listeners after upsert
  @protected
  Future<FeedbackResponse> upsertDocs({
    Writeable Function(T doc)? remoteUpdateRequestBuilder,
    bool doNotifyListeners = true,
    required List<T> docs,
    Transaction? transaction,
  }) async {
    try {
      log.debug('Upserting ${docs.length} docs');
      upsertLocalDocs(docs: docs, doNotifyListeners: doNotifyListeners);
      if (transaction != null) {
        for (final doc in docs) {
          await api.createDoc(
            id: doc.id,
            transaction: transaction,
            writeable: doc.isLocalDefault ? doc : remoteUpdateRequestBuilder?.call(doc) ?? doc,
            merge: true,
          );
        }
        return FeedbackResponse.successNone();
      } else {
        final batch = api.writeBatch;
        for (final doc in docs) {
          await api.batchCreateDoc(
            id: doc.id,
            writeBatch: batch,
            writeable: doc.isLocalDefault ? doc : remoteUpdateRequestBuilder?.call(doc) ?? doc,
            merge: true,
          );
        }
        final future = batch.commit();
        tempBlockStreamUpdates(future);
        await future;
        return FeedbackResponse.successNone();
      }
    } catch (error, stackTrace) {
      log.error(
        '${error.runtimeType} caught while upserting docs',
        error: error,
        stackTrace: stackTrace,
      );
      return FeedbackResponse.errorNone();
    }
  }
}
