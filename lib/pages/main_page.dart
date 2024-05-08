import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/components/my_textfield.dart';
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
      appBar: AppBar(
        toolbarHeight: 130,
        backgroundColor: Colors.lightBlue[800],
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile_page');
                  },
                  child: Image.asset(
                    'images/profile.png',
                    width: 40,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                      ),
                      SizedBox(
                        height: 20,
                        width: 10,
                      ),
                      Text(
                        'Cibiru',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: 
                MyTextField(
                  obscureText: false,
                  hintText: 'Search',
                  controller: searchController,
                )),
            // Container(
            //   decoration: BoxDecoration(
            //       color: Colors.white, borderRadius: BorderRadius.circular(12)),
            //   child: Row(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Icon(Icons.search),
            //       ),
            //       TextField(

            //       ),
            //       Text(
            //         'Search',
            //         style: GoogleFonts.poppins(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
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
