import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/Services/alamat_services.dart';
import 'package:sewa_motor/Services/midtrans_services.dart';
import 'package:sewa_motor/Services/motor_services.dart';
import 'package:sewa_motor/Services/notification_services.dart';
import 'package:sewa_motor/Services/transaction_service.dart';
import 'package:sewa_motor/Services/user_services.dart';
import 'package:sewa_motor/components/my_button.dart';
import 'package:sewa_motor/components/my_textfield.dart';
import 'package:sewa_motor/pages/form_alamat_page.dart';
import 'package:sewa_motor/pages/main_page.dart';

class TransactionPage extends StatefulWidget {
  final String motorId;
  const TransactionPage({
    super.key,
    required this.motorId,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isPressed = false;
  TextEditingController durasiController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TransactionService transactionService = TransactionService();
  NotificationServices notificationServices = NotificationServices();

  String selectedMethod = metodePembayaran.first;
  String selectedPengambilan = metodePengambilan.first;
  String? selectedAddress;

  MotorService motorService = MotorService();
  Future<DocumentSnapshot?>? _motorData;
  final user = FirebaseAuth.instance.currentUser!;
  UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    _motorData = motorService.getMotorById(widget.motorId);
  }

  void createTransaction() async {
    DocumentSnapshot? mData = await _motorData;
    String address = selectedAddress ?? '';
    int duration = int.parse(durasiController.text);
    int harga = mData?['harga'];
    double totalPrice = harga * duration.toDouble();

    String transactionID = await transactionService.createTransaction(
      user.email!,
      widget.motorId,
      duration,
      selectedMethod,
      totalPrice,
      address,
    );
    notificationServices.addNotif(
        'Horee! Pesanan Kamu Berhasil nih',
        'Pesanan $transactionID Telah dibuat, Silahkan lanjutkan transaksi',
        user.email!,
        transactionID);

    userService.updateUserTransctionId(user.email!, transactionID);
    if (selectedMethod == 'Transfer') {
      String snapToken = await MidtransService.createTransaction({
        'transaction_details': {
          'order_id': transactionID,
          'gross_amount': totalPrice
        }
      });

      motorService.updateMotorStatus(widget.motorId, true);
      transactionService.updateSnapById(transactionID, snapToken);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            bottomNavIdx: 1,
          ),
        ),
      );
    } else {
      motorService.updateMotorStatus(widget.motorId, true);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            bottomNavIdx: 1,
          ),
        ),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[600],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[600],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'SETOR',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    'Sewa Motor',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          'Form Pemesanan',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Metode Pengambilan',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                        items: metodePengambilan
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                                  child: Text(
                                    e,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        value: selectedPengambilan,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPengambilan = newValue!;
                          });
                        },
                      ),
                      selectedPengambilan == 'di antar'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Alamat Lengkap',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: AlamatServices().getAlamatStream(user.email!),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    }

                                    if (snapshot.hasError) {
                                      return const Center(child: Text('Error loading addresses'));
                                    }

                                    List<DropdownMenuItem<String>> addressItems = snapshot.hasData && snapshot.data!.docs.isNotEmpty
                                      ? snapshot.data!.docs.map((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                          String address = data['detailAlamat'];
                                          return DropdownMenuItem<String>(
                                            value: address,
                                            child: Container(
                                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                                              child: Text(
                                                address,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          );
                                        }).toList()
                                      : [];

                                    addressItems.insert(0, DropdownMenuItem<String>(
                                      value: 'Tambah Alamat',
                                      child: Text('Tambah Alamat'),
                                    ));

                                    return DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(color: Colors.black),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(color: Colors.black),
                                        ),
                                      ),
                                      items: addressItems,
                                      value: selectedAddress,
                                      onChanged: (String? newValue) async {
                                        if (newValue == 'Tambah Alamat') {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FormAlamatPage(motorId: widget.motorId, docId: 'form',),
                                            ),
                                          );
                                          if (result != null) {
                                            setState(() {
                                              selectedAddress = result as String;
                                              // Add the new address to the dropdown items
                                              addressItems.add(DropdownMenuItem(
                                                value: result,
                                                child: Container(
                                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                                                  child: Text(
                                                    result,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ));
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            selectedAddress = newValue!;
                                          });
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            )
                          : Container(),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Durasi (Jam)',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                        controller: durasiController,
                        hintText: 'Durasi',
                        keyboardType: TextInputType.number,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Metode Pembayaran',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                        value: selectedMethod,
                        items: metodePembayaran.map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Container(
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                              child: Text(
                                e,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedMethod = newValue!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyButton(
                        disabled: isPressed,
                        text: 'Lanjutkan',
                        fontSize: 20,
                        onTap: () {
                          setState(() {
                            isPressed = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            createTransaction();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> metodePembayaran = ['Transfer', 'Cash'];
List<String> metodePengambilan = ['di ambil', 'di antar'];
