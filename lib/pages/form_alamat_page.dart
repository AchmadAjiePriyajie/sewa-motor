import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/Services/alamat_services.dart';
import 'package:sewa_motor/components/my_button.dart';
import 'package:sewa_motor/pages/alamat_page.dart';
import 'package:sewa_motor/pages/transaction_page.dart';

class FormAlamatPage extends StatefulWidget {
  final String? docId;
  final String? motorId;
  const FormAlamatPage({
    super.key,
    this.docId,
    this.motorId
  });

  @override
  State<FormAlamatPage> createState() => _FormAlamatPageState();
}

class _FormAlamatPageState extends State<FormAlamatPage> {
  final _formKey = GlobalKey<FormState>();
  AlamatServices alamatServices = AlamatServices();
  String? provinsi = 'Banten', kota, kecamatan, kodePos, detailAlamat;
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController provinsiController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController kecamatanController = TextEditingController();
  TextEditingController kodePosController = TextEditingController();
  TextEditingController detailAlamatController = TextEditingController();
  Future<DocumentSnapshot>? alamatDoc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.docId != null && widget.docId != 'form') {
      alamatDoc = AlamatServices().getAlamatStreamById(widget.docId!);
    }
  }

  Widget form(String? provinsi, String? kota, String? kecamatan,
      String? kodePos, String? detailAlamat) {
    if (provinsi != null &&
        kota != null &&
        kecamatan != null &&
        kodePos != null &&
        detailAlamat != null) {
      provinsiController.text = provinsi;
      kotaController.text = kota;
      kecamatanController.text = kecamatan;
      kodePosController.text = kodePos;
      detailAlamatController.text = detailAlamat;
    }
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Provinsi',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Provinsi tidak boleh kosong';
                  }
                  return null;
                },
                controller: provinsiController,
                onSaved: (newValue) => provinsi = newValue,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Kota',
                ),
                controller: kotaController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kota tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (newValue) => kota = newValue,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Kecamatan',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kecamatan tidak boleh kosong';
                  }
                  return null;
                },
                controller: kecamatanController,
                onSaved: (newValue) => kecamatan = newValue,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Kode Pos',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kode Pos tidak boleh kosong';
                  }
                  return null;
                },
                controller: kodePosController,
                onSaved: (newValue) => kodePos = newValue,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Detail Alamat',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Detail Alamat tidak boleh kosong';
                  }
                  return null;
                },
                controller: detailAlamatController,
                onSaved: (newValue) => detailAlamat = newValue,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                  text: 'Submit',
                  fontSize: 14,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      if (widget.docId != null && widget.docId != 'form') {
                        alamatServices.updateAlamat(widget.docId!, provinsi!,
                            kota!, kecamatan!, kodePos!, detailAlamat!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlamatPage(),
                          ),
                        );
                      } else {
                        alamatServices.addAlamat(provinsi!, kota!, kecamatan!,
                            kodePos!, detailAlamat!, user.email!);
                        if (widget.docId == 'form') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionPage(motorId: widget.motorId!,),
                            ),
                          );
                        }else{
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlamatPage(),
                          ),
                        );
                        }
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ));
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.docId != null && widget.docId != 'form'
                ? FutureBuilder(
                    future: alamatDoc,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(child: Text('Error loading'));
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const Center(
                            child: Text('Motor data not found'));
                      }
                      var aData = snapshot.data!;
                      var _provinsi = aData['provinsi'];
                      var _kota = aData['kota'];
                      var _kecamatan = aData['kecamatan'];
                      var _kodePos = aData['kodePos'];
                      var _detailAlamat = aData['detailAlamat'];
                      return form(_provinsi, _kota, _kecamatan, _kodePos,
                          _detailAlamat);
                    },
                  )
                : form(null, null, null, null, null),
          ],
        ),
      ),
    );
  }
}
