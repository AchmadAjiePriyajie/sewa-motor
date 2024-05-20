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
}
