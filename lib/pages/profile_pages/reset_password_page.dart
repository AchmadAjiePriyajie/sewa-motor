import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sewa_motor/components/my_button.dart';
import 'package:sewa_motor/components/my_text.dart';
import 'package:sewa_motor/components/my_textfield.dart';

class ResetPasswordpage extends StatefulWidget {
  final String? email;
  const ResetPasswordpage({super.key, this.email});

  @override
  State<ResetPasswordpage> createState() => _ResetPasswordpageState();
}

class _ResetPasswordpageState extends State<ResetPasswordpage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =
        TextEditingController(text: widget.email ?? '');
    Future resetPassword() async {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              'Link pemulihan password sudah di kirim ke email anda',
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              e.message.toString(),
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[700],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyText(
              text: widget.email == null ? 'Masukkan email anda' : 'Email anda',
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 10,
            ),
            widget.email == null
                ? MyTextField(
                    obscureText: false,
                    hintText: '',
                    controller: emailController,
                  )
                : Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 0.5),
                    ),
                    child: Text(widget.email!),
                  ),
            SizedBox(
              height: 15,
            ),
            MyButton(
                text: 'Konfirmasi',
                fontSize: 14,
                onTap: () {
                  resetPassword();
                }),
          ],
        ),
      ),
    );
  }
}
