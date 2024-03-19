import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';

abstract class ProductDetailsAddToCartEvent {}

class LoadProductDetailsAddToCartEvent extends ProductDetailsAddToCartEvent {
  final ProductDetailsAddtoCartEntity productDetailsAddToCartEntity;

  LoadProductDetailsAddToCartEvent(
      {required this.productDetailsAddToCartEntity});
}

class AddToCartEvent extends ProductDetailsAddToCartEvent {
  final ProductDetailsAddtoCartEntity productDetailsAddToCartEntity;

  AddToCartEvent({required this.productDetailsAddToCartEntity});
}
