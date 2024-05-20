import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/Services/motor_services.dart';
import 'package:sewa_motor/components/my_button.dart';
import 'package:sewa_motor/components/my_text.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  MotorService motorService = MotorService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
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
                    width: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
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
                        text: 'IIXXQDJDKDDJD',
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
                        text: 'Nama Pesanan',
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                Row(
                  children: [
                    MyText(
                        text: 'Aerox Standart',
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
                        text: '6 Jam',
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
                        text: 'Harga Sewa',
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                Row(
                  children: [
                    MyText(
                        text: 'Rp.35.000 / Jam',
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
                        fontWeight: FontWeight.w500),
                  ],
                ),
                Row(
                  children: [
                    MyText(
                        text: 'Rp.210.000',
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
                        text: 'Transfer',
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
                        text: 'Selesai',
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
                        text: 'Bukti Pembayaran',
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Klik disini untuk melihat ',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue[600],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                MyButton(
                  text: 'Pesan Sekarang',
                  fontSize: 15,
                  onTap: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
