import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';
import 'package:flutter/material.dart';

class CarouselItemWidget extends StatelessWidget {
  final CarouselSlideWidgetEntity carouselSlideWidgetEntity;

  const CarouselItemWidget({super.key, required this.carouselSlideWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(carouselSlideWidgetEntity.imagePath ?? ''),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

}