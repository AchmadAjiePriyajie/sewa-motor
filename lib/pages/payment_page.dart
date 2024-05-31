import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:midtrans_snap/midtrans_snap.dart';
import 'package:midtrans_snap/models.dart';
import 'package:sewa_motor/Services/transaction_service.dart';
import 'package:sewa_motor/pages/main_page.dart';

class PaymentPage extends StatefulWidget {
  final String token;
  final String transactionId;
  PaymentPage({
    super.key,
    required this.token,
    required this.transactionId,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TransactionService transactionService = TransactionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MidtransSnap(
        mode: MidtransEnvironment.sandbox,
        token: widget.token,
        midtransClientKey: dotenv.get('MIDTRANS_CLIENT_KEY'),
        onPageFinished: (url) {
          print(url);
        },
        onPageStarted: (url) {
          print(url);
        },
        onResponse: (result) {
          transactionService.updateStatusById(widget.transactionId, 'Paid');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(
                bottomNavIdx: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}
