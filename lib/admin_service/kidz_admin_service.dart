import 'package:cloud_firestore/cloud_firestore.dart';

class KidzDatabaseHelper {
  final CollectionReference kidzCollection = FirebaseFirestore.instance.collection("Kidz");

  
  Future<void> addDetails(Map<String, dynamic> details, String id) async {
    try {
      await kidzCollection.doc(id).set(details);
    } catch (e) {
      print("Error adding details: $e");
    }
  }

  
  Stream<QuerySnapshot> getDetails() {
    return kidzCollection.snapshots();
  }

  
  Future<void> updateDetails(String id, Map<String, dynamic> updatedDetails) async {
    try {
      await kidzCollection.doc(id).update(updatedDetails);
    } catch (e) {
      print("Error updating details: $e");
    }
  }

 
  Future<void> deleteDetails(String id) async {
    try {
      await kidzCollection.doc(id).delete();
    } catch (e) {
      print("Error deleting details: $e");
    }
  }
}
