import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.close,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Column(
            children: [
              Icon(
                Icons.person,
                size: 60,
              ),
              Text(
                user.email!,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
          Center(
            child: Container(
              width: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 3,
                    offset: Offset(0.5, 1),
                  )
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: logout,
                    leading: Icon(Icons.logout),
                    title: Text(
                      'Logout',
                      style: GoogleFonts.poppins(),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
