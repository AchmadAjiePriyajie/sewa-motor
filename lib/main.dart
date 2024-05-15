import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sewa_motor/auth/auth.dart';
import 'package:sewa_motor/firebase_options.dart';
import 'package:sewa_motor/pages/home_page.dart';
import 'package:sewa_motor/pages/login_page.dart';
import 'package:sewa_motor/pages/profile_page.dart';
import 'package:sewa_motor/pages/register_page.dart';
import 'package:sewa_motor/pages/merk_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      routes: {
        '/login_page': (context) => LoginPage(),
        '/register_page': (context) => RegisterPage(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/auth_page': (context) => AuthPage(),
        '/merk_page': (context) => MerkPage(),
      },
    );
  }
}
