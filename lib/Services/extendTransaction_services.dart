import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sewa_motor/model/extend_transaction.dart';

class ExtendTransactionServices {
  final CollectionReference extend =
      FirebaseFirestore.instance.collection('extendTransaction');

  Future<String> CreateExtendTransaction(String transactionId, int duration,
      double totalPrice, String paymentMethod) {
    String extendTransactionId =
        'TRE-${Timestamp.now().microsecondsSinceEpoch.toString()}';

    extend.doc(extendTransactionId).set(ExtendTransaction(
          extendTransactionId: extendTransactionId,
          transactionId: transactionId,
          duration: duration,
          status: 'Pending',
          totalPrice: totalPrice,
          paymentMethod: paymentMethod,
          snapToken: '',
        ).toJson());

    return Future(() => extendTransactionId);
  }

  Future<void> updateSnapById(String docId, String snapToken) async {
    DocumentReference documentReference = extend.doc(docId);
    await documentReference.update({
      'snap_token': snapToken,
    });
  }

  Stream<QuerySnapshot> getTransactionStreamById(String docId) {
    final extendStream =
        extend.where('extendTransactionId', isEqualTo: docId).snapshots();
    return extendStream;
  }

  Future<DocumentSnapshot> getExtendStreamById (String docId) async{
    DocumentReference docRef = extend.doc(docId);
    DocumentSnapshot docSnapshot = await docRef.get();
    return docSnapshot;
  }

  Future<void> updateStatusById(String docId, String status) async {
    DocumentReference documentReference = extend.doc(docId);
    await documentReference.update({
      'status': status,
    });
  }
}
