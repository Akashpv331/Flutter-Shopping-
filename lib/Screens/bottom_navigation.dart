import 'package:flutter/material.dart';
import 'package:project_inmakes/Screens/Home.dart';
import 'package:project_inmakes/Screens/Like.dart';
import 'package:project_inmakes/Screens/profile.dart';
import 'package:project_inmakes/Screens/shopping_cart.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [Home(), Like(),ShoppingCart(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
              label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_sharp),
              label: 'Like',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
              label: 'Cart',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person_3_sharp),
              label: 'Person',
          ),
        ],backgroundColor: Colors.white10,
        elevation: 4,selectedFontSize: 10,selectedItemColor: Colors.deepOrangeAccent,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
