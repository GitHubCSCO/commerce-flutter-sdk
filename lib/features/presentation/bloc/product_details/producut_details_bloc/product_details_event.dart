import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';

abstract class ProductDetailsEvent {}

class FetchProductDetailsEvent extends ProductDetailsEvent {
  final String productId;
  final ProductEntity? product;
  final bool? trackScreen;

  FetchProductDetailsEvent(this.productId, this.product, {this.trackScreen});
}

class StyleTraitSelectedEvent extends ProductDetailsEvent {
  final StyleValueEntity selectedStyleValue;
  final String? styleTraitId;

  StyleTraitSelectedEvent(this.selectedStyleValue, this.styleTraitId);
}

class UnitOfMeasuteChangeEvent extends ProductDetailsEvent {
  final ProductUnitOfMeasureEntity productunitOfMeasureEntity;

  UnitOfMeasuteChangeEvent({required this.productunitOfMeasureEntity});
}

class ProductDetailsReloadEvent extends ProductDetailsEvent {}
