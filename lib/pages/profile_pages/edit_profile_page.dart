import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sewa_motor/Services/user_services.dart';
import 'package:sewa_motor/components/my_button.dart';
import 'package:sewa_motor/components/my_text.dart';
import 'package:sewa_motor/components/my_textfield.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController namaLengkapController = TextEditingController();
    TextEditingController nomorWAController = TextEditingController();

    UserService userService = UserService();
    var user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[700],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
            stream: userService.getUserStreamById(user.email!),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox();
              }
              List<DocumentSnapshot> userList = snapshot.data!.docs;
              var userData = userList[0];
              String namaLengkap = userData['username'];
              String noWA = userData['nomor_wa'];
              namaLengkapController.text = namaLengkap;
              nomorWAController.text = noWA;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Profil',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildInputSection('Nama Lengkap', namaLengkapController),
                  buildInputSection('Nomor WA', nomorWAController),
                  SizedBox(
                    height: 15,
                  ),
                  MyButton(
                      text: 'Simpan',
                      fontSize: 15,
                      onTap: () {
                        userService.updateUserById(user.email!,
                            namaLengkapController.text, nomorWAController.text);
                        Navigator.pop(context);
                      }),
                ],
              );
            }),
      ),
    );
  }

  Widget buildInputSection(String labelText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: labelText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          height: 10,
        ),
        MyTextField(
          obscureText: false,
          hintText: '',
          controller: controller,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
