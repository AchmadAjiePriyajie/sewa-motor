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
        backgroundColor: Colors.lightBlue[700],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(color: Colors.lightBlue[700]),
                child: Center(
                    child: Column(
                  children: [
                    Image.asset(
                      'images/profile.png',
                      width: 100,
                    ),
                    Text(
                      user.email!,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: Container(
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
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
                      onTap: () {
                        
                      },
                      leading: Icon(Icons.person),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Profile Settings',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              
                            )
                          ),
                          Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: logout,
                      leading: Icon(Icons.logout),
                      title: Text(
                        'Logout',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}