import 'package:cloud_firestore/cloud_firestore.dart';

class SharedService {
  Future<Map<String, dynamic>> get(String docId, String collection) {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(docId)
        .get()
        .then((result) {
      if (result.exists) {
        var data = result.data();
        return { 
          ...data['data'] 
        };
      } else
        return null;
    });
  }
}
