
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewa_motor/components/my_product.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            // Container Merk
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // shadow color
                    spreadRadius: 5, // spread radius
                    blurRadius: 7, // blur radius
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Bar Yamaha
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/merk_page');
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              right: 14, left: 14, top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.grey.withOpacity(0.5), // shadow color
                                spreadRadius: 5, // spread radius
                                blurRadius: 7, // blur radius
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(children: [
                            Image.asset(
                              'images/yamaha.png',
                              width: 39,
                            ),
                            Text(
                              'Yamaha',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ]),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      //Bar Honda
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/merk_page');
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, right: 20, left: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.grey.withOpacity(0.5), // shadow color
                                spreadRadius: 5, // spread radius
                                blurRadius: 7, // blur radius
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(children: [
                            Image.asset(
                              'images/honda.png',
                              width: 39,
                            ),
                            Text(
                              'Honda',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ]),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      //Vespa
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/merk_page');
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15, bottom: 15, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.grey.withOpacity(0.5), // shadow color
                                spreadRadius: 3, // spread radius
                                blurRadius: 3, // blur radius
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                'images/vespa.png',
                                width: 39,
                              ),
                              Text(
                                'Vespa',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Product',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MyProduct(
                    images: 'images/aerox1.png',
                    text: 'Aerox Standart',
                    route: '/product_page',
                  ),
                  MyProduct(
                    images: 'images/aerox1.png',
                    text: 'Aerox Standart',
                    route: '/product_page',
                  ),
                  MyProduct(
                    images: 'images/aerox1.png',
                    text: 'Aerox Standart',
                    route: '/product_page',
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Product',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MyProduct(
                    images: 'images/aerox1.png',
                    text: 'Aerox Standart',
                    route: '/product_page',
                  ),
                  MyProduct(
                    images: 'images/aerox1.png',
                    text: 'Aerox Standart',
                    route: '/product_page',
                  ),
                  MyProduct(
                    images: 'images/aerox1.png',
                    text: 'Aerox Standart',
                    route: '/product_page',
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
