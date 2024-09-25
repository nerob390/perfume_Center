import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_standard/model/SliderItem.dart';

class SliderWidget extends StatelessWidget {
  final List<SliderItem> sliderImages;

  const SliderWidget({Key? key, required this.sliderImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If there are no images, return an empty container
    if (sliderImages.isEmpty) {
      return const CircularProgressIndicator();
    }

    return CarouselSlider.builder(
      itemCount: sliderImages.length,
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      itemBuilder: (context, i, id) {
        return GestureDetector(
          child: Container(
            margin: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(sliderImages[i].image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          onTap: () {
            // Implement what happens on tap
          },
        );
      },
    );
  }
}
