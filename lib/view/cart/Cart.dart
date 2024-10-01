import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_standard/res/values/AppColor.dart';
import 'package:flutter_standard/utlis/SharedPreference.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controller/HomeController.dart';
import '../../db/DatabaseHelper.dart';
import '../../model/CartProduct.dart';
import '../../res/routes/routes_name.dart';
import '../../utlis/utlis.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // List to store products in the cart
  //List<CartProduct> cartProducts = [];
 // double _subTotalPrice = 0.0;
  int _selectedValue = 1;
  double _deliveryCharge = 0;
  //double _totalPrice = 0;
  final controller = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    controller.loadCartProducts();
    //_getTotalPrice();
    _deliveryCharge=80;
    Utils.logger.e("Call Cart");
  }

  // // Load products from the local database
  // Future<void> _loadCartProducts() async {
  //   final products = await DatabaseHelper.getCartProducts(); // Fetch cart products from DB
  //   setState(() {
  //     cartProducts = products;
  //   });
  // }

  // Increment product quantity
  void _incrementQuantity(int index) async {
    setState(() {
      controller.cartProducts[index].quantity++;
      controller.cartProducts.refresh(); // Refresh to update UI
    });
    await DatabaseHelper.updateCartProduct(controller.cartProducts[index]); // Update DB
  }

  // Decrement product quantity
  void _decrementQuantity(int index) async {
    if (controller.cartProducts[index].quantity > 1) {
      setState(() {
        controller.cartProducts[index].quantity--;
        controller.cartProducts.refresh(); // Refresh to update UI
      });
      await DatabaseHelper.updateCartProduct(controller.cartProducts[index]); // Update DB
    }
  }

  // Remove product from cart
  void _removeProduct(int index) async {
    await DatabaseHelper.removeCartProduct(controller.cartProducts[index].id); // Remove from DB
    setState(() {
      controller.cartProducts.removeAt(index);
      controller.getCartCount();
    });
    Utils.toastMessageCenter("Product removed from cart");
  }
  // Future<void> _getTotalPrice() async {
  //   double totalPrice = await DatabaseHelper.calculateTotalPrice();
  //   setState(() {
  //     _subTotalPrice = totalPrice;
  //     _totalPrice=_subTotalPrice+_deliveryCharge;
  //
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: AppColor.toolBarColor,
      ),
      body: Column(
        children: [
          Obx(() => Expanded(
            child: controller.cartProducts.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
              itemCount: controller.cartProducts.length,
              itemBuilder: (context, index) {
                final product = controller.cartProducts[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: 100,
                              width: 100,
                              padding: EdgeInsets.all(10),
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(product.thumbnail),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  maxLines: 1,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text(
                                  "Price:  ${"${(double.tryParse(product.price) ?? 0.0).toStringAsFixed(2)} Tk"}",
                                  maxLines: 1,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff008c00), // Background color
                                ),
                                width: 35,
                                height: 35,
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      _incrementQuantity(index);
                                      controller.getTotalPrice();
                                    },
                                    color: Colors.white,
                                    padding: EdgeInsets.zero,
                                    iconSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  product.quantity.toString(),
                                  maxLines: 1,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffaf0606), // Background color
                                ),
                                width: 35,
                                height: 35,
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(Icons.remove),
                                    color: Colors.white,
                                    onPressed: (){
                                      _decrementQuantity(index);
                                      controller.getTotalPrice();
                                    },
                                    padding: EdgeInsets.zero,
                                    iconSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: (){
                                    _removeProduct(index);
                                    controller.getTotalPrice();
                                  } ,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
          Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xfff1f1f1), // Background color
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(0.0)),
              ),
              child: Column(
                children: [
                  const Text("Delivery Charge ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 5,
                        child: RadioListTile(
                          title: const Text('Inside Dhaka',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),), // Display the title for option 1
                          value: 1, // Assign a value of 1 to this option
                          groupValue:
                          _selectedValue, // Use _selectedValue to track the selected option
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = 1; // Update _selectedValue when option 1 is selected
                              _deliveryCharge=80;
                              controller.totalPrice.value=controller.subTotalPrice.value+_deliveryCharge.toDouble();
                            });
                          },
                        ),
                      ),
                      Expanded(flex: 5,
                        child: RadioListTile(
                          title: const Text('OutSide Dhaka',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)), // Display the title for option 1
                          value: 2, // Assign a value of 1 to this option
                          groupValue:
                          _selectedValue, // Use _selectedValue to track the selected option
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = 2; // Update _selectedValue when option 1 is selected\
                              _deliveryCharge=120.0;
                              controller.totalPrice.value=controller.subTotalPrice.value+_deliveryCharge;
                            });
                          },
                        ),),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Sub Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Obx(() => Text("${controller.subTotalPrice.value.toStringAsFixed(2)} Tk",style: TextStyle(fontSize: 18),)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Delivery Charge",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("$_deliveryCharge Tk",style: TextStyle(fontSize: 18),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Total Price is ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Obx(() => Text("${controller.totalPrice.value.toStringAsFixed(2)} Tk",style: const TextStyle(fontSize: 18),)),
                        )
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if(SharedPreference.isFirstTime==false){
                        Utils.toastMessageCenter("Please Log In First..");
                        Get.toNamed(RoutesName.signIn);
                      }else{
                        Get.toNamed(RoutesName.orderPage);
                      }
                      if (kDebugMode) {
                        print(_selectedValue.toString());

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.themeColor,
                      minimumSize: const Size(double.infinity, 50), // Full width button
                    ),
                    child: const Text('Proceed to Checkout'),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}