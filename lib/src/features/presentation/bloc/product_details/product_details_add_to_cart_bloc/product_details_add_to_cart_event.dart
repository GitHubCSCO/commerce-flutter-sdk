import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_data_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_unit_of_measure_entity.dart';

abstract class ProductDetailsAddToCartEvent {}

class LoadProductDetailsAddToCartEvent extends ProductDetailsAddToCartEvent {
  final ProductDetailsAddtoCartEntity productDetailsAddToCartEntity;

  LoadProductDetailsAddToCartEvent(
      {required this.productDetailsAddToCartEntity});
}

class AddToCartEvent extends ProductDetailsAddToCartEvent {
  final ProductDetailsAddtoCartEntity productDetailsAddToCartEntity;
  final ProductDetailsDataEntity productDetailsDataEntity;

  AddToCartEvent(
      {required this.productDetailsDataEntity,
      required this.productDetailsAddToCartEntity});
}

class AddToCartUpdateQuantityEvent extends ProductDetailsAddToCartEvent {
  final String? quantityText;

  AddToCartUpdateQuantityEvent({required this.quantityText});
}
