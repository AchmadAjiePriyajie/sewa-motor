import 'package:flutter/cupertino.dart';
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
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: myIndex,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: 'Receipt',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notification',
            ),
          ]),
    );
  }
}
