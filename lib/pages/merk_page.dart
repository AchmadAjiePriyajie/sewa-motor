import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MerkPage extends StatelessWidget {
  MerkPage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yamaha',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlue[700],
      ),
      body: GestureDetector(
      )
    );
  }
}
