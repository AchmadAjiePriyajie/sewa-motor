import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/Services/motor_services.dart';
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
      body: StreamBuilder<QuerySnapshot>(
        stream: MotorService().getMotorStreamByMerk(merkId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> motorList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: motorList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = motorList[index];
                String docID = document.id;

                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                String namaMotor = data['namaMotor'];
                int harga = data['harga'];
                String imageUrl = data['Image'];
                // Customize the widget to display motor information
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(docID: docID),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(namaMotor),
                        subtitle: Text('Rp.${harga}/jam'),
                        leading: Image.network(
                          imageUrl,
                        ), // Assuming imageUrl points to a valid image URL
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          // Show a loading indicator while waiting for data
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
