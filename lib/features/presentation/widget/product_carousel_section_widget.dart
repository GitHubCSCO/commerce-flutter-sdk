import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/product_carousel_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCarouselSectionWidget extends StatelessWidget {
  final ProductCarouselWidgetEntity productCarouselWidgetEntity;

  const ProductCarouselSectionWidget(
      {super.key, required this.productCarouselWidgetEntity});

  @override
  Widget build(BuildContext buildContext) {
    return BlocBuilder<ProductCarouselCubit, ProductCarouselState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProductCarouselLoadedState:
            final carouselState = state as ProductCarouselLoadedState;
            final isLoading = carouselState.isPricingLoading;
            final hidePricingEnable = carouselState.hidePricingEnable;
            final productCarouselList = carouselState.productCarouselList;

            if (productCarouselList.isEmpty) {
              return SizedBox();
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      _getCarouselTitle(),
                      style: OptiTextStyles.titleLarge,
                    ),
                  ),
                  SizedBox(
                    height: 168,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: productCarouselList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final productCarousel = productCarouselList[index];
                        var productId =
                            productCarousel.product!.styleParentId ??
                                productCarousel.product!.id;
                        return InkWell(
                          onTap: () {
                            AppRoute.productDetails.navigateBackStack(
                              context,
                              pathParameters: {
                                "productId": productId.toString()
                              },
                              extra: productCarousel.product!,
                            );
                          },
                          child: ProductCarouselItemWidget(
                            productCarousel: productCarousel,
                            isLoading: isLoading,
                            hidePricingEnable: hidePricingEnable ?? false,
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
          case ProductCarouselFailureState():
            return const Center(child: Text('Failed Loading Products'));
          default:
            return const Center(child: Text('default Loading Products'));
        }
      },
    );
  }

  String _getCarouselTitle() {
    if (productCarouselWidgetEntity.title?.isNotEmpty == true) {
      return productCarouselWidgetEntity.title!;
    }
    switch (productCarouselWidgetEntity.carouselType) {
      case ProductCarouselType.featuredCategory:
        return LocalizationConstants.featuredCategory.localized();
      case ProductCarouselType.topSellers:
        return LocalizationConstants.topSellers.localized();
      case ProductCarouselType.recentlyViewed:
        return LocalizationConstants.recentlyViewed.localized();
      case ProductCarouselType.webCrossSells:
        return LocalizationConstants.webCrossSells.localized();
      default:
        return '';
    }
  }
}
