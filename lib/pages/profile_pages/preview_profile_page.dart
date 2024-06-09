import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sewa_motor/Services/user_services.dart';
import 'package:sewa_motor/components/my_button.dart';
import 'package:sewa_motor/components/my_text.dart';
import 'package:sewa_motor/pages/profile_pages/edit_profile_page.dart';
import 'package:sewa_motor/pages/profile_pages/reset_password_page.dart';

class PreviewProfilePage extends StatelessWidget {
  const PreviewProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserService userService = UserService();
    var user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[700],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userService.getUserStreamById(user.email!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox();
          }
          List<DocumentSnapshot> userList = snapshot.data!.docs;
          var userData = userList[0];
          String namaLengkap = userData['username'];
          String noWA = userData['nomor_wa'];
          return Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: MyText(
                    text: 'Profilku',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                myReusableWidget('Nama Lengkap', namaLengkap),
                myReusableWidget('Email', user.email!),
                myReusableWidget('Nomor WA', noWA),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordpage(
                        email: user.email,
                      ),
                    ),
                  ),
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MyButton(
                  text: 'Perbarui Profil',
                  fontSize: 14,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget myReusableWidget(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyText(
          text: title,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.25),
          ),
          child: MyText(
            text: content,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
