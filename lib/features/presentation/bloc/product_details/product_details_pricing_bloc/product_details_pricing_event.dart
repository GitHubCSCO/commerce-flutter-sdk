import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProductDetailsPricingEvent {}

class LoadProductDetailsPricing extends ProductDetailsPricingEvent {
  final ProductDetailsPriceEntity productDetailsPriceEntity;

  LoadProductDetailsPricing({required this.productDetailsPriceEntity});
}
