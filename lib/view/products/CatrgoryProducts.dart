import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/HomeController.dart';
import '../../model/Category.dart';
import '../../res/values/AppString.dart';

class CategoryProducts extends StatefulWidget {
  final CategoryItem categoryItem;
  CategoryProducts({Key? key, required this.categoryItem}) : super(key: key);

  @override
  State<CategoryProducts> createState() => _ProductsState();
}

class _ProductsState extends State<CategoryProducts> {
  final HomeController controller = Get.put(HomeController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Fetch the initial products based on the category ID
    controller.getProductsCategory(categoryID: widget.categoryItem.id.toString());

    // Adding the scroll listener to detect when user scrolls to the end
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // Load more products if available
        if (controller.hasMoreDataCategoryProduct.value &&
            !controller.loadingStatusCategoryProduct.value) {
          controller.getProductsCategory(
              isLoadMoreCategoryProduct: true,
              categoryID: widget.categoryItem.id.toString());
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Don't forget to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryItem.name!),
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            Obx(() => SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 7,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  if (index < controller.productItemsCategory.length) {
                    final data = controller.productItemsCategory[index];
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
                  } else {
                    // Show loading indicator at the end of the list while loading more products
                    return const Center(
                      child: SizedBox.shrink(),
                    );
                  }
                },
                childCount: controller.productItemsCategory.length +
                    (controller.hasMoreDataCategoryProduct.value ? 1 : 0),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

