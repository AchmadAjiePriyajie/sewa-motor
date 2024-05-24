import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:midtrans_snap/midtrans_snap.dart';
import 'package:midtrans_snap/models.dart';
import 'package:sewa_motor/Services/transaction_service.dart';

class PaymentPage extends StatelessWidget {
  final String token;
  final String transactionId;
  PaymentPage({
    super.key,
    required this.token,
    required this.transactionId,
  });
  TransactionService transactionService = TransactionService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MidtransSnap(
        mode: MidtransEnvironment.sandbox,
        token: token,
        midtransClientKey: dotenv.get('MIDTRANS_CLIENT_KEY'),
        onPageFinished: (url) {
          print(url);
        },
        onPageStarted: (url) {
          print(url);
        },
        onResponse: (result) {
          transactionService.updateStatusById(transactionId, 'Paid');
        },
      ),
    );
  }
}
