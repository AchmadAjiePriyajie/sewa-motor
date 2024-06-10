import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sewa_motor/Services/transaction_service.dart';
import 'package:sewa_motor/Services/user_services.dart';
import 'package:sewa_motor/components/my_button.dart';
import 'package:sewa_motor/components/my_text.dart';
import 'package:sewa_motor/pages/payment_page.dart';

class DetailTransaksi extends StatefulWidget {
  final String docId;
  const DetailTransaksi({super.key, required this.docId});

  @override
  State<DetailTransaksi> createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  Future<DocumentSnapshot?>? _transactionData; // Use a Future to hold the data
  TransactionService transactionService = TransactionService();
  UserService userService = UserService();
  final user = FirebaseAuth.instance.currentUser!;

  void initState() {
    super.initState();
    _transactionData = transactionService
        .getTransactionById(widget.docId); // Call getMotorById on init
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double imageHeight = size.height * 0.15;
    final double imageWidth = size.width * 0.25;
    final double containerPadding = size.width * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Transaksi',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue[800],
      ),
      body: SizedBox(
        height: size.height * 0.8,
        child: FutureBuilder(
          future: _transactionData,
          builder: (context, snapshot) {
            DocumentSnapshot<Object?>? data = snapshot.data;
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            String transaksi = data?['transactionId'];

            DocumentSnapshot transactionDoc = snapshot.data!;
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
                  return const Center(child: Text('Error loading motor data'));
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text('Motor data not found'));
                }

                DocumentSnapshot motorDoc = snapshot.data!;
                String namaMotor = motorDoc['namaMotor'];
                int harga = motorDoc['harga'];

                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(containerPadding),
                      margin: EdgeInsets.symmetric(horizontal: containerPadding, vertical: containerPadding),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Image.network(
                            snapshot.data?['Image'],
                            height: 100,
                            width: 100,
                          ),
                          Container(
                            width: size.width * 0.6,
                            padding: EdgeInsets.only(left: containerPadding),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      namaMotor,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'ID : ' + transaksi,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Total : ' +
                                          NumberFormat.currency(
                                                  locale: 'id',
                                                  decimalDigits: 0,
                                                  symbol: 'Rp ')
                                              .format(harga),
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          color: statusPembayaran == 'Completed'
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Text(
                                          statusPembayaran,
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(containerPadding),
                      padding: EdgeInsets.all(containerPadding),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
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
                          SizedBox(height: containerPadding),
                          MyText(
                            text: 'Kode Pemesanan',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          MyText(
                            text: transaksi,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: containerPadding),
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
                          SizedBox(height: containerPadding),
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
                          SizedBox(height: containerPadding),
                          MyText(
                            text: 'Harga Sewa',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          MyText(
                            text: NumberFormat.currency(
                                    locale: 'id',
                                    decimalDigits: 0,
                                    symbol: 'Rp ')
                                .format(harga),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: containerPadding),
                          MyText(
                            text: 'Total',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          MyText(
                            text: NumberFormat.currency(
                                    locale: 'id',
                                    decimalDigits: 0,
                                    symbol: 'Rp ')
                                .format(total),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: containerPadding),
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
                          SizedBox(height: containerPadding),
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
                          SizedBox(height: containerPadding * 1.5),
                          statusPembayaran == 'Pending' &&
                                  metodePembayaran == 'Transfer'
                              ? MyButton(
                                  text: 'Bayar Sekarang',
                                  fontSize: 15,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaymentPage(
                                          token: token,
                                          transactionId: transaksi,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
