import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sewa_motor/Services/motor_services.dart';
import 'package:sewa_motor/model/transaction.dart';

class TransactionService {
  final CollectionReference transaction =
      FirebaseFirestore.instance.collection('transactions');
  MotorService motorService = MotorService();

  Future<void> createTransaction(
    String userId,
    String motorId,
    int duration,
    String paymentMethod,
    double totalPrice,
  ) {
    return transaction.doc('TR-${Timestamp.now().toString()}').set(
          Transactions(
            userId: userId,
            motorId: motorId,
            transactionId: 'TR-${Timestamp.now().toString()}',
            orderedAt: Timestamp.now(),
            snapToken: '',
            paymentMethod: paymentMethod,
            duration: duration,
            totalPrice: totalPrice,
            status: 'Pending',
          ).toJson(),
        );
  }
}
