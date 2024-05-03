import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';

abstract class ProductDetailsEvent {}

class FetchProductDetailsEvent extends ProductDetailsEvent {
  final String productId;
  final ProductEntity? product;

  FetchProductDetailsEvent(this.productId, this.product);
}

class StyleTraitSelectedEvent extends ProductDetailsEvent {
  final StyleValueEntity selectedStyleValue;

  StyleTraitSelectedEvent(this.selectedStyleValue);
}
