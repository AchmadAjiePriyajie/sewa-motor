
class ExtendTransaction {
  final String transactionId;
  final String extendTransactionId;
  final String status;
  final int duration;
  final double totalPrice;
  final String snapToken;
  final String paymentMethod;

  
  ExtendTransaction({
    required this.transactionId,
    required this.extendTransactionId,
    required this.duration,
    required this.status,
    required this.totalPrice,
    required this.paymentMethod,
    required this.snapToken,
  });
  factory ExtendTransaction.fromJson(Map<String, dynamic> json) => ExtendTransaction(
        transactionId: json['transactionId'] as String,
        extendTransactionId: json['extendTransactionId'] as String,
        duration: json['duration'] as int,
        snapToken: json['snap_token'],
        paymentMethod: json['payment_method'] as String,
        totalPrice: json['total_price'] as double,
        status: json['status'] as String,
      );

  Map<String, dynamic> toJson() => {
        'transactionId': transactionId,
        'extendTransactionId': extendTransactionId,
        'snap_token': snapToken,
        'payment_method': paymentMethod,
        'duration': duration,
        'total_price': totalPrice,
        'status': status,
      };
}
