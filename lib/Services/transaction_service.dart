import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionService {
  final CollectionReference transactions =
      FirebaseFirestore.instance.collection('transactions');

  // Future<void> createTransaction(
  //   String userId,
  //   String motorId,
  //   int transactionId,
  //   Timestamp orderedAt,
  //   int duration,
  //   int totalPrice,
  // ) {}
}
