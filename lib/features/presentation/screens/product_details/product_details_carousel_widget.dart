import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_general_info_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/carousel_indicator/carousel_indicator_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/carousel_slider/carousel_slider.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_carousel_item_widget.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCarouselWidget extends StatelessWidget {
  final ProductDetailsGeneralInfoEntity generalInfoEntity;
  final CarouselController _controller = CarouselController();

  ProductDetailsCarouselWidget({super.key, required this.generalInfoEntity});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider.builder(
        itemCount: generalInfoEntity.thumbnails?.length ?? 0,
        itemBuilder: (context, index, viewIndex) {
          ProductImageEntity productImageEntity =
              generalInfoEntity.thumbnails![index];
          return ProductDetailsCarouselItemWidget(
              productImageEntity: productImageEntity);
        },
        options: CarouselOptions(
          enlargeCenterPage: true,
          autoPlay: false,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            BlocProvider.of<CarouselIndicatorCubit>(context)
                .carouselPageChange(index);
          },
        ),
      ),
      if ((generalInfoEntity.thumbnails?.length ?? 0) > 1) ...[
        Positioned(
          left: 0,
          right: 0,
          bottom: 8,
          child: BlocBuilder<CarouselIndicatorCubit, CarouselIndicatorState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: generalInfoEntity.thumbnails
                        ?.asMap()
                        .entries
                        .map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      state.current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList() ??
                    [],
              );
            },
          ),
        ),
      ],
    ]);
  }
}
