
import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_standard/res/values/AppColor.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/HomeController.dart';
import '../../db/DatabaseHelper.dart';
import '../../model/Product.dart';
import '../../utlis/utlis.dart';
import '../cart/cart.dart';

class ProductDetails extends StatefulWidget {
  final ProductItem products;
  const ProductDetails({required this.products,super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int cartCount = 0;
  final controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    //_getCartCount(); // Fetch cart count on initialization
  }

  // Future<void> _getCartCount() async {
  //   int count = await DatabaseHelper.countCartProducts();
  //   setState(() {
  //     cartCount = count;
  //   });
  // }
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );

    return htmlText.replaceAll(exp, '');
  }
  @override
  Widget build(BuildContext context) {
    Utils.logger.e(widget.products.description);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.products.name!),
          backgroundColor: AppColor.toolBarColor,
          // actions: [
          //   // Cart icon with badge from the 'badges' package
          //   IconButton(
          //     icon: badges.Badge(
          //       badgeContent: Text(
          //         cartCount.toString(), // Show the cart count
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       //badgeColor: Colors.red,
          //       position: BadgePosition.topEnd(),
          //       // animationType: badges.BadgeAnimationType.scale,
          //       child: Icon(Icons.shopping_cart),
          //     ),
          //     onPressed: () {
          //       // Navigate to cart page or handle cart logic
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => Cart()),);
          //       //MaterialPageRoute(builder: (context) => const Cart(),);
          //       print('Cart icon pressed');
          //     },
          //   ),
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 5,right: 5),
          child: Column(
            children: [
              // Main content in scrollable area
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            // color:  Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              image: NetworkImage(widget.products.imageUrl!),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Text(
                      //   widget.products.name!,
                      //   style: const TextStyle(
                      //       fontSize: 20, fontWeight: FontWeight.bold),
                      // ),
                      // const SizedBox(height: 10),
                      // Text(
                      //   "Tk. " + widget.products.price!,
                      //   style: const TextStyle(
                      //       fontSize: 20, fontWeight: FontWeight.bold),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(flex: 7,child: Text(
                            widget.products.name!,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),),
                          Flexible(
                            flex: 3,
                            child: Text(
                              "Tk. ${(double.tryParse(widget.products.price!) ?? 0.0).toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.themeColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      const Text(
                        "Details",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 5),
                      Text(
                          removeAllHtmlTags(widget.products.description!),
                          style: const TextStyle(fontSize: 16,color: Color(
                              0xff797979)),
                          textAlign: TextAlign.start
                      )
                    ],
                  ),
                ),
              ),

              // // Fixed button area at the bottom
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //   // decoration: BoxDecoration(
              //   //   color: Colors.white,
              //   //   boxShadow: [
              //   //     BoxShadow(
              //   //       color: Colors.black12,
              //   //       offset: Offset(0, -1),
              //   //       blurRadius: 5,
              //   //     ),
              //   //   ],
              //   // ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       // Add to Cart Button
              //       Expanded(
              //         child: ElevatedButton(
              //           onPressed: () async {
              //             // Check if product already exists in the cart
              //             //bool productExists = await DatabaseHelper.checkIfProductExists(widget.products.id!);
              //
              //             // if (productExists) {
              //             //   // Show a message that the product is already in the cart
              //             //   Utils.toastMessageCenter("Product already in the cart");
              //             // } else {
              //             //   final Products data = ProductItem(
              //             //       id: widget.products.id,
              //             //       title: widget.products.title,
              //             //       description: widget.products.description,
              //             //       price: widget.products.price,
              //             //       discountPercentage: widget.products.discountPercentage,
              //             //       rating: widget.products.rating,
              //             //       stock: widget.products.stock,
              //             //       brand: widget.products.brand,
              //             //       category: widget.products.category,
              //             //       thumbnail: widget.products.thumbnail,
              //             //       quantity: 2
              //             //   );
              //             //   await DatabaseHelper.addToCat(data);
              //             Utils.toastMessageCenter("Added to cart successfully");
              //             //}
              //
              //           },
              //           style: ElevatedButton.styleFrom(
              //             padding: const EdgeInsets.symmetric(vertical: 15),
              //           ),
              //           child: const Text("Add to Cart"),
              //         ),
              //       ),
              //       const SizedBox(width: 10), // Space between buttons
              //
              //       // Buy Now Button
              //       Expanded(
              //         child: ElevatedButton(
              //           onPressed: () {
              //             // Buy now action
              //           },
              //           style: ElevatedButton.styleFrom(
              //             backgroundColor: Colors.orange, // Optional: Different color for Buy Now
              //             padding: const EdgeInsets.symmetric(vertical: 15),
              //           ),
              //           child: const Text("Buy Now"),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: FloatingActionButton(
          // isExtended: true,
          backgroundColor: AppColor.themeColor,
          onPressed: () async {
                       // Check if product already exists in the cart
                        bool productExists = await DatabaseHelper.checkIfProductExists(widget.products.id!);
                        if (productExists) {
                          // Show a message that the product is already in the cart
                          Utils.toastMessageCenter("Product already in the cart");
                        }
                        else if(double.parse(widget.products.price!)<1.0){
                          Utils.toastMessageCenter("Product Value Less Then 1");
                        }
                        else {
                          final ProductItem data = ProductItem(
                              id: widget.products.id,
                              name: widget.products.name,
                              slug: widget.products.slug,
                              type: widget.products.type,
                              status: widget.products.status,
                              description: widget.products.description,
                              short_description: widget.products.short_description,
                              price: widget.products.price,
                              regular_price: widget.products.regular_price,
                              sale_price: widget.products.sale_price,
                              stock_quantity: widget.products.stock_quantity,
                              imageUrl: widget.products.imageUrl,
                              quantity: 1
                          );
                           await DatabaseHelper.addToCat(data);
                        Utils.toastMessageCenter("Added to cart successfully");
                        controller.getCartCount();
                        await controller.loadCartProducts(); // Refresh the cart after adding
                        await controller.getTotalPrice();

                        }

          },
          // isExtended: true,
          child: const Icon(Icons.add_shopping_cart),
        ),
      )
    );
  }
}