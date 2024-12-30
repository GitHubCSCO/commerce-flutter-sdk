import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_general_info_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/carousel_indicator/carousel_indicator_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/carousel_slider/carousel_slider.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_carousel_item_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/full_screen_iamge_carousel_widget.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCarouselWidget extends StatefulWidget {
  final ProductDetailsGeneralInfoEntity generalInfoEntity;

  const ProductDetailsCarouselWidget({
    Key? key,
    required this.generalInfoEntity,
  }) : super(key: key);

  @override
  State<ProductDetailsCarouselWidget> createState() =>
      _ProductDetailsCarouselWidgetState();
}

class _ProductDetailsCarouselWidgetState
    extends State<ProductDetailsCarouselWidget> {
  final CarouselController _carouselController = CarouselController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final thumbnails = widget.generalInfoEntity.thumbnails ?? [];

    return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: thumbnails.length,
          itemBuilder: (context, index, realIndex) {
            final productImageEntity = thumbnails?[index];
            return GestureDetector(
                onTap: () {
                  // When tapped, open fullscreen starting at `index`
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => FullScreenImageCarouselPage(
                      images: thumbnails ?? [],
                      initialIndex: index,
                    ),
                  ));
                },
                child: ProductDetailsCarouselItemWidget(
                  productImageEntity: thumbnails[index],
                ));

            // return ProductDetailsCarouselItemWidget(
            //   productImageEntity: thumbnails[index],
            // );
          },
          options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: false,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentPageIndex = index;
              });
            },
          ),
        ),

        // Dots indicator if you have multiple images
        if (thumbnails.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: thumbnails.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPageIndex == entry.key
                          ? Colors.black.withOpacity(0.9)
                          : Colors.black.withOpacity(0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
