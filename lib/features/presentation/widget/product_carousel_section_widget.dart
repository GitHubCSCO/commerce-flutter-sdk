import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/product_carousel_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductCarouselSectionWidget extends StatelessWidget {
  final ProductCarouselWidgetEntity productCarouselWidgetEntity;

  const ProductCarouselSectionWidget(
      {super.key, required this.productCarouselWidgetEntity});

  @override
  Widget build(BuildContext buildContext) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Text(
            productCarouselWidgetEntity.title!,
            style: const TextStyle(
              color: Color(0xFF222222),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BlocConsumer<ProductCarouselCubit, ProductCarouselState>(
            builder: (context, state) {
          switch (state.runtimeType) {
            case ProductCarouselInitialState:
            case ProductCarouseLoadingState:
              return const Center(child: CircularProgressIndicator());
            case ProductCarouselLoadedState:
              final productList =
                  (state as ProductCarouselLoadedState).productList;
              return SizedBox(
                height: 168,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: productList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final product = productList[index];
                    return GestureDetector(
                      onTap: () {
                        print('Item $index clicked');

                        AppRoute.productDetails.navigateBackStack(
                          context,
                          pathParameters: {
                            "productId": "da2078e1-389c-4d6c-84f4-ac4f00ee111b"
                          },
                        );

                        // AppRoute.login.navigateBackStack(buildContext);

                        // context
                        //     .read<ProductCarouselCubit>()
                        //     .getProductId(product);
                      },
                      child: ProductCarouselItemWidget(product: product),
                    );
                  },
                ),
              );
            case ProductCarouselFailureState:
              return const Center(child: Text('Failed Loading Products'));
            default:
              return const Center(child: Text('default Loading Products'));
          }
        }, listener: (_, state) {
          if (state is ProductIdFetchState) {
            AppRoute.productDetails.navigate(
              buildContext,
              pathParameters: {"productId": state.productId},
            );
          }
        })
      ],
    );
  }
}
