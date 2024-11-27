import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lab1/models/Product.dart';
import 'package:lab1/screens/Details.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '196141',
          ),
        ),
        body: GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
            ),
            itemCount: productList.length,
            itemBuilder: (context,index){
          return Card(
            margin:  EdgeInsets.only(left: 10,right: 10, top: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    productList[index].name,
                    style:  TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,

                    child: ElevatedButton.icon(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Details(productList[index])));
                      },
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('View Item', style: TextStyle(fontSize: 20)),
                    )
                )
              ],
            ),
          );
        })
      ),
    );
  }
}
