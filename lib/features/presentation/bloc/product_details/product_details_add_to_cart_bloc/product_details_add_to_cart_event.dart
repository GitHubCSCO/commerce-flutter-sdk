import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';

abstract class ProductDetailsAddToCartEvent {}

class LoadProductDetailsAddToCartEvent extends ProductDetailsAddToCartEvent {
  final ProductDetailsAddtoCartEntity productDetailsAddToCartEntity;
  final ProductDetailsPriceEntity productDetailsPriceEntity;

  LoadProductDetailsAddToCartEvent(
      {required this.productDetailsAddToCartEntity,
      required this.productDetailsPriceEntity});
}
