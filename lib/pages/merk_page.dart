import 'package:flutter/material.dart';
import 'package:sewa_motor/components/onProgress.dart';

class MerkPage extends StatelessWidget {
  MerkPage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OnProgress(),
    );
  }
}