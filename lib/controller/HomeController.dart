
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_standard/model/Category.dart';
import 'package:flutter_standard/model/Product.dart';
import 'package:flutter_standard/model/SliderItem.dart';
import 'package:flutter_standard/utlis/utlis.dart';
import 'package:get/get.dart';
import '../repository/HomeRepository.dart';

class HomeController extends GetxController{
  RxBool loadingStatus=false.obs;
  RxBool loadingStatusCategory=false.obs;
  RxBool loadingStatusCategoryProduct=false.obs;
  var sliderImages = <SliderItem>[].obs;
  var categoryItems = <CategoryItem>[].obs;
  var categoryItemsPagination = <CategoryItem>[].obs;
  var productItems = <ProductItem>[].obs;
  var productItemsCategory = <ProductItem>[].obs;
  static HomeController get to => Get.find();
  int currentPage = 1; // Keep track of current page
  int currentPageCategory = 1; // Keep track of current page
  int currentPageCategoryProduct = 1; // Keep track of current page
  RxBool hasMoreData = true.obs; // Flag to check if there are more pages
  RxBool hasMoreDataCategory = true.obs;
  RxBool hasMoreDataCategoryProduct = true.obs;

  @override
  void onInit() {
    super.onInit();

    getProducts();
   // getCategoryPagination();
  }

