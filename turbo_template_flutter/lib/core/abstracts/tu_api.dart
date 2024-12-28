import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_api/api/firestore_api.dart';
import 'package:cloud_firestore_api/data/enums/sensitive_log_level.dart';
import 'package:flutter/foundation.dart';

import '../constants/k_keys.dart';
import '../enums/firestore_collection.dart';
import '../utils/api_logger.dart';

abstract class TuApi<T extends Object> extends FirestoreApi<T> {
  TuApi({
    required FirestoreCollection firestoreCollection,
    String Function(FirestoreCollection firestoreCollection)? path,
  }) : super(
          collectionPath: () => path?.call(firestoreCollection) ?? firestoreCollection.path(),
          createdFieldName: firestoreCollection.createdFieldName,
          documentReferenceFieldName: firestoreCollection.documentReferenceFieldName,
          firebaseFirestore: FirebaseFirestore.instance,
          firestoreLogger: ApiLogger(
            location: firestoreCollection.apiName,
          ),
          fromJson: firestoreCollection.fromJson<T>(),
          idFieldName: kKeysId,
          isCollectionGroup: firestoreCollection.isCollectionGroup,
          sensitiveLogLevel: kDebugMode ? SensitiveLogLevel.info : SensitiveLogLevel.none,
          toJson: firestoreCollection.toJson<T>(),
          tryAddLocalDocumentReference: firestoreCollection.tryAddLocalDocumentReference,
          tryAddLocalId: true,
          updatedFieldName: firestoreCollection.updatedFieldName,
        );
}
