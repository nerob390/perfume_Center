import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_standard/res/drawable/AppImage.dart';
import 'package:flutter_standard/res/routes/routes_name.dart';
import 'package:flutter_standard/res/values/AppString.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to MainScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamedUntil(RoutesName.home,(route) => false);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(AppImage.splashScreen, width: 100.0, height: 100.0),
            const SizedBox(height: 20),
            const Text(
              AppString.splash,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
