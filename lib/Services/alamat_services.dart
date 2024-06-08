import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sewa_motor/model/alamat.dart';

class AlamatServices {
  final CollectionReference alamat =
      FirebaseFirestore.instance.collection('alamat');

  Future<void> addAlamat(String provinsi, String kota, String kecamatan,
      String kodePos, String detailAlamat, String userId) {
    return alamat.add(Alamat(
            provinsi: provinsi,
            kota: kota,
            kecamatan: kecamatan,
            kodePos: kodePos,
            detailAlamat: detailAlamat,
            userId: userId,
            createdAt: Timestamp.now())
        .toJson());
  }

  Future<void> updateAlamat(String docId, String provinsi, String kota,
      String kecamatan, String kodePos, String detailAlamat) async {
    DocumentReference documentReference = alamat.doc(docId);
    await documentReference.update({
      'provinsi': provinsi ,
      'kota': kota,
      'kecamatan': kecamatan,
      'kodePos': kodePos,
      'detailAlamat': detailAlamat
    });
  }

  Stream<QuerySnapshot> getAlamatStream(String userId) {
    final alamatStream = alamat.where('userId', isEqualTo: userId).snapshots();
    return alamatStream;
  }

  Future<DocumentSnapshot> getAlamatStreamById(String docId) async {
    DocumentReference docRef = alamat.doc(docId);
    DocumentSnapshot docSnapshot = await docRef.get();
    return docSnapshot;
  }
}
