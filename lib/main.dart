import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:peace_of_cake/models/home.dart';
import 'package:peace_of_cake/modules/authentication/login_screen.dart';
import 'package:peace_of_cake/modules/on_borading/onborading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = FirebaseMessaging.instance.getToken();
  print(token);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary:HexColor("#5B84c4")),
      ),
      home: FirebaseAuth.instance.currentUser != null? Home():Login(),
    );
  }
}
