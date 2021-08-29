import 'package:flutter/material.dart';
import 'package:recipe_ventures/pages/favourites.dart';
import 'package:recipe_ventures/pages/homepage.dart';
import 'package:recipe_ventures/pages/store.dart';
import 'package:recipe_ventures/utils/constants.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 1;
  final double iconSize = 30;

  final List<Widget> _pages = [Favourites(), Homepage(), Store()];

  void onTappedBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: kOrange,
          onTap: onTappedBar,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: iconSize),
                label: 'Favourites'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_a_photo, size: iconSize),
                label: 'Upload Image'),
            BottomNavigationBarItem(
                icon: Icon(Icons.kitchen, size: iconSize), label: 'Store')
          ]),
    );
  }
}
