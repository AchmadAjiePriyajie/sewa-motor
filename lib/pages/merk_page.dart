import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/Services/motor_services.dart';
import 'package:sewa_motor/components/my_text.dart';
import 'package:sewa_motor/pages/product_page.dart';


class MerkPage extends StatefulWidget {
  const MerkPage({super.key});

  @override
  State<MerkPage> createState() => _MerkPageState();
}

class _MerkPageState extends State<MerkPage> {
  MotorService motorService = MotorService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yamaha',
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
                stream: motorService.getMerkStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> motorList = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: motorList.length,
                      scrollDirection: Axis.vertical,
                      
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = motorList[index];
                        String docID = document.id;
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String namaMotor = data['namaMotor'];
                        int harga = data['harga'];
                        String imageUrl = data['Image'];
                        return Container(
                          padding: EdgeInsets.only(left: 15, right: 8, top: 10),
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.8)),
                          ),
                          child: Column(
                            children: [
                              InkWell(
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
                                  margin: EdgeInsets.all(10),
                                  child: imageUrl.isNotEmpty
                                      ? Image.network(
                                          imageUrl,
                                          height: 120,
                                          width: 120,
                                        ) // Display image
                                      : const Text('No image available'),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 8),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Text(
                                      namaMotor,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    MyText(
                                      text: 'Rp.' + harga.toString() + ' / Jam',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Text(
                      'Belum ada motor',
                    );
                  }
                }),
          ),
    );
  }
}
