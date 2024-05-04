import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProduct extends StatelessWidget {
  final String images;
  final String text;
  
  const MyProduct({
    super.key,
    required this.images,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // shadow color
            spreadRadius: 3, // spread radius
            blurRadius: 3, // blur radius
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            images,
            width: 150,
          ),
          Text(
            text,
            style:
                GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
