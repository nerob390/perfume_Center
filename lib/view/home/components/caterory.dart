import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_standard/model/Category.dart';
import 'package:flutter_standard/view/viewAll/CategoryViewAll.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../res/routes/routes_name.dart';
import '../../products/CatrgoryProducts.dart';

class Category extends StatelessWidget {
  final List<CategoryItem> categoryItems;

  const Category({Key? key, required this.categoryItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 113,
      child: ListView.builder(
        itemCount: categoryItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context,int position){
          return GestureDetector(
            child: SizedBox(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Container(
                        color: Colors.black26,
                        width: 70,
                        height: 70,
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.network(
                            categoryItems[position].image!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 70,
                      child: Center(
                        //alignment: Alignment.center,
                        child: Text(categoryItems[position].name,maxLines: 2,textAlign: TextAlign.center,style: TextStyle(fontSize: 11),),
                      ),
                    )
                  ],
                ),
              )
            ),
            onTap: (){
              //Get.toNamed(RoutesName.categoryViewAll);
              PersistentNavBarNavigator.pushNewScreen(context,screen:  CategoryProducts(categoryItem: categoryItems[position]));
            },
          );
        },

      ),
    );
  }
}
