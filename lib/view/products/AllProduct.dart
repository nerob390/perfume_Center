import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_standard/res/values/AppString.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../controller/HomeController.dart';
import '../../res/values/AppColor.dart';
import '../../utlis/utlis.dart';
import '../productDetails/productDetails.dart';

class AllProduct extends StatelessWidget {
  final controller = Get.put(HomeController());
  final ScrollController _scrollController = ScrollController();
  // const AllProduct({super.key});
  AllProduct({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.hasMoreData.value && !controller.loadingStatus.value) {
          controller.getProducts(isLoadMore: true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.allProduct),
        backgroundColor: AppColor.toolBarColor,
      ),
      body: Obx(() {
        return GridView.builder(
          controller: _scrollController,
          // physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 7,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: controller.productItems.length +
              (controller.hasMoreData.value
                  ? 1
                  : 0), // Add 1 for the loading indicator
          itemBuilder: (context, index) {
            if (index >= controller.productItems.length) {
              // Show the loading indicator at the end of the list
              return SizedBox.shrink();
            }

            final data = controller.productItems[index];
            return GestureDetector(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(context,screen:  ProductDetails(products: controller.productItems[index]));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: Image.network(
                            data.imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          data.name!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          'Tk ${data.price}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
