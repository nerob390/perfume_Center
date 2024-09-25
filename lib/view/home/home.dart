import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_standard/res/components/TextStyle.dart';
import 'package:flutter_standard/res/values/AppColor.dart';
import 'package:flutter_standard/res/values/AppDimens.dart';
import 'package:flutter_standard/res/values/AppString.dart';
import 'package:flutter_standard/view/home/components/homeProduct.dart';
import 'package:flutter_standard/view/home/components/product.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../controller/HomeController.dart';
import '../../res/components/Button.dart';
import '../../res/components/EditText.dart';
import '../../utlis/utlis.dart';
import '../viewAll/CategoryViewAll.dart';
import 'components/caterory.dart';
import 'components/slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller=Get.put(HomeController());
  final TextEditingController name = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // Home() {
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
  //       if (controller.hasMoreData.value && !controller.loadingStatus.value) {
  //         controller.getProducts(isLoadMore: true);
  //       }
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // controller.getHomeData();
    controller.getSliderItem();
    controller.getCategory();
   // controller.getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.appName),
      ),
      body: HomeProduct(),
    );
  }

}
