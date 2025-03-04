import 'package:cloud_firestore/cloud_firestore.dart';

class HomepageDatabaseHelper {
  final CollectionReference HomepageCollection = FirebaseFirestore.instance.collection("Homepage");

  /// Add a new record
  Future<void> addDetails(Map<String, dynamic> details, String id) async {
    try {
      await HomepageCollection.doc(id).set(details);
    } catch (e) {
      print("Error adding details: $e");
    }
  }

  
  Stream<QuerySnapshot> getDetails() {
    return HomepageCollection.snapshots();
  }

  
  Future<void> updateDetails(String id, Map<String, dynamic> updatedDetails) async {
    try {
      await HomepageCollection.doc(id).update(updatedDetails);
    } catch (e) {
      print("Error updating details: $e");
    }
  }

  
  Future<void> deleteDetails(String id) async {
    try {
      await HomepageCollection.doc(id).delete();
    } catch (e) {
      print("Error deleting details: $e");
    }
  }
}
