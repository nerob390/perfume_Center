import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_standard/model/Category.dart';
import 'package:flutter_standard/view/products/CatrgoryProducts.dart';
import 'package:flutter_standard/view/viewAll/CategoryViewAll.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../controller/HomeController.dart';
import '../../../res/routes/routes_name.dart';


import 'package:flutter/material.dart';
import 'package:flutter_standard/model/Category.dart';

import '../../../utlis/utlis.dart';

class ViewAllCategory extends StatelessWidget {
  // final List<CategoryItem> categoryItems;
  final HomeController controller = Get.put(HomeController());
  final ScrollController _scrollController = ScrollController();

  ViewAllCategory({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (controller.hasMoreDataCategory.value && !controller.loadingStatusCategory.value) {
          controller.getCategoryPagination(isLoadMoreCategory: true);
          Utils.logger.e("Attempting to load more categories...");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if the layout is portrait or landscape
        bool isPortrait = constraints.maxWidth < constraints.maxHeight;
        // Calculate item dimensions based on orientation
        double crossAxisCount = isPortrait ? 2 : 4;
        double itemWidth = constraints.maxWidth / crossAxisCount;
        double itemHeight = isPortrait ? 250 : 200; // Adjust these values as needed
        // Set childAspectRatio based on calculated item dimensions
        double childAspectRatio = itemWidth / itemHeight;
        return Obx(() => GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(5.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount.toInt(),
            crossAxisSpacing: 7,
            mainAxisSpacing: 15,
            childAspectRatio: childAspectRatio, // Set aspect ratio
          ),
          itemCount: controller.categoryItemsPagination.length +
              (controller.hasMoreDataCategory.value ? 1 : 0), // Add extra item for loading indicator
         // itemCount: controller.categoryItemsPagination.length,

            itemBuilder: (context, index) {
              if (index >= controller.categoryItemsPagination.length) {
                // Show the loading indicator at the end of the list
                return Center(
                  child: SizedBox.shrink(), // Loading widget
                );
              }

            var data = controller.categoryItemsPagination[index];
            return GestureDetector(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(context,screen:  CategoryProducts(categoryItem: data));
                // Navigator.of(context).pushNamed(RouteName.GridViewBuilder);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Image.network(
                          data.image!,
                          width: double.infinity,
                          fit: BoxFit.cover, // Adjust fit as needed
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          data.name!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis, // Handle overflow
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
      },
    );
  }
}

