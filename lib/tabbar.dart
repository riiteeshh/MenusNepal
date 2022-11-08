import 'package:flutter/material.dart';
import 'package:menunepal/favourite.dart';
import 'package:menunepal/homescreen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int ind = 0;
  List<Widget> pages = [const HomeScreen(), const Favourite()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[ind],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: ind,
          onTap: change,
          selectedItemColor: Colors.red,
          unselectedLabelStyle: TextStyle(color: Colors.black),
          unselectedItemColor: Colors.black.withOpacity(0.5),
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded), label: 'Favourite')
          ]),
    );
  }

  void change(int value) {
    setState(() {
      ind = value;
    });
  }
}
