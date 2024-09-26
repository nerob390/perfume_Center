// ignore_for_file: file_names, prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_standard/res/values/AppColor.dart';
import 'package:flutter_standard/view/home/home.dart';
import 'package:flutter_standard/view/products/AllProduct.dart';
import 'package:flutter_standard/view/viewAll/CategoryViewAll.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../controller/HomeController.dart';
import 'cart/Cart.dart';

class MainScreenNew extends StatefulWidget {
  const MainScreenNew({super.key});

  @override
  State<MainScreenNew> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreenNew> {
  final _controller = PersistentTabController(initialIndex: 0);
  final controller = Get.put(HomeController());

  List<Widget> screens() {
    return [
      const Home(),
      AllProduct(),
      CategoryViewAll(),
      Cart(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: "Home",
        activeColorPrimary: AppColor.toolBarColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.apps),
        title: "Products",
        activeColorPrimary: AppColor.toolBarColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.category_outlined),
        title: "Category",
        activeColorPrimary: AppColor.toolBarColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(

/*        icon: badges.Badge(
          badgeContent: Text(
            controller.cartCount.value.toString(), // Show the cart count
            style: TextStyle(color: Colors.white),
          ),
          //badgeColor: Colors.red,
          position: BadgePosition.topEnd(),
          // animationType: badges.BadgeAnimationType.scale,
          child: Icon(Icons.shopping_cart),
        ),*/
        title: "My Cart",
        icon: Obx(() => badges.Badge(
          badgeContent: Text(
            controller.cartCount.value.toString(),
            style: TextStyle(color: Colors.white),
          ),
          position: BadgePosition.topEnd(),
          child: Icon(Icons.shopping_cart),
        )),
        activeColorPrimary: AppColor.toolBarColor,
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