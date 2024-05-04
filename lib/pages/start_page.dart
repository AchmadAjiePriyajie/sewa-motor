import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/components/my_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Text(
                'SETOR',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.lightBlue[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                'Sewa Motor',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.lightBlue[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Center(
            child: Image.asset(
              'images/aerox.png',
              width: 420,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            'Temukan Motor',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Text(
              textAlign: TextAlign.center,
              '"Yuk, jelajahi destinasi favoritmu dengan nyaman dan bebas bersama kami! Sewa motor sekarang dan nikmati petualangan tanpa batas!"',
              style: GoogleFonts.poppins(
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          MyButton(
            text: 'Mulai Sekarang',
            fontSize: 20,
            onTap: () {
              Navigator.pushNamed(context, '/login_page');
            },
          )
        ],
      ),
    );
  }
}
