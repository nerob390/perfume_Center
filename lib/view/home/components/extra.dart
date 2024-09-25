// import 'package:flutter/cupertino.dart';
//
// class Extra extends StatefulWidget {
//   const Extra({super.key});
//
//   @override
//   State<Extra> createState() => _ExtraState();
// }
//
// class _ExtraState extends State<Extra> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(AppString.appName),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             margin: const EdgeInsets.only(top: 10, bottom: 10),
//             child: Column(
//               children: [
//                 Obx(() => SliderWidget(sliderImages: controller.sliderImages.toList())),
//                 const SizedBox(height: AppDimens.homeMidHeight),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(left: 10),
//                       child: const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text("Categories", style: AppTextStyle.boldTextStyle),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         PersistentNavBarNavigator.pushNewScreen(
//                             context, screen: const CategoryViewAll());
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.only(right: 10),
//                         child: const Align(
//                           alignment: Alignment.centerRight,
//                           child: Text("View All", style: TextStyle(color: AppColor.themeColor, fontSize: 17, fontWeight: FontWeight.bold)),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: AppDimens.homeMidHeight),
//                 Obx(() => Category(categoryItems: controller.categoryItems.toList())),
//
//                 const SizedBox(height: AppDimens.homeMidHeight),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(left: 10),
//                       child: const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text("Products", style: AppTextStyle.boldTextStyle),
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(right: 10),
//                       child: const Align(
//                         alignment: Alignment.centerRight,
//                         child: Text("View All", style: TextStyle(color: AppColor.themeColor, fontSize: 17)),
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: AppDimens.homeMidHeight),
//
//                 // Wrap the Products widget in a SizedBox with a fixed height
//                 Obx(() => Products(
//                   products: controller.productItems.toList(),
//                 )),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
