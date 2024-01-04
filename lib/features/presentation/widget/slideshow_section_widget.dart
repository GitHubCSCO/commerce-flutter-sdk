import 'package:commerce_flutter_app/features/presentation/widget/slider_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/carousel_slider/carousel_slider.dart';

class SlideShowSectionWidget extends StatelessWidget {

  final imageUrl = "https://mobilespire.commerce.insitesandbox.com//userfiles/optimizely_logo_full-color_dark.png?width=2980&height=1024";

  const SlideShowSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView(
        children: [
          CarouselSlider(
            items: [1,2,3,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return SliderItemWidget(imageUrl: imageUrl);
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 1200),
              viewportFraction: 1.0,
            ),
          )
        ],
      ),
    );
  }

}