// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_standard/view/home/home.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreenNew extends StatefulWidget {
  const MainScreenNew({super.key});

  @override
  State<MainScreenNew> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreenNew> {
  final _controller = PersistentTabController(initialIndex: 0);

  List<Widget> screens() {
    return [
      const Home(),
      Container(
        child: const Center(
          child: Text(
            "Men",
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        ),
        color: Colors.yellow,
      ),
      Container(
        child: const Center(
          child: Text(
            "Women",
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        ),
        color: Colors.red,
      ),
      Container(
        child: const Center(
          child: Text(
            "Profile",
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        ),
        color: Colors.blue,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_2),
        title: "Men",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.woman),
        title: "Women",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: screens(),
      items: navBarItems(),
      controller: _controller,
      navBarStyle: NavBarStyle.style1,
      popAllScreensOnTapOfSelectedTab: true,
    );
  }
}