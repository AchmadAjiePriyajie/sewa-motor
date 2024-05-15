import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/components/notification_message.dart';

class NotifPage extends StatelessWidget {
  NotifPage({super.key});

  final TextEditingController searchController = TextEditingController();

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
                Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      'Notification',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
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
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.5))),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.watch_later_outlined),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Terkini',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Column(
              children: [
                NotifMessage(
                  title: 'Horee! Pesanan kamu udah berhasil nih ',
                  message:
                      'Pesanan IIXXQDJDKDDJD sudah dikonfirmasi pada tanggal 31/03/2024',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
