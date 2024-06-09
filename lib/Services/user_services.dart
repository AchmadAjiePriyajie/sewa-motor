import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sewa_motor/model/location.dart';

class UserService {
  final user = FirebaseFirestore.instance.collection('Users');
  Future<void> updateUserLocation(String userId, Location location) async {
    try {
      await user.doc(userId).update({
        'location': {'lat': location.lat, 'lng': location.lng},
      });
    } on FirebaseException catch (e) {
      print('Ann error due to firebase occured $e');
    } catch (err) {
      print('Ann error occured $err');
    }
  }

  Future<DocumentSnapshot> getUserById(String docID) async {
    DocumentReference docRef = user.doc(docID);
    DocumentSnapshot docSnapshot = await docRef.get();
    return docSnapshot;
  }

  Stream<QuerySnapshot> getUserStreamById(String docId) {
    final userStream = user.where('email', isEqualTo: docId).snapshots();
    return userStream;
  }

  Future<void> updateUserById(
      String docId, String username, String noWA) async {
    await user.doc(docId).update({
      'username': username,
      'nomor_wa': noWA,
    });
  }

  Future<void> updateUserTransctionId(
      String docID, String transactionId) async {
    await user.doc(docID).update({
      'transactionId': transactionId,
    });
  }
}
