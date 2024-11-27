import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lab1/models/Product.dart';
import 'package:lab1/screens/Home.dart';

class Details extends StatelessWidget {
  final Product productList; // Declare a field to hold the product

  const Details(this.productList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        appBar: AppBar(
          title: Text('196141'),
        ),

        body: Column(
          children: [
            Container(
              height: 300,
              width: 300,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Rounded corners
                color: Colors.grey[200], // Optional: Background color
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Clip image to the same border radius
                child: productList.image, // Ensure this is an Image widget
              ),
            ),
            Center(
              child: Text(
                productList.name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, fontStyle: FontStyle.italic), // Optional styling
              ),
            ),
            Center(
              child: Text(
                productList.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500), // Optional styling
              ),
            ),
            Center(
              child: Text(
                '${productList.price}\$',
                style: TextStyle(fontSize: 25, color: Color(0xFFBC6C25), fontWeight: FontWeight.w900), // Optional styling
              ),
            ),
            Center(
              child: SizedBox(
                height: 60,
                width: 200,
                child: ElevatedButton(
                  onPressed: (){},
                child: Text(
                    'Buy Item', style: TextStyle(fontSize: 20),
                )),
      ),
              ),
          ],
        ),
      )
    );
  }
}


