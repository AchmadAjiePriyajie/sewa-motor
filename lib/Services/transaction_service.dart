import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sewa_motor/Services/motor_services.dart';
import 'package:sewa_motor/model/transaction.dart';

class TransactionService {
  final CollectionReference transaction =
      FirebaseFirestore.instance.collection('transactions');
  MotorService motorService = MotorService();

  Future<void> countdownUpdate(String docID, Timestamp timestamp) async {
    DocumentReference docRef = transaction.doc(docID);

    await docRef.update({'endDuration': Timestamp.now()});
  }

  Future<String> createTransaction(
    String userId,
    String motorId,
    int duration,
    String paymentMethod,
    double totalPrice,
    String address,
  ) {
    Timestamp orderedAt = Timestamp.now();
    DateTime orderedAtDateTime = orderedAt.toDate();
    DateTime endDurationDateTime =
        orderedAtDateTime.add(Duration(hours: duration));
    Timestamp endDuration = Timestamp.fromDate(endDurationDateTime);

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
            endDuration: endDuration,
            totalPrice: totalPrice,
            status: 'Pending',
            address: address,
            tambahDurasi: false,
            extendTransactionId: ''
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

  Future<void> updateExtendId(String docId, String extendId) async{
    DocumentReference documentReference = transaction.doc(docId);
    await documentReference.update({
      'extendTransactionId' : extendId,
    });
  }

  Future<DocumentSnapshot> getTransactionById(String docID) async {
    DocumentReference docRef = transaction.doc(docID);
    DocumentSnapshot docSnapshot = await docRef.get();
    return docSnapshot;
  }

  

  Stream<QuerySnapshot> getTransactionStreamById(String docId) {
    final transactionStream =
        transaction.where('transactionId', isEqualTo: docId).snapshots();
    return transactionStream;
  }

  Future<void> updateDurationById(String docId, int durationTotal,int duration, double totalPrice,Timestamp endDurations) async{
    DocumentReference documentReference = transaction.doc(docId);
    Timestamp orderedAt = endDurations;
    DateTime orderedAtDateTime = orderedAt.toDate();
    DateTime endDurationDateTime = orderedAtDateTime.add(Duration(hours: duration));
    Timestamp endDuration = Timestamp.fromDate(endDurationDateTime);
    await documentReference.update({
      'duration' : durationTotal,
      'endDuration': endDuration,
      'total_price': totalPrice,
      'extendTransactionId': ''
    });
  }

  Future<void> updateTambahDurasiById(String docID, bool tambahDurasi) async {
    DocumentReference documentReference = transaction.doc(docID);
    await documentReference.update({
      'tambahDurasi': tambahDurasi,
    });
  }

  Future<void> updateStatusById(String docID, String status) async {
    DocumentReference documentReference = transaction.doc(docID);
    await documentReference.update({
      'status': status,
    });
  }
}
