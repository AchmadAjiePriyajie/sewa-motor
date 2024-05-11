import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProduct extends StatelessWidget {
  final String images;
  final String text;
  final String route;

  const MyProduct({
    super.key,
    required this.images,
    required this.text,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        margin: EdgeInsets.only(top: 15, left: 15,bottom: 15),
        padding: EdgeInsets.all(10),
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
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text('100.000 / Day',
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w400
            ),)
          ],
        ),
      ),
    );
  }
}
