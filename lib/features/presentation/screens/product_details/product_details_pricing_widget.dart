import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/converter/avalability_color_converter.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/widget/view_pricing_quantity_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/view_warehouse_availability_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsPricingWidget extends StatelessWidget {
  final ProductDetailsPriceEntity productDetailsPricingEntity;

  const ProductDetailsPricingWidget(
      {required this.productDetailsPricingEntity});

  @override
  Widget build(BuildContext context) {
    var event = context.read<ProductDetailsPricingBloc>();
    var productDetailsBloc = context.read<ProductDetailsBloc>();
    var orderQuantity =
        productDetailsBloc.productDetailDataEntity.product?.minimumOrderQty;

    if (orderQuantity == 0) {
      orderQuantity = 1;
    }

    event.add(LoadProductDetailsPricing(
        productDetailsPricingEntity: productDetailsPricingEntity,
        quantity: orderQuantity,
        productDetailsDataEntity: productDetailsBloc.productDetailDataEntity));

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!(productDetailsPricingEntity.hidePricing ?? false)) ...{
                _buildDiscountMessageSection(context),
                _buildPricingSection(context),
                _buildQuantityPricingSection(context),
              },
              if (!(productDetailsPricingEntity.hideInventory ?? false)) ...{
                _buildInventorySection(context),
                // _buildInventorySection(context),
                // For "View Availability by Warehouse"
                _buildInventoryAvailabilitySection(context)
              },
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityPricingSection(BuildContext context) {
    return BlocBuilder<ProductDetailsPricingBloc, ProductDetailsPricingState>(
      buildWhen: (previous, current) {
        if (current is ProductDetailsPricingLoaded) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is ProductDetailsPricingLoaded &&
            state.productDetailsPriceEntity.viewQuantityPricingButtonShown !=
                null &&
            state.productDetailsPriceEntity.viewQuantityPricingButtonShown!) {
          return GestureDetector(
            onTap: () {
              viewPricingQuantityWidget(
                  context,
                  state.productDetailsPriceEntity.product?.pricing
                          ?.unitRegularBreakPrices ??
                      []);
            },
            child: Text(
              LocalizationConstants.viewQuantityPricing.localized(),
              style: OptiTextStyles.link,
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildInventoryAvailabilitySection(BuildContext context) {
    return BlocBuilder<ProductDetailsPricingBloc, ProductDetailsPricingState>(
      builder: (_, state) {
        if (state is ProductDetailsPricingLoaded &&
            state.productDetailsPriceEntity.viewInventoryByWarehouseShown ==
                true) {
          return GestureDetector(
            onTap: () {
              viewWarehouseWidget(
                  context,
                  state.productDetailsPriceEntity.styledProduct != null
                      ? state.productDetailsPriceEntity.styledProduct?.productId
                      : state.productDetailsPriceEntity.product?.id,
                  state.productDetailsPriceEntity.product.getProductNumber(),
                  state.productDetailsPriceEntity.chosenUnitOfMeasure
                          ?.unitOfMeasure ??
                      "");
            },
            child: Text(
              LocalizationConstants.viewAvailabilityWarehouse.localized(),
              style: OptiTextStyles.link,
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildDiscountMessageSection(BuildContext context) {
    return BlocBuilder<ProductDetailsPricingBloc, ProductDetailsPricingState>(
      buildWhen: (previous, current) {
        if (previous is ProductDetailsPricingLoaded &&
            current is ProductDetailsPricingLoaded) {
          return previous.productDetailsPriceEntity.discountMessage !=
              current.productDetailsPriceEntity.discountMessage;
        } else if (previous is ProductDetailsPricingLoading &&
            current is ProductDetailsPricingLoaded) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is ProductDetailsPricingLoaded) {
          var discountMessage = state.productDetailsPriceEntity.product?.pricing
              ?.getDiscountValue();
          if (discountMessage != null &&
              discountMessage.isNotEmpty &&
              discountMessage != "null") {
            return Text(
              discountMessage,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  color: OptiAppColors.textSecondary),
            );
          }
        }
        return Container();
      },
    );
  }

  Widget _buildPricingSection(BuildContext context) {
    return BlocBuilder<ProductDetailsPricingBloc, ProductDetailsPricingState>(
      buildWhen: (previous, current) {
        if (current is ProductDetailsPricingLoaded) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is ProductDetailsPricingLoaded) {
          var productDetailsPriceEntity = state.productDetailsPriceEntity;
          return Row(
            children: [
              Text(
                  productDetailsPriceEntity.product.updatePriceValueText(
                      productDetailsPriceEntity.productPricingEnabled),
                  style: OptiTextStyles.subtitle),
              if (productDetailsPriceEntity
                      .selectedUnitOfMeasureValueText.isNullOrEmpty ==
                  false)
                Text(
                  " / ${productDetailsPriceEntity.selectedUnitOfMeasureValueText ?? ""}",
                  style: OptiTextStyles.body,
                ),
            ],
          );
        }
        return Container(
          alignment: Alignment.bottomLeft,
          child: LoadingAnimationWidget.progressiveDots(
            color: OptiAppColors.iconPrimary,
            size: 30,
          ),
        );
      },
    );
  }

  Widget _buildInventorySection(BuildContext context) {
    return BlocBuilder<ProductDetailsPricingBloc, ProductDetailsPricingState>(
      builder: (context, state) {
        if (state is ProductDetailsPricingLoaded) {
          var productDetailsPriceEntity = state.productDetailsPriceEntity;
          return Container(
            child: Text(
              productDetailsPriceEntity.availability?.message ?? '',
              style: OptiTextStyles.body.copyWith(
                  color: AvailabilityColorConverter.convert(
                      productDetailsPriceEntity.availability?.messageType)),
            ),
          );
        } else if (state is ProductDetailsPricingLoading) {
          return Container(
            alignment: Alignment.bottomLeft,
            child: LoadingAnimationWidget.progressiveDots(
              color: OptiAppColors.iconPrimary,
              size: 30,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
