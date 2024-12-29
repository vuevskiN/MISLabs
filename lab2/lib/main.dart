import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lab2/api/FIreBase_Api.dart';
import 'package:lab2/screens/MainScreen.dart';
//a notification will be sent every day at 6:5 pm
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FireBaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const Mainscreen(),
    );
  }
}
