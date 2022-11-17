import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:menunepal/addmenu.dart';
import 'package:menunepal/addphoto.dart';
import 'package:menunepal/favourite.dart';
import 'package:menunepal/homescreen.dart';
import 'package:menunepal/menupage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/homescreen': (context) => HomeScreen(),
        '/favourite': (context) => Favourite(),
        '/addmenu': (context) => AddMenu(),
        '/addphoto': (context) => AddPhoto(),
        '/menupage': (context) => MenuPage(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/homescreen');
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
              width: double.infinity,
              height: 500,
              child: Image.asset('asset/images/menusnepal-logo.png'))),
    );
  }
}
