import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sewa_motor/model/Motor.dart';

class MotorService {
  final CollectionReference motor =
      FirebaseFirestore.instance.collection('motor');

  Future<void> addMotor(String namaMotor, int harga, String merk,
      var downloadUrl, int kapasitasMesin) {
    return motor.add(
      Motor(
        namaMotor: namaMotor,
        harga: harga,
        merk: merk,
        kapasitasMesin: kapasitasMesin,
        imageUrl: downloadUrl,
        isOrdered: false,
        timestamp: Timestamp.now(),
      ).toJson(),
    );
  }

  Stream<QuerySnapshot> getMotorStream() {
    final motorStream = motor
        .where('isOrdered', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .snapshots();
    return motorStream;
  }

  Stream<QuerySnapshot> getMotorStreamByMerk(String merk) {
    final motorStream = motor
        .where("merk", isEqualTo: merk)
        .where('isOrdered', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .snapshots();
    return motorStream;
  }

  Future<DocumentSnapshot> getMotorById(String docID) async {
    DocumentReference docRef = motor.doc(docID);
    DocumentSnapshot docSnapshot = await docRef.get();
    return docSnapshot;
  }

  Future<void> deleteMotor(String docID) async {
    DocumentReference motorData = motor.doc(docID);
    DocumentSnapshot motorSnapshot = await getMotorById(docID);
    await FirebaseStorage.instance
        .refFromURL(motorSnapshot.get('Image'))
        .delete();
    return motorData.delete();
  }

  Future<void> updateMotor(String docID, String namaMotor, int kapasitasMesin,
      int harga, String merk, String imageUrl) async {
    DocumentReference docRef = motor.doc(docID);

    await docRef.update(
      Motor(
        namaMotor: namaMotor,
        harga: harga,
        merk: merk,
        kapasitasMesin: kapasitasMesin,
        imageUrl: imageUrl,
        isOrdered: false,
      ) as Map<Object, Object?>,
    );
  }

  Future<List<Motor>> getMotorMerk(String merk) async {
    QuerySnapshot query = await motor.where("merk", isEqualTo: merk).get();
    List<Motor> motorList = query.docs
        .map((doc) => Motor.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return motorList;
  }

  Future<void> updateMotorStatus(String docID, bool status) async {
    DocumentReference docRef = motor.doc(docID);

    await docRef.update(
      {
        'isOrdered': status,
      },
    );
  }
}
