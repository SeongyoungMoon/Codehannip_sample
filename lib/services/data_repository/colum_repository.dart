import 'dart:async';

import 'package:code_hannip/models/column_model.dart';

import '../firestore_path.dart';
import '../firestore_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

/*
This is the main class access/call for any UI widgets that require to perform
any CRUD activities operation in Firestore database.
This class work hand-in-hand with FirestoreService and FirestorePath.

Notes:
For cases where you need to have a special method such as bulk update specifically
on a field, then is ok to use custom code and write it here. For example,
setAllTodoComplete is require to change all todos item to have the complete status
changed to true.

 */
class ColumnRepository {
  ColumnRepository();

  final _firestoreService = FirestoreService.instance;

  Stream<List<ColumnModel>> columnStream(documentId) =>
      _firestoreService.collectionStream(
        path: FirestorePath.column(documentId),
        builder: (data, documentId) => ColumnModel.fromDs(data, documentId),
      );
}
