import 'package:commerce_flutter_app/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

@immutable
abstract class ProductDetailsPricingEvent {}

class LoadProductDetailsPricing extends ProductDetailsPricingEvent {
  final ProductDetailsPriceEntity productDetailsPricingEntity;
  final int? quantity;
  final ProductEntity? product;
  final StyledProductEntity? styledProduct;
  final bool? productPricingEnabled;
  final ProductUnitOfMeasureEntity? chosenUnitOfMeasure;
  final bool realtimeProductAvailabilityEnabled;
  final bool realtimeProductPricingEnabled;
  final ProductSettings productSettings;
  final Map<String, ConfigSectionOptionEntity?> selectedConfigurations;
  final Map<String, StyleValueEntity?>? selectedStyleValues;

  LoadProductDetailsPricing(
      {required this.productDetailsPricingEntity,
      required this.product,
      required this.styledProduct,
      required this.quantity,
      required this.productPricingEnabled,
      required this.chosenUnitOfMeasure,
      required this.realtimeProductAvailabilityEnabled,
      required this.realtimeProductPricingEnabled,
      required this.productSettings,
      required this.selectedConfigurations,
      required this.selectedStyleValues});
}
