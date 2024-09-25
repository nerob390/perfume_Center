import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_standard/view/home/components/slider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../controller/HomeController.dart';
import '../../../res/components/TextStyle.dart';
import '../../../res/values/AppColor.dart';
import '../../../res/values/AppDimens.dart';
import '../../../utlis/utlis.dart';
import '../../products/AllProduct.dart';
import '../../viewAll/CategoryViewAll.dart';
import 'caterory.dart';

class HomeProduct extends StatelessWidget {
  //final List<ProductItem> products;
   final controller=Get.put(HomeController());
  // final ScrollController scrollController;

  final ScrollController _scrollController = ScrollController();
  //  HomeProduct({
  //   Key? key, required this.products,
  //   // required this.products,
  //   // required this.scrollController
  // }) : super(key: key);

  HomeProduct({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (controller.hasMoreData.value && !controller.loadingStatus.value) {
          controller.getProducts(isLoadMore: true);
          Utils.logger.e("callll yesssss");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        /*Slider*/
        SliverToBoxAdapter(
          child: Obx(() => SliderWidget(sliderImages: controller.sliderImages.toList())),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: AppDimens.homeMidHeight),
        ),
        /*categoryViewAll*/
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Categories", style: AppTextStyle.boldTextStyle),
                ),
              ),
              InkWell(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                      context, screen: const CategoryViewAll());
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text("View All", style: TextStyle(color: AppColor.themeColor, fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: AppDimens.homeMidHeight),
        ),
        /*category*/
        SliverToBoxAdapter(
          child: Obx(() => Category(categoryItems: controller.categoryItems.toList())),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: AppDimens.homeMidHeight),
        ),
        /*productViewAll*/
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Products", style: AppTextStyle.boldTextStyle),
                ),
              ),
              InkWell(
                onTap: (){
                  PersistentNavBarNavigator.pushNewScreen(
                      context, screen: AllProduct());
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text("View All", style: TextStyle(color: AppColor.themeColor, fontSize: 17,fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ],
          ),
        ),
        /*product*/
        const SliverToBoxAdapter(
          child: SizedBox(height: AppDimens.homeMidHeight+5),
        ),
        Obx(() => SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 7,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              if (index >= controller.productItems.length) {
                // Show the loading indicator at the end of the list
               // Utils.toastMessageCenter("Load More Items...");
                return SizedBox.shrink();
              }

              final data = controller.productItems[index];
              return GestureDetector(
                onTap: () {
                  // Handle item tap
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
            childCount: controller.productItems.length + (controller.hasMoreData.value ? 1 : 0),
          ),
        )),
      ],
    );

  }
}