  void getHomeData() {
    loadingStatus.value=true;
    HomeRepository().getHomeData().then((value){
      // Accessing the message property
      var response = value;
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error.toString());
      }
      loadingStatus.value=false;
    }).whenComplete(() {
      // Hide progress dialog when the future is completed
      print("Complete");
      loadingStatus.value = false;
    });
  }
  void getSliderItem(){
    HomeRepository().getSlider().then((value){
      // Accessing the message property
      var response = value;
      var responseData = response as Map<String, dynamic>;
      var responseOfList = responseData["contents"];
      if (responseOfList is List) {
        sliderImages.value = responseOfList.map((dynamic json) => SliderItem.fromJson(json)).toList();
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print("Error ${error.toString()}");
      }
    }).whenComplete(() {

    });
  }

  Future<void> getCategoryPagination({bool isLoadMoreCategory = false}) async {
    if (isLoadMoreCategory && !hasMoreDataCategory.value) return; // No more data to load
    if (loadingStatusCategory.value) return; // Prevent duplicate requests

    loadingStatusCategory.value = true;

    try {
      final value = await HomeRepository().getCategoryPagination(currentPageCategory.toString());
      final data = value as List<dynamic>;

      if (data is List) {
        if (data.isNotEmpty) {
          if (isLoadMoreCategory) {
            // Append new items to the existing list

            final newItems = data.map((dynamic json) => CategoryItem.fromJson(json)).toList();
            categoryItemsPagination.addAll(newItems);
          } else {
            // Replace the list with new items
            categoryItemsPagination.value = data.map((dynamic json) => CategoryItem.fromJson(json)).toList();
          }
          currentPageCategory++; // Increment the page for next load
          Utils.logger.e("CurrentPageCategoryPagination ${currentPageCategory}");
        } else {
          hasMoreDataCategory.value = false; // No more data to load
        }
      } else {
        if (kDebugMode) {
          print("Error: Invalid response format. Expected a List.");
        }
      }
    } catch (error) {
      print('Error loading data: $error');
    } finally {
      loadingStatusCategory.value = false;
    }
  }

  void getCategory(){
    HomeRepository().getCategory().then((value){
      // Accessing the message property
      var response = value;
      var responseData = response as List<dynamic>;
      var responseOfList = responseData;
      if (responseOfList is List) {
        categoryItems.value = responseOfList.map((dynamic json) => CategoryItem.fromJson(json)).toList();
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print("Error ${error.toString()}");
      }
    }).whenComplete(() {

    });
  }
  // void getCategoryCopy(){
  //   HomeRepository().getCategory().then((value){
  //     // Accessing the message property
  //     var response = value;
  //     var responseData = response as Map<String, dynamic>;
  //     var responseOfList = responseData["contents"];
  //     if (responseOfList is List) {
  //       categoryItems.value = responseOfList.map((dynamic json) => CategoryItem.fromJson(json)).toList();
  //     }
  //   }).onError((error, stackTrace){
  //     if (kDebugMode) {
  //       print("Error ${error.toString()}");
  //     }
  //   }).whenComplete(() {
  //
  //   });
  // }

  Future<void> getProducts({bool isLoadMore = false}) async {
    if (isLoadMore && !hasMoreData.value) return; // No more data to load
    if (loadingStatus.value) return; // Prevent duplicate requests

    loadingStatus.value = true;

    try {
      final value = await HomeRepository().getProducts(currentPage.toString());
      final data = value as List<dynamic>;

      if (data is List) {
        if (data.isNotEmpty) {
          if (isLoadMore) {
            // Append new items to the existing list
            final newItems = data.map((dynamic json) => ProductItem.fromJson(json)).toList();
            productItems.addAll(newItems);
          } else {
            // Replace the list with new items
            productItems.value = data.map((dynamic json) => ProductItem.fromJson(json)).toList();
          }
          currentPage++; // Increment the page for next load
          Utils.logger.e("CurrentPage ${currentPage}");
        } else {
          hasMoreData.value = false; // No more data to load
        }
      } else {
        if (kDebugMode) {
          print("Error: Invalid response format. Expected a List.");
        }
      }
    } catch (error) {
      print('Error loading data: $error');
    } finally {
      loadingStatus.value = false;
    }
  }
  Future<void> getProductsCategory({bool isLoadMoreCategoryProduct = false,required String categoryID}) async {
    if (isLoadMoreCategoryProduct && !hasMoreDataCategoryProduct.value) return; // No more data to load
    if (loadingStatusCategoryProduct.value) return; // Prevent duplicate requests

    loadingStatusCategoryProduct.value = true;

    try {
      final value = await HomeRepository().getProductCategoryWise(categoryID,currentPageCategoryProduct.toString());
      final data = value as List<dynamic>;

      if (data is List) {
        if (data.isNotEmpty) {
          if (isLoadMoreCategoryProduct) {
            // Append new items to the existing list
            final newItems = data.map((dynamic json) => ProductItem.fromJson(json)).toList();
            productItemsCategory.addAll(newItems);
          } else {
            // Replace the list with new items
            productItemsCategory.value = data.map((dynamic json) => ProductItem.fromJson(json)).toList();
          }
          currentPageCategoryProduct++; // Increment the page for next load
          Utils.logger.e("CurrentPage ${currentPageCategoryProduct}");
        } else {
          hasMoreDataCategoryProduct.value = false; // No more data to load
        }
      } else {
        if (kDebugMode) {
          print("Error: Invalid response format. Expected a List.");
        }
      }
    } catch (error) {
      print('Error loading data: $error');
    } finally {
      loadingStatusCategoryProduct.value = false;
    }
  }
  // Future<void> getProducts({bool isLoadMore = false}) async {
  //   if (isLoadMore && !hasMoreData.value) return; // No more data to load
  //   if (loadingStatus.value) return; // Prevent duplicate requests
  //
  //   loadingStatus.value = true;
  //   HomeRepository().getProducts(currentPage.toString()).then((value){
  //     // Accessing the message property
  //     var response = value;
  //     var responseData = response as List<dynamic>;
  //     var responseOfList = responseData;
  //     if (responseOfList is List) {
  //       if (responseOfList.isNotEmpty) {
  //         productItems.value = responseOfList.map((dynamic json) => ProductItem.fromJson(json)).toList();
  //         currentPage++; // Increment the page for next load
  //       } else {
  //         hasMoreData.value = false; // No more data to load
  //       }
  //
  //     }
  //   }).onError((error, stackTrace){
  //     if (kDebugMode) {
  //       print("Error ${error.toString()}");
  //     }
  //   }).whenComplete(() {
  //     loadingStatus.value = false;
  //   });
  // }
  // Fetch initial products


}