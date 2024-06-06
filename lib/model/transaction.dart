import 'package:cloud_firestore/cloud_firestore.dart';

class Transactions {
  final String userId;
  final String motorId;
  final String transactionId;
  final Timestamp orderedAt;
  final int duration;
  final Timestamp endDuration;
  final String address;
  final String paymentMethod;
  final double totalPrice;
  final String snapToken;
  final String status;
  final bool tambahDurasi;
  final String extendTransactionId;
  Transactions({
    required this.userId,
    required this.motorId,
    required this.transactionId,
    required this.orderedAt,
    required this.snapToken,
    required this.paymentMethod,
    required this.duration,
    required this.endDuration,
    required this.totalPrice,
    required this.status,
    required this.address,
    required this.tambahDurasi,
    required this.extendTransactionId

  });
  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        userId: json['userId'] as String,
        motorId: json['motorId'] as String,
        transactionId: json['transactionId'] as String,
        orderedAt: json['orderedAt'] as Timestamp,
        duration: json['duration'] as int,
        endDuration: json['endDuration'] as Timestamp,
        snapToken: json['snap_token'],
        address: json['address'],
        paymentMethod: json['payment_method'] as String,
        totalPrice: json['total_price'] as double,
        status: json['status'] as String,
        tambahDurasi: json['tambahDurasi'] as bool,
        extendTransactionId: json['extendTransactionId'] as String
      );

  Map<String, dynamic> toJson() => {
        'userId': FirebaseFirestore.instance.collection('Users').doc(userId),
        'motorId': FirebaseFirestore.instance.collection('motor').doc(motorId),
        'transactionId': transactionId,
        'orderedAt': orderedAt,
        'snap_token': snapToken,
        'adress': address,
        'payment_method': paymentMethod,
        'duration': duration,
        'endDuration': endDuration,
        'total_price': totalPrice,
        'status': status,
        'tambahDurasi': tambahDurasi,
        'extendTransactionId': extendTransactionId
      };
}
