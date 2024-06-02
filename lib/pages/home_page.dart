import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sewa_motor/Services/motor_services.dart';
import 'package:sewa_motor/components/my_text.dart';
import 'package:sewa_motor/pages/merk_page.dart';
import 'package:sewa_motor/pages/product_page.dart';
import 'package:sewa_motor/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MotorService motorService = MotorService();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     color: Colors.white,
            //   ),
            //   child: MyTextField(
            //     obscureText: false,
            //     hintText: 'Search',
            //     controller: searchController,
            //     height: 40,
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: Search());
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.search),
                    ),
                    Text(
                      'Search',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Wrap the body with SingleChildScrollView
        child: Column(
          children: [
            // Container Merk
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.8))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Bar Yamaha
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MerkPage(merkId: 'Yamaha'),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              right: 14, left: 14, top: 15, bottom: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Column(
                            children: [
                              Image.asset(
                                'images/yamaha.png',
                                width: 39,
                              ),
                              Text(
                                'Yamaha',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      //Bar Honda
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MerkPage(merkId: 'Honda'),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, right: 20, left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Column(
                            children: [
                              Image.asset(
                                'images/honda.png',
                                width: 39,
                              ),
                              Text(
                                'Honda',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      //Vespa
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MerkPage(merkId: 'Vespa'),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, left: 20, right: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Column(
                            children: [
                              Image.asset(
                                'images/vespa.png',
                                width: 39,
                              ),
                              Text(
                                'Vespa',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Produk Terbaru',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),

            SizedBox(height: 10), // Add some spacing between sections

            // Newf Product Section
            Container(
              height: 220, // Set a fixed height for the new product section
              child: StreamBuilder<QuerySnapshot>(
                  stream: motorService.getMotorStream(true),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> motorList = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: motorList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document = motorList[index];
                          String docID = document.id;
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String namaMotor = data['namaMotor'];
                          int harga = data['harga'];
                          String imageUrl = data['Image'];
                          int totalPenjualan = data['totalPenjualan'];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                    docID: docID,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 15, right: 8, top: 10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.8)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 170,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: namaMotor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MyText(
                                              text: NumberFormat.currency(
                                                          locale: 'id',
                                                          decimalDigits: 0,
                                                          symbol: 'Rp ')
                                                      .format(harga) +
                                                  '/Jam',
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                MyText(
                                                  text:
                                                      '${totalPenjualan} tersewa',
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            SizedBox(height: 10), // Add some spacing between sections

            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Produk Populer',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),

            SizedBox(height: 10), // Add some spacing between sections

            // Popular Product Section
            Container(
              height: 220, // Set a fixed height for the popular product section
              child: StreamBuilder<QuerySnapshot>(
                  stream: motorService.getMotorStreamBySales(false),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> motorList = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: motorList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document = motorList[index];
                          String docID = document.id;
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String namaMotor = data['namaMotor'];
                          int harga = data['harga'];
                          String imageUrl = data['Image'];
                          int totalPenjualan = data['totalPenjualan'];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                    docID: docID,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 15, right: 8, top: 10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.8)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 170,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: namaMotor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MyText(
                                              text: NumberFormat.currency(
                                                          locale: 'id',
                                                          decimalDigits: 0,
                                                          symbol: 'Rp ')
                                                      .format(harga) +
                                                  '/Jam',
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                MyText(
                                                  text:
                                                      '${totalPenjualan} tersewa',
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
