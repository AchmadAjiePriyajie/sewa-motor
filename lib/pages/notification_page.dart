import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/Services/notification_services.dart';
import 'package:sewa_motor/Services/user_services.dart';
import 'package:sewa_motor/components/notification_message.dart';
import 'package:sewa_motor/pages/detail_transaksi.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({super.key});

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  final user = FirebaseAuth.instance.currentUser!;

  UserService userService = UserService();

  final TextEditingController searchController = TextEditingController();

  Future<DocumentSnapshot?>? userData;

  @override
  void initState() {
    super.initState();
    userData = userService.getUserById(user.email!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue[800],
        toolbarHeight: 70,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Notification',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile_page');
                  },
                  child: Image.asset(
                    'images/profile.png',
                    width: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        height: 600,
        margin: EdgeInsets.only(top: 20,left: 20,right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.5))),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.watch_later_outlined),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Terkini',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Column(
              children: [
                FutureBuilder<DocumentSnapshot?>(
                  future: userData,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Handle errors
                    }

                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator(); // Show loading indicator
                    }

                    DocumentSnapshot userDoc = snapshot.data!;

                    // Extract motor data
                    String email = userDoc['email'];
                    return Container(
                      height:
                          550, // Set a fixed height for the new product section
                      child: StreamBuilder<QuerySnapshot>(
                          stream: NotificationServices().getNotifStream(email),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<DocumentSnapshot> notifList =
                                  snapshot.data!.docs;
                              return ListView.builder(
                                itemCount: notifList.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot document = notifList[index];
                                  Map<String, dynamic> data =
                                      document.data() as Map<String, dynamic>;
                                  String title = data['title'];
                                  String message = data['message'];
                                  String transactionId = data['transactionId'];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailTransaksi(docId: transactionId),
                                        ),
                                      );
                                    },
                                    child: NotifMessage(
                                        title: title, message: message),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              print(snapshot.error);
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
