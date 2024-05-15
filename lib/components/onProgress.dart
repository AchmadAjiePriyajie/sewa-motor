import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sewa_motor/components/popup_message.dart';

class OnProgress extends StatefulWidget {
  const OnProgress({super.key});

  @override
  State<OnProgress> createState() => _OnProgressState();
}

class FirestoreServices {
  final CollectionReference Motor =
      FirebaseFirestore.instance.collection('Motor');

  Future<void> addMotor(String motor, String warna, String harga) {
    return Motor.add({
      'Motor': motor,
      'Warna': warna,
      'Harga': harga,
    });
  }

  static getMotor() {}

  static getMotorStream() {}
}


class _OnProgressState extends State<OnProgress> {
  final FirestoreServices firestoreServices = FirestoreServices();
  final TextEditingController namamotor = TextEditingController();
  final TextEditingController warna = TextEditingController();
  final TextEditingController harga = TextEditingController();

  void addProduct() async {
    if (namamotor != "" && warna != "" && harga != "") {
      firestoreServices.addMotor(
        namamotor.text,
        warna.text,
        harga.text,
      );
      namamotor.clear();
      warna.clear();
      harga.clear();
      Navigator.pop(context);
    }else{
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            namamotor.clear();
                            warna.clear();
                            harga.clear();
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Text(
                        'Add Product',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Text('Nama Motor'),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: namamotor,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        displayMessageToUser('Please Input the value', context);
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Text('Warna'),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: warna,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        displayMessageToUser('Please Input the value', context);
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Text('Harga'),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: harga,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        displayMessageToUser('Please Input the value', context);
                      }
                      return null;
                    },
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      addProduct();
                    },
                    child: Text('Add'))
              ],
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(0, 3))
            ],
          ),
          child: Text(
            'On Progress',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
