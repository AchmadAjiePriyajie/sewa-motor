import 'package:flutter/material.dart';
import 'package:sewa_motor/components/onProgress.dart';

class ReceiptPage extends StatelessWidget {
  ReceiptPage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnProgress(),
    );
  }
}