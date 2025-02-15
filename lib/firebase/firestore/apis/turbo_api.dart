import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:turbo_firestore_api/apis/turbo_firestore_api.dart';
import 'package:turbo_template/firebase/firestore/enums/firestore_collection.dart';
export 'package:turbo_firestore_api/apis/turbo_firestore_api.dart';

abstract class TurboApi<T extends Object> extends TurboFirestoreApi<T> {
  TurboApi({
    required FirestoreCollection firestoreCollection,
    String Function(FirestoreCollection firestoreCollection)? path,
  }) : super(
          collectionPath: () => path?.call(firestoreCollection) ?? firestoreCollection.path(),
          documentReferenceFieldName: firestoreCollection.documentReferenceFieldName,
          firebaseFirestore: FirebaseFirestore.instance,
          fromJson: firestoreCollection.fromJson<T>(),
          isCollectionGroup: firestoreCollection.isCollectionGroup,
          hideSensitiveData: !kDebugMode,
          toJson: firestoreCollection.toJson<T>(),
          tryAddLocalDocumentReference: firestoreCollection.tryAddLocalDocumentReference,
          tryAddLocalId: true,
        );
}
