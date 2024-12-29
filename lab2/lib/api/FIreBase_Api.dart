import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseApi{
final firebaseMessaging = FirebaseMessaging.instance;

Future<void> initNotifications() async{
  await firebaseMessaging.requestPermission();
  final fmcToken = await firebaseMessaging.getToken();

  print('Token $fmcToken');
}
}