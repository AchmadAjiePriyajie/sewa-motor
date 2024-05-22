import 'package:cloud_firestore/cloud_firestore.dart';

class Transactions {
  final String userId;
  final String motorId;
  final String transactionId;
  final Timestamp orderedAt;
  final int duration;
  final String paymentMethod;
  final double totalPrice;
  final String snapToken;
  final String status;
  Transactions({
    required this.userId,
    required this.motorId,
    required this.transactionId,
    required this.orderedAt,
    required this.snapToken,
    required this.paymentMethod,
    required this.duration,
    required this.totalPrice,
    required this.status,
  });
  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        userId: json['userId'] as String,
        motorId: json['motorId'] as String,
        transactionId: json['transactionId'] as String,
        orderedAt: json['orderedAt'] as Timestamp,
        duration: json['duration'] as int,
        snapToken: json['snap_token'],
        paymentMethod: json['payment_method'] as String,
        totalPrice: json['total_price'] as double,
        status: json['status'] as String,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'motorId': motorId,
        'transactionId': transactionId,
        'orderedAt': orderedAt,
        'snap_token': snapToken,
        'payment_method': paymentMethod,
        'duration': duration,
        'total_price': totalPrice,
        'status': status,
      };
}
