import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:midtrans_snap/midtrans_snap.dart';
import 'package:midtrans_snap/models.dart';
import 'package:sewa_motor/Services/extendTransaction_services.dart';
import 'package:sewa_motor/Services/transaction_service.dart';
import 'package:sewa_motor/pages/main_page.dart';

class ExtendPaymentPage extends StatefulWidget {
  final String extendTransactionId;
  ExtendPaymentPage({
    super.key,
    required this.extendTransactionId,
  });

  @override
  State<ExtendPaymentPage> createState() => _ExtendPaymentPageState();
}

class _ExtendPaymentPageState extends State<ExtendPaymentPage> {
  TransactionService transactionService = TransactionService();
  ExtendTransactionServices extendTransactionServices =
      ExtendTransactionServices();

  Future<DocumentSnapshot?>? extendData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    extendData = extendTransactionServices
        .getExtendStreamById(widget.extendTransactionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: extendData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Motor data not found'));
          }
          var eData = snapshot.data!;
          var token = eData['snap_token'];
          var extendDuration = eData['duration'];
          double extendTotal = eData['total_price'];
          var transactionId = eData['transactionId'];
          return FutureBuilder(
            future: transactionService.getTransactionById(transactionId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Error loading'));
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text('Motor data not found'));
              }
              var tData = snapshot.data!;
              double total = tData['total_price'];
              double totalPrice = total + extendTotal;
              var endDuration = tData['endDuration'];
              var duration = tData['duration'];

              return MidtransSnap(
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
                  if (result.transactionStatus == 'settlement') {
                    extendTransactionServices.updateStatusById(
                        widget.extendTransactionId, 'Paid');
                    transactionService.updateTambahDurasiById(
                        transactionId, false);
                    transactionService.updateDurationById(
                      transactionId,
                      duration + extendDuration,
                      extendDuration,
                      totalPrice,
                      endDuration,
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(
                            bottomNavIdx: 1,
                          ),
                        ));
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(
                        bottomNavIdx: 1,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
