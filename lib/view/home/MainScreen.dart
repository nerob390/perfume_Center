import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/values/AppString.dart';
import 'home.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    Home(), // Your Home screen
    Container(
      child: const Center(
        child: Text(
          "Men",
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
      ),
      color: Colors.yellow,
    ), // Your Search screen
    Container(
      child: const Center(
        child: Text(
          "Women",
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
      ),
      color: Colors.yellow,
    ),
    Container(
      child: const Center(
        child: Text(
          "Kids",
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
      ),
      color: Colors.yellow,
    ),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.appName),
      ),
      body: _screens[_currentIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue, // Customize selected item color
        unselectedItemColor: Colors.grey, // Customize unselected item color
        backgroundColor: Colors.white, // Set background color if needed
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Men',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Women',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.close),
            label: 'Women',
          ),
        ],
      ),
    );
  }
}
