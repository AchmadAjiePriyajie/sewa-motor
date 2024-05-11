import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/components/notification_message.dart';

class NotifPage extends StatelessWidget {
  NotifPage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 3,
                spreadRadius: 3,
                offset: Offset(0, 3))
          ],
        ),
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
                Icon(Icons.notifications),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Notification',
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
