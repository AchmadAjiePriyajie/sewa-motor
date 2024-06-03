import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/Services/motor_services.dart';
import 'package:sewa_motor/pages/product_page.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      shadowColor: Colors.grey,
      primaryColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return StreamBuilder<QuerySnapshot>(
      stream: MotorService().getMotorStream(true),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        var motors = snapshot.data!.docs;
        var suggestions = motors.where((doc) {
          var motor = doc.data() as Map<String, dynamic>;
          return motor['namaMotor']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();

        if (suggestions.isEmpty) {
          return Container();
        }

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            var motor = suggestions[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(
                motor['namaMotor'],
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                query = motor['namaMotor'];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(
                      docID: suggestions[index].id,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: MotorService().getMotorStream(true),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        var motors = snapshot.data!.docs;
        var results = motors.where((doc) {
          var motor = doc.data() as Map<String, dynamic>;
          return motor['namaMotor']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            var motor = results[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(
                motor['namaMotor'],
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
