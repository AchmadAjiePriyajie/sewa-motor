import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  final String title;
  final String message;
  final String userId;
  final String transactionId;
  final Timestamp? timestamp;

  Notification({
    required this.title,
    required this.message,
    required this.userId,
    required this.transactionId,
    this.timestamp,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json['title'] as String,
        message: json['message'] as String,
        userId: json['userId'] as String,
        transactionId: json['transactionId'] as String,
        timestamp: json['timestamp'] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'message': message,
        'userId': userId,
        'transactionId': transactionId,
        'timestamp': timestamp,
      };
}
