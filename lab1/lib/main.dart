import 'package:flutter/material.dart';
import 'screens/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Color(0xFFFEFAE0),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF606C38),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF283618),
            foregroundColor: Colors.white
          ),
        ),
        cardTheme: CardTheme(
          color: Color(0xFFDDA15E),
        )
      ),
      home: HomeScreen(), // Define the main screen here
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('196141'),
      ),
      body: Column(
        children: [
          // Title
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
            child: const Center(
              child: Text(
                'OWIES THRIFT SHOP',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),

          // Description
          Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF606C38),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'Owies Thrift Shop is an Online Store where you get the chance to purchase vintage items for a discounted price!!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.5,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 60,
            width: 200,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text(
                  'Go To Store',
                style: TextStyle(fontSize: 20),
              ),

            ),
          )
        ],
      ),
    );
  }
}


