import 'package:cloud_firestore/cloud_firestore.dart';

import '../../exceptions/firestore_exception.dart';

class FirestoreApi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  FirestoreApi(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection({
    String orderBy,
    bool desc = false,
  }) {
    if (orderBy != null)
      return ref.orderBy(orderBy, descending: desc).snapshots();
    else
      return ref.snapshots();
  }

  Stream<QuerySnapshot> streamDataSecondaryCollection(
    String id,
    String collectionPath, {
    String orderBy,
    bool desc = false,
  }) {
    if (orderBy != null)
      return ref
          .doc(id)
          .collection(collectionPath)
          .orderBy(orderBy, descending: desc)
          .snapshots();
    else
      return ref.doc(id).collection(collectionPath).snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    _db.
    return ref.add(data);
  }

  Future<void> addDocumentById(Map data, String id) {
    try {
      return ref.doc(id).set(data);
    } catch (e) {
      throw FirestoreException(message: e.toString());
    }
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data);
  }
}
