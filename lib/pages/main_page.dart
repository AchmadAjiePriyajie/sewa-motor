import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sewa_motor/pages/home_page.dart';
import 'package:sewa_motor/pages/notification_page.dart';
import 'package:sewa_motor/pages/receipt_page.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _HomePageState();
}

class _HomePageState extends State<MainPage> {
  final TextEditingController searchController = TextEditingController();
  int myIndex = 0;
  final tabs = [
    Center(child: HomePage()),
    Center(child: ReceiptPage()),
    Center(child: NotifPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[myIndex],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Colors.lightBlue[600]!,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.receipt,
              color: Colors.white,
            ),
            Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ]),
    );
  }
}
