import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_standard/controller/HomeController.dart';
import 'package:flutter_standard/view/home/MainScreen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../res/values/AppColor.dart';
import '../../res/values/AppString.dart';
import 'components/view_all_category.dart';

class CategoryViewAll extends StatefulWidget {
  const CategoryViewAll({super.key});

  @override
  State<CategoryViewAll> createState() => _CategoryViewAllState();
}

class _CategoryViewAllState extends State<CategoryViewAll> {
  final controller=Get.put(HomeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getCategoryPagination();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppString.categories),
          backgroundColor: AppColor.toolBarColor,
        ),
        body: ViewAllCategory(),


    );
  }
}
