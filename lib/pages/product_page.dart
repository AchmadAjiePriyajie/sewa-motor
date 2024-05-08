import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              'images/aerox1.png',
              width: 300,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                'Rp. 100.000 / Jam',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
            indent: 10,
            endIndent: 10,
            color: Colors.grey,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                'Aerox Standart',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
