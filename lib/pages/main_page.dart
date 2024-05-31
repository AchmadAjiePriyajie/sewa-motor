import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sewa_motor/pages/home_page.dart';
import 'package:sewa_motor/pages/notification_page.dart';
import 'package:sewa_motor/pages/receipt_page.dart';

class MainPage extends StatefulWidget {
  final int? bottomNavIdx;
  const MainPage({super.key, this.bottomNavIdx});

  @override
  State<MainPage> createState() => _HomePageState();
}

class _HomePageState extends State<MainPage> {
  final TextEditingController searchController = TextEditingController();
  int myIndex = 0;
  @override
  void initState() {
    super.initState();
    if (widget.bottomNavIdx != null) {
      myIndex = widget.bottomNavIdx!;
    }
  }

  final tabs = [
    const Center(child: HomePage()),
    Center(child: ReceiptPage()),
    Center(child: NotifPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[myIndex],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Colors.lightBlue[800]!,
          animationDuration: const Duration(milliseconds: 300),
          index: myIndex,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          items: [
            const Icon(
              Icons.home,
              color: Colors.white,
            ),
            const Icon(
              Icons.receipt,
              color: Colors.white,
            ),
            const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ]),
    );
  }
}
