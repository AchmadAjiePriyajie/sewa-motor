import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sewa_motor/Services/motor_services.dart';
import 'package:sewa_motor/components/my_text.dart';
import 'package:sewa_motor/pages/product_page.dart';

class MerkPage extends StatelessWidget {
  final String merkId;
  MerkPage({super.key, required this.merkId});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          merkId,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlue[700],
      ),
      body: Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: MotorService().getMotorStreamByMerk(merkId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> motorList = snapshot.data!.docs;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.89,
                ),
                padding: EdgeInsets.all(10),
                itemCount: motorList.length,
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
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.withOpacity(0.8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.fitHeight
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          MyText(
                            text: namaMotor,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
