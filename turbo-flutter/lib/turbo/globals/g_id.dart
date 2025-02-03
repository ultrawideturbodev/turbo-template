import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/k_values.dart';

/// Returns a unique Firebase document ID from the random values collection.
///
/// Uses [FirebaseFirestore] to generate a unique document ID by referencing
/// the random values collection. This ID can be used as a unique identifier
/// for new documents.
///
/// ```dart
/// final id = gId; // Returns something like 'xJ4Gh9k2mN'
/// ```
String get gId => FirebaseFirestore.instance.collection(kValuesRandom).doc().id;
