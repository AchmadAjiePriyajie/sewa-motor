import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/Services/motor_services.dart';
import 'package:sewa_motor/components/my_button.dart';

class ProductPage extends StatefulWidget {
  final String docID;
  const ProductPage({super.key, required this.docID});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<DocumentSnapshot?>? _motorData; // Use a Future to hold the data
  MotorService motorService = MotorService();

  @override
  void initState() {
    super.initState();
    _motorData =
        motorService.getMotorById(widget.docID); // Call getMotorById on init
  }

  Row addText(String text) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 15),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[700],
        title: Row(
          children: [
            Text(
              'Produk',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot?>(
          future: _motorData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Handle errors
            }

            if (!snapshot.hasData) {
              return const CircularProgressIndicator(); // Show loading indicator
            }

            DocumentSnapshot motorDoc = snapshot.data!;
            if (!motorDoc.exists) {
              return const Text('Motor not found'); // Handle non-existent motor
            }

            // Extract motor data
            String namaMotor = motorDoc['namaMotor'];
            int kapasitasMesin = motorDoc['kapasitas_mesin'];
            int harga = motorDoc['harga'];
            String merk = motorDoc['merk'];
            String imageUrl = motorDoc['Image'];
            // Display motor details
            return Column(
              children: [
                Center(
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          height: 320,
                          width: 300,
                        ) // Display image
                      : const Text('No image available'),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        namaMotor,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Rp.'+ harga.toString() +' / Jam',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightBlue[700],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Column(
                    children: [
                      Divider(),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Detail Produk',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      addText('Merek        : ' + merk),
                      addText('Seri            : ' + namaMotor),
                      addText('Kapasitas : ' + kapasitasMesin.toString() + ' cc'),
                      Divider(),
                      SizedBox(
                        height: 150,
                      ),
                      MyButton(
                          text: "Pesan Sekarang", fontSize: 13, onTap: () {}),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
