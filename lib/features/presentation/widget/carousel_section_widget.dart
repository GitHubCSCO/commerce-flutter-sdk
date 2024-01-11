import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/helper/carousel_slider/carousel_slider.dart';
import 'package:commerce_flutter_app/features/presentation/widget/carousel_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselSectionWidget extends StatelessWidget {
  final CarouselWidgetEntity carouselWidgetEntity;

  const CarouselSectionWidget({super.key, required this.carouselWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: CarouselSlider.builder(
          itemCount: carouselWidgetEntity.childWidgets?.length,
          itemBuilder: (context, index, viewIndex) {
            CarouselSlideWidgetEntity carouselSlideWidgetEntity = carouselWidgetEntity.childWidgets![index];
            return CarouselItemWidget(carouselSlideWidgetEntity: carouselSlideWidgetEntity);
          },
          options: CarouselOptions(
            height: 180.0,
            enlargeCenterPage: true,
            autoPlay: false,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: false,
            autoPlayAnimationDuration: const Duration(milliseconds: 1200),
            viewportFraction: 1.0,
          )
      )
    );
  }
}
