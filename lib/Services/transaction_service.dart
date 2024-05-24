import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sewa_motor/Services/motor_services.dart';
import 'package:sewa_motor/model/transaction.dart';

class TransactionService {
  final CollectionReference transaction =
      FirebaseFirestore.instance.collection('transactions');
  MotorService motorService = MotorService();

  Future<String> createTransaction(
    String userId,
    String motorId,
    int duration,
    String paymentMethod,
    double totalPrice,
    String address,
  ) {
    String transactionID =
        'TR-${Timestamp.now().microsecondsSinceEpoch.toString()}';
    transaction.doc(transactionID).set(
          Transactions(
            userId: userId,
            motorId: motorId,
            transactionId: transactionID,
            orderedAt: Timestamp.now(),
            snapToken: '',
            paymentMethod: paymentMethod,
            duration: duration,
            totalPrice: totalPrice,
            status: 'Pending',
            address: address,
          ).toJson(),
        );
    // return transactionID as Future<String>;
    return Future(() => transactionID);
  }

  Future<void> updateSnapById(String docId, String snapToken) async {
    DocumentReference documentReference = transaction.doc(docId);
    await documentReference.update({
      'snap_token': snapToken,
    });
  }

  Future<DocumentSnapshot> getTransactionById(String docID) async {
    DocumentReference docRef = transaction.doc(docID);
    DocumentSnapshot docSnapshot = await docRef.get();
    return docSnapshot;
  }

  Future<void> updateStatusById(String docID, String status) async {
    DocumentReference documentReference = transaction.doc(docID);
    await documentReference.update({
      'status': status,
    });
  }
}
