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
  ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final user = FirebaseAuth.instance.currentUser!;
  TransactionService transactionService = TransactionService();
  UserService userService = UserService();
  MotorService motorService = MotorService();
  String? _transactionId;
  // Future<DocumentSnapshot?>? _transactionData;
  // Future<DocumentSnapshot?>? _userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userService
        .getUserById(user.email!)
        .then((value) => {_transactionId = value['transactionId']!});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue[600],
        toolbarHeight: 70,
        title: Column(
          children: [
            Row(
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot?>(
          future: userService.getUserById(user.email!),
          builder: (context, snapshot) {
            return FutureBuilder<DocumentSnapshot?>(
              future: transactionService
                  .getTransactionById(snapshot.data!['transactionId']),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    'Anda belum melakukan transaksi',
                  ); // Handle errors
                }

                if (!snapshot.hasData) {
                  return const CircularProgressIndicator(); // Show loading indicator
                }

                DocumentSnapshot transactionDoc = snapshot.data!;
                if (!transactionDoc.exists) {
                  return const Text(
                    'Transaction not found',
                  ); // Handle non-existent motor
                }
                String transactionId = transactionDoc['transactionId'];
                int durasiSewa = transactionDoc['duration'];
                double total = transactionDoc['total_price'];
                String metodePembayaran = transactionDoc['payment_method'];
                String statusPembayaran = transactionDoc['status'];
                String token = transactionDoc['snap_token'];

                DocumentReference motorData = transactionDoc['motorId'];
                return FutureBuilder(
                  future: motorData.get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    return receipt(
                      transactionId,
                      snapshot.data!['namaMotor'],
                      durasiSewa,
                      snapshot.data!['harga'],
                      total,
                      metodePembayaran,
                      statusPembayaran,
                      token,
                    );
                  },
                );
              },
            );
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
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: MyText(
                      text: '00',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: MyText(
                      text: '00',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: MyText(
                      text: '00',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  MyText(
                      text: 'Kode Pemesanan',
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ],
              ),
              Row(
                children: [
                  MyText(
                      text: kodePemesanan,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MyText(
                      text: 'Nama Motor',
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ],
              ),
              Row(
                children: [
                  MyText(
                      text: namaMotor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MyText(
                      text: 'Durasi Sewa',
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ],
              ),
              Row(
                children: [
                  MyText(
                    text: '${durasiSewa.toString()} jam',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MyText(
                      text: 'Harga Sewa',
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ],
              ),
              Row(
                children: [
                  MyText(
                      text: 'Rp.${hargaSewa.toString()}',
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MyText(
                    text: 'Total',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Row(
                children: [
                  MyText(
                      text: 'Rp.${total.toString()}',
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MyText(
                      text: 'Metode Pembayaran',
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ],
              ),
              Row(
                children: [
                  MyText(
                      text: metodePembayaran,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  MyText(
                      text: 'Status Pembayaran',
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ],
              ),
              Row(
                children: [
                  MyText(
                      text: statusPembayaran,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              MyButton(
                text: 'Pesan Sekarang',
                fontSize: 15,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          token: token,
                          transactionId: _transactionId!,
                        ),
                      ));
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
