import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AdminPage extends StatelessWidget {
  AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [Text('Admin Page',
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),)],),
      ),
      
    );
  }
}
