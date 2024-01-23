import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/carousel_indicator_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/carousel_slider/carousel_slider.dart';
import 'package:commerce_flutter_app/features/presentation/widget/carousel_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselSectionWidget extends StatelessWidget {
  final CarouselWidgetEntity carouselWidgetEntity;
  final CarouselController _controller = CarouselController();

  CarouselSectionWidget({super.key, required this.carouselWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider.builder(
          itemCount: carouselWidgetEntity.childWidgets?.length ?? 0,
          itemBuilder: (context, index, viewIndex) {
            CarouselSlideWidgetEntity carouselSlideWidgetEntity =
                carouselWidgetEntity.childWidgets![index];
            return CarouselItemWidget(
                carouselSlideWidgetEntity: carouselSlideWidgetEntity);
          },
          options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false,
              autoPlayInterval: Duration(milliseconds: carouselWidgetEntity.timerSpeed ?? 5000),
              autoPlayAnimationDuration: Duration(milliseconds: carouselWidgetEntity.animationSpeed ?? 50),
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                BlocProvider.of<CarouselIndicatorCubit>(context)
                    .carouselPageChange(index);
              })),
      Positioned(
        left: 0,
        right: 0,
        bottom: 8,
        child: BlocBuilder<CarouselIndicatorCubit, CarouselIndicatorState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselWidgetEntity.childWidgets!.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(state.current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    ]);
  }
}
