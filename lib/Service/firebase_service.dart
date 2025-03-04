import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  Future<void> addDetails(Map<String, dynamic> details, String id) async {
    await FirebaseFirestore.instance
        .collection("CartDetails")
        .doc(id)
        .set(details);
  }

  Future<Stream<QuerySnapshot>> getdetails() async {
    return await FirebaseFirestore.instance
        .collection("CartDetails")
        .snapshots();
  }

  Future deletCard(String id) async {
    return await FirebaseFirestore.instance
        .collection("CartDetails")
        .doc(id)
        .delete();
  }
}
