import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';

abstract class ProductDetailsAddtoCartState {
  const ProductDetailsAddtoCartState();
}

class ProductDetailsAddtoCartInitial extends ProductDetailsAddtoCartState {}

class ProductDetailsAddtoCartLoading extends ProductDetailsAddtoCartState {}

// add to cart section load
class ProductDetailsAddtoCartSuccess extends ProductDetailsAddtoCartState {
  final ProductDetailsAddtoCartEntity productDetailsAddToCartEntity;
  ProductDetailsAddtoCartSuccess({required this.productDetailsAddToCartEntity});
}

class ProductDetailsAddtoCartError extends ProductDetailsAddtoCartState {
  final String errorMessage;

  const ProductDetailsAddtoCartError(this.errorMessage);
}

// product added to cart
class ProductDetailsProdctAddedToCartSuccess
    extends ProductDetailsAddtoCartState {}

class ProductDetailsProdctAddedToCartError
    extends ProductDetailsAddtoCartState {
  final String errorMessage;

  const ProductDetailsProdctAddedToCartError(this.errorMessage);
}
