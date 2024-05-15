import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_data_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProductDetailsPricingEvent {}

class LoadProductDetailsPricing extends ProductDetailsPricingEvent {
  final ProductDetailsPriceEntity productDetailsPricingEntity;
  final int? quantity;
  ProductDetailsDataEntity productDetailsDataEntity;

  LoadProductDetailsPricing(
      {required this.productDetailsPricingEntity,
      required this.quantity,
      required this.productDetailsDataEntity});
}
