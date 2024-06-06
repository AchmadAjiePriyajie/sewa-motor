import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sewa_motor/Services/motor_services.dart';
import 'package:sewa_motor/Services/transaction_service.dart';
import 'package:sewa_motor/Services/user_services.dart';
import 'package:sewa_motor/components/countdown.dart';
import 'package:sewa_motor/components/my_button.dart';
import 'package:sewa_motor/components/my_text.dart';
import 'package:sewa_motor/pages/extend_payment.dart';
import 'package:sewa_motor/pages/form_extend_transaction.dart';
import 'package:sewa_motor/pages/payment_page.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final TransactionService transactionService = TransactionService();
  final UserService userService = UserService();
  final MotorService motorService = MotorService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue[800],
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Receipt',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile_page');
              },
              child: Image.asset(
                'images/profile.png',
                width: 40,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: userService.getUserStreamById(user.email!),
            builder: (context, userSnapshot) {
              if (!userSnapshot.hasData) {
                return SizedBox();
              }
              List<DocumentSnapshot> userList = userSnapshot.data!.docs;
              var userData = userList[0];
              var transactionId = userData['transactionId'];
              if (transactionId.isEmpty) {
                return Center(child: Text(''));
              }
              return StreamBuilder<QuerySnapshot>(
                stream:
                    transactionService.getTransactionStreamById(transactionId),
                builder: (context, transactionSnapshot) {
                  if (!transactionSnapshot.hasData) {
                    return SizedBox();
                  }
                  List<DocumentSnapshot> transactionList =
                      transactionSnapshot.data!.docs;
                  var transactionData = transactionList[0];
                  var statusPembayaran = transactionData['status'];
                  DateTime endDuration =
                      transactionData['endDuration'].toDate();
                  return statusPembayaran == 'Ongoing' &&
                          endDuration.isAfter(DateTime.now())
                      ? Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 10),
                                child: Row(
                                  children: [
                                    MyText(
                                      text: 'Sisa Waktu',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CountdownTimer(
                                    endTime: endDuration,
                                    status: statusPembayaran,
                                    docId: transactionId,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : endDuration.isBefore(DateTime.now())
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red.withOpacity(0.2)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.warning),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: MyText(
                                        text: 'Anda telah melebihi waktu sewa',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 10,
                            );
                },
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: userService.getUserStreamById(user.email!),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (userSnapshot.hasError) {
                    return const Center(child: Text('Error loading user data'));
                  }

                  if (!userSnapshot.hasData) {
                    return const Center(child: Text('User data not found'));
                  }

                  List<DocumentSnapshot> listUser = userSnapshot.data!.docs;
                  var userData = listUser[0];
                  var transactionId = userData['transactionId'] ?? '';
                  if (transactionId.isEmpty) {
                    return const Center(
                        child: Text('Anda belum melakukan transaksi'));
                  }
                  return StreamBuilder<QuerySnapshot>(
                    stream: transactionService
                        .getTransactionStreamById(transactionId),
                    builder: (context, transactionSnapshot) {
                      if (transactionSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (transactionSnapshot.hasError) {
                        return const Center(
                            child: Text('Error loading transaction data'));
                      }

                      if (!transactionSnapshot.hasData) {
                        return const Center(
                            child: Text('Transaction not found'));
                      }

                      List<DocumentSnapshot> transactionList =
                          transactionSnapshot.data!.docs;
                      var transactionDoc = transactionList[0];
                      var durasiSewa = transactionDoc['duration'];
                      var total = transactionDoc['total_price'];
                      var metodePembayaran = transactionDoc['payment_method'];
                      var statusPembayaran = transactionDoc['status'];
                      var token = transactionDoc['snap_token'];
                      var tambahDurasi = transactionDoc['tambahDurasi'];
                      var motorRef = transactionDoc['motorId'];
                      var extendTransactionId =
                          transactionDoc['extendTransactionId'];

                      DateTime endDuration =
                          transactionDoc['endDuration'].toDate();
                      if (motorRef == null || motorRef.path.isEmpty) {
                        return const Center(
                            child: Text('Motor reference is invalid'));
                      }
                      return FutureBuilder<DocumentSnapshot>(
                        future: motorRef.get(),
                        builder: (context, motorSnapshot) {
                          if (motorSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (motorSnapshot.hasError) {
                            return const Center(
                                child: Text('Error loading motor data'));
                          }

                          if (!motorSnapshot.hasData ||
                              !motorSnapshot.data!.exists) {
                            return const Center(
                                child: Text('Motor data not found'));
                          }

                          var motorDoc = motorSnapshot.data!;
                          var motorId = motorRef.id;
                          var namaMotor = motorDoc['namaMotor'];
                          var harga = motorDoc['harga'];

                          return Column(
                            children: [
                              receipt(
                                transactionId,
                                motorId,
                                namaMotor,
                                durasiSewa,
                                harga,
                                total,
                                metodePembayaran,
                                statusPembayaran,
                                token,
                                endDuration,
                                motorId,
                                tambahDurasi,
                                extendTransactionId,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget receipt(
      String kodePemesanan,
      String motorId,
      String namaMotor,
      int durasiSewa,
      int hargaSewa,
      double total,
      String metodePembayaran,
      String statusPembayaran,
      String token,
      DateTime endDuration,
      String motorRefId,
      bool tambahDurasi,
      String extendTransactionId) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MyText(
                    text: 'Rincian Pesanan',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(Icons.access_time),
                  ),
                ],
              ),
              Divider(),
              buildDetailRow('Kode Pemesanan', kodePemesanan),
              buildDetailRow('Nama Motor', namaMotor),
              buildDetailRow('Durasi Sewa', '$durasiSewa Jam'),
              buildDetailRow(
                  'Harga Sewa',
                  NumberFormat.currency(
                          locale: 'id', decimalDigits: 0, symbol: 'Rp ')
                      .format(hargaSewa)),
              buildDetailRow(
                  'Total',
                  NumberFormat.currency(
                          locale: 'id', decimalDigits: 0, symbol: 'Rp ')
                      .format(total)),
              buildDetailRow('Metode Pembayaran', metodePembayaran),
              buildDetailRow('Status Pembayaran', statusPembayaran),
              SizedBox(height: 15),
              metodePembayaran == 'Transfer' && statusPembayaran == 'Pending'
                  ? MyButton(
                      text: 'Bayar Sekarang',
                      fontSize: 15,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPage(
                              token: token,
                              transactionId: kodePemesanan,
                            ),
                          ),
                        );
                      },
                    )
                  : statusPembayaran == 'Ongoing' &&
                          endDuration.isAfter(DateTime.now()) &&
                          tambahDurasi == false
                      ? MyButton(
                          text: 'Tambah Durasi',
                          fontSize: 15,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExtendTransactionPage(
                                    transactionId: kodePemesanan,
                                    motorId: motorRefId)),
                          ),
                        )
                      : extendTransactionId.isNotEmpty
                          ? MyButton(
                              text: 'Bayar Tambah Durasi',
                              fontSize: 15,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ExtendPaymentPage(extendTransactionId: extendTransactionId),));
                              },
                            )
                          : SizedBox()
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: title,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          MyText(
            text: value,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
