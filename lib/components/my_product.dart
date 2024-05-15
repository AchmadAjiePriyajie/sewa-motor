import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/components/my_text.dart';
import 'package:sewa_motor/pages/product_page.dart';

class MyProduct extends StatelessWidget {
  final String images;
  final String title;
  final String docID;
  final String price;

  const MyProduct({
    super.key,
    required this.images,
    required this.title,
    required this.price,
    required this.docID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 8, top: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.8)),
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
                child: Image.network(
                  images,
                  height: 300,
                )),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
                MyText(text: price, fontSize: 12, fontWeight: FontWeight.w400)
              ],
            ),
          )
        ],
      ),
    );
  }
}
