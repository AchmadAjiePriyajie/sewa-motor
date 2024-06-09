import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/Services/user_services.dart';
import 'package:sewa_motor/pages/alamat_page.dart';
import 'package:sewa_motor/pages/profile_pages/preview_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  UserService userService = UserService();
  Future<DocumentSnapshot?>? userData;

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, '/auth_page');
  }

  @override
  void initState() {
    super.initState();
    userData = userService.getUserById(user.email!);
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
                    FutureBuilder<DocumentSnapshot?>(
                      future: userData,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // Handle errors
                        }

                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator(); // Show loading indicator
                        }

                        DocumentSnapshot userDoc = snapshot.data!;
                        if (!userDoc.exists) {
                          Text(
                            user.email!,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }

                        // Extract motor data
                        String username = userDoc['username'];
                        return Text(
                          username,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ],
                )),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewProfilePage(),
                    ),
                  ),
                  leading: Icon(Icons.person),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile Settings',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                        ),
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlamatPage(),
                      ),
                    );
                  },
                  leading: Icon(Icons.home),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Alamat',
                        style: GoogleFonts.poppins(fontSize: 12),
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
        ],
      ),
    );
  }
}
