
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class MyBottomNavyBar extends StatefulWidget {
  const MyBottomNavyBar({Key? key}) : super(key: key);

  @override
  _BottomNavyBarState createState() => _BottomNavyBarState();
}

class _BottomNavyBarState extends State<MyBottomNavyBar> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (int index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          Container(
          child: const Center(
            child: Text(
            "Settings",
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        ),
        color: Colors.yellow,
        ),
        Container(
        child: const Center(
        child: Text(
        "Settings",
        style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        ),
        color: Colors.yellow,
        ),
          Container(
            child: const Center(
              child: Text(
                "Settings",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            color: Colors.yellow,
          ),
          Container(
            child: const Center(
              child: Text(
                "Account",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            color: Colors.blue,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        containerHeight: 55.0,
        backgroundColor: Colors.white70,
        selectedIndex: _currentIndex,
        showElevation: false,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
          // _pageController.animateToPage(index,
          //     duration: const Duration(milliseconds: 10),
          //     curve: Curves.bounceInOut);
          _pageController.jumpToPage(index);
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            inactiveColor: Colors.black,
            icon: const Icon(Icons.apps),
            title: const Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            inactiveColor: Colors.black,
            icon: const Icon(Icons.search_outlined),
            title: const Text('Search'),
            activeColor: Colors.green,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            inactiveColor: Colors.black,
            icon: const Icon(Icons.settings),
            title: const Text(
              'Settings ',
            ),
            activeColor: Colors.yellow,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            inactiveColor: Colors.black,
            icon: const Icon(Icons.account_box),
            title: const Text('Account'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}