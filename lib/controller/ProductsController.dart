
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_standard/model/Category.dart';
import 'package:flutter_standard/model/Product.dart';
import 'package:flutter_standard/model/SliderItem.dart';
import 'package:get/get.dart';
import '../repository/HomeRepository.dart';

class ProductController extends GetxController{
  var productItems = <ProductItem>[].obs;
  void getProducts(){
    HomeRepository().getProducts("1").then((value){
      // Accessing the message property
      var response = value;
      var responseData = response as Map<String, dynamic>;
      var responseOfList = responseData["contents"];
      if (responseOfList is List) {
        productItems.value = responseOfList.map((dynamic json) => ProductItem.fromJson(json)).toList();
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print("Error ${error.toString()}");
      }
    }).whenComplete(() {

    });
  }
}