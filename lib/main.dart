import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_standard/res/routes/routes.dart';
import 'package:flutter_standard/res/values/AppColor.dart';
import 'package:flutter_standard/utlis/SharedPreference.dart';
import 'package:flutter_standard/view/home/MainScreen.dart';
import 'package:flutter_standard/view/main_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Color(0xff8a0246), // replace with your custom color code
  ));
  await SharedPreference.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BL OSRMS',
      debugShowCheckedModeBanner: false,
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      getPages: AppRoute.appRoutes(),
      home: MainScreenNew(),
    );
  }
}
