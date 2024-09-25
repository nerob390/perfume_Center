

import 'package:flutter_standard/res/routes/routes_name.dart';
import 'package:flutter_standard/view/viewAll/CategoryViewAll.dart';
import 'package:get/get.dart';
import '../../view/home/home.dart';
import '../../view/splash/splash.dart';

class AppRoute{
  static appRoutes() =>[
    //login
    GetPage(name: RoutesName.splash,
        page:()=> const Splash(),
        transitionDuration: const Duration(microseconds: 250),
        transition: Transition.leftToRightWithFade
    ),

    GetPage(name: RoutesName.home,
        page:()=> const Home(),
        transitionDuration: const Duration(microseconds: 250),
        transition: Transition.leftToRightWithFade
    ),

    GetPage(name: RoutesName.categoryViewAll,
        page:()=> const CategoryViewAll(),
        transitionDuration: const Duration(microseconds: 250),
        transition: Transition.leftToRightWithFade
    ),

  ];

}