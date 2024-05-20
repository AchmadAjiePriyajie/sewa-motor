import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  final String userId;
  final String motorId;
  final int transactionId;
  final Timestamp orderedAt;
  final int duration;
  final int totalPrice;
  Transaction({
    required this.userId,
    required this.motorId,
    required this.transactionId,
    required this.orderedAt,
    required this.duration,
    required this.totalPrice,
  });
  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        userId: json['userId'],
        motorId: json['motorId'],
        transactionId: json['transactionId'],
        orderedAt: json['orderedAt'],
        duration: json['duration'],
        totalPrice: json['total_price'],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'motorId': motorId,
        'transactionId': transactionId,
        'orderedAt': orderedAt,
        'duration': duration,
        'total_price': totalPrice,
      };
}
