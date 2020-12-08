import 'package:cloud_firestore/cloud_firestore.dart';

class ConvertHelper {
  static List<DocumentReference> dynamicToDocRefList(dynamic list) {
    List<dynamic> init = list;
    return init.map((ref) => ref as DocumentReference).toList();
  }
}
