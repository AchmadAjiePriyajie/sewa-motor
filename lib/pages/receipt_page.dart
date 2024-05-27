import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/Services/motor_services.dart';
import 'package:sewa_motor/Services/transaction_service.dart';
import 'package:sewa_motor/Services/user_services.dart';
import 'package:sewa_motor/components/my_button.dart';
import 'package:sewa_motor/components/my_text.dart';
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
        backgroundColor: Colors.lightBlue[600],
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Receipt',
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
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
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot?>(
          future: userService.getUserById(user.email!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Error loading user data'));
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('User data not found'));
            }

            DocumentSnapshot _userData = snapshot.data!;
            String transactionId = _userData['transactionId'];
            if (transactionId.isNotEmpty) {
              return FutureBuilder<DocumentSnapshot?>(
                future: transactionService.getTransactionById(transactionId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error loading transaction data'));
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(child: Text('Transaction not found'));
                  }

                  DocumentSnapshot transactionDoc = snapshot.data!;
                  String transactionId = transactionDoc['transactionId'];
                  int durasiSewa = transactionDoc['duration'];
                  double total = transactionDoc['total_price'];
                  String metodePembayaran = transactionDoc['payment_method'];
                  String statusPembayaran = transactionDoc['status'];
                  String token = transactionDoc['snap_token'];

                  DocumentReference motorRef = transactionDoc['motorId'];
                  return FutureBuilder<DocumentSnapshot?>(
                    future: motorRef.get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Error loading motor data'));
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const Center(
                            child: Text('Motor data not found'));
                      }

                      DocumentSnapshot motorDoc = snapshot.data!;
                      String namaMotor = motorDoc['namaMotor'];
                      int harga = motorDoc['harga'];

                      return receipt(
                        transactionId,
                        namaMotor,
                        durasiSewa,
                        harga,
                        total,
                        metodePembayaran,
                        statusPembayaran,
                        token,
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(
                  child: Text('Anda belum melakukan transaksi'));
            }
          },
        ),
      ),
    );
  }

  Widget receipt(
    String kodePemesanan,
    String namaMotor,
    int durasiSewa,
    int hargaSewa,
    double total,
    String metodePembayaran,
    String statusPembayaran,
    String token,
  ) {
    return Column(
      children: [
        Container(
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
                  timeBox('00'),
                  timeBox('00'),
                  timeBox('00'),
                ],
              ),
            ],
          ),
        ),
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
              SizedBox(height: 10),
              MyText(
                text: 'Kode Pemesanan',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              MyText(
                text: kodePemesanan,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10),
              MyText(
                text: 'Nama Motor',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              MyText(
                text: namaMotor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10),
              MyText(
                text: 'Durasi Sewa',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              MyText(
                text: '$durasiSewa jam',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10),
              MyText(
                text: 'Harga Sewa',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              MyText(
                text: 'Rp.$hargaSewa',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10),
              MyText(
                text: 'Total',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              MyText(
                text: 'Rp.$total',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10),
              MyText(
                text: 'Metode Pembayaran',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              MyText(
                text: metodePembayaran,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10),
              MyText(
                text: 'Status Pembayaran',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              MyText(
                text: statusPembayaran,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 15),
              MyButton(
                disabled: metodePembayaran != 'Transfer',
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget timeBox(String time) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: MyText(
        text: time,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
