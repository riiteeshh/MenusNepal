import 'dart:async';

import 'package:flutter/material.dart';
import 'package:menunepal/addmenu.dart';
import 'package:menunepal/favourite.dart';
import 'package:menunepal/homescreen.dart';
import 'package:menunepal/tabbar.dart';

void main() {
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
        '/tabbar': (context) => TabScreen(),
        '/homescreen': (context) => HomeScreen(),
        '/favourite': (context) => Favourite(),
        '/addmenu': (context) => AddMenu()
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/tabbar');
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
