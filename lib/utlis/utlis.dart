import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../res/values/AppColor.dart';

class Utils{
  static void fieldFocusChange(BuildContext context,FocusNode current,FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColor.blackColor,
        gravity: ToastGravity.BOTTOM
    );
  }

  static toastMessageCenter(String message){
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColor.blackColor,
        gravity: ToastGravity.CENTER
    );
  }

  static snakBar(String title,String message){
    Get.snackbar(
      title,
      message,
    );
  }

  static String getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String getServerError(){
    const String error="Oops! Something went wrong.";
    return error;
  }
  static Future<bool> isInternetAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("No internet connection"),
      ),
    );
  }

  static String noInternetError(){
    const String error="No internet connection";
    return error;
  }

  static var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 75,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );
}