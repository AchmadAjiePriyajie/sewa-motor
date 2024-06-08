import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/Services/alamat_services.dart';
import 'package:sewa_motor/Services/user_services.dart';
import 'package:sewa_motor/components/my_button.dart';
import 'package:sewa_motor/pages/form_alamat_page.dart';

class AlamatPage extends StatefulWidget {
  const AlamatPage({super.key});

  @override
  State<AlamatPage> createState() => _AlamatPageState();
}

class _AlamatPageState extends State<AlamatPage> {
  AlamatServices alamatServices = AlamatServices();
  final user = FirebaseAuth.instance.currentUser!;
  Future<DocumentSnapshot?>? userData;

  @override
  void initState() {
    super.initState();
    userData = UserService().getUserById(user.email!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        title: Text(
          'Alamat',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          MyButton(
            text: 'Tambah Alamat',
            fontSize: 14,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormAlamatPage(),
                ),
              );
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error loading address data'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('Address not found'));
                }

                DocumentSnapshot userDoc = snapshot.data!;
                String email = userDoc['email'];

                return StreamBuilder(
                  stream: alamatServices.getAlamatStream(email),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error loading address data'));
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: Text('Address not found'));
                    }

                    List<DocumentSnapshot> alamatList = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: alamatList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = alamatList[index];
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        var docId = document.id;
                        var detailAlamat = data['detailAlamat'];
                        var provinsi = data['provinsi'];
                        var kota = data['kota'];
                        var kecamatan = data['kecamatan'];
                        var kodePos = data['kodePos'];

                        return Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      detailAlamat,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${kecamatan}, Kota ${kota}, ${provinsi}, ${kodePos}',
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FormAlamatPage(docId: docId),
                                        ),
                                      );
                                    },
                                    child: Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
