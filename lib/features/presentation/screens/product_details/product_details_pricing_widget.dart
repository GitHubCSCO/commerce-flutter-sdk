import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPricingWidget extends StatelessWidget {
  final ProductDetailsPriceEntity productDetailsPricingEntity;

  const ProductDetailsPricingWidget(
      {required this.productDetailsPricingEntity});

  @override
  Widget build(BuildContext context) {
    var event = context.read<ProductDetailsPricingBloc>();

    event.add(LoadProductDetailsPricing(
        productDetailsPriceEntity: productDetailsPricingEntity));
    return BlocBuilder<ProductDetailsPricingBloc, ProductDetailsPricingState>(
        builder: (context, state) {
      switch (state) {
        case ProductDetailsPricingInitial():
        case ProductDetailsPricingLoading():
          return const Center(child: CircularProgressIndicator());
        case ProductDetailsPricingLoaded():
          var productDetailsPriceEntity = state.productDetailsPriceEntity;
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (productDetailsPricingEntity.discountMessage != null &&
                        productDetailsPricingEntity.discountMessage!.isNotEmpty)
                      Text(
                        productDetailsPriceEntity.discountMessage ?? '',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            color: AppColors.lightGrayTextColor),
                      ),
                    Container(
                      child: Row(
                        children: [
                          Text(productDetailsPriceEntity.priceValueText ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(productDetailsPriceEntity
                                  .selectedUnitOfMeasureValueText ??
                              ''),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement the logic for "View Quantity Pricing"
                      },
                      child: const Text("View Quantity Pricing",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                    Container(
                      child: Text(
                          productDetailsPriceEntity.availability?.message ??
                              ''),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement the logic for "View Quantity Pricing"
                      },
                      child: const Text("View Availability by Warehouse",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
          );
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
