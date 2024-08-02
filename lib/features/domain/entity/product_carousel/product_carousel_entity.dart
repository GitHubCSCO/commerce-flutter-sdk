import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';

class ProductCarouselEntity extends Equatable {
  final bool? productPricingEnabled;
  final ProductEntity? product;

  const ProductCarouselEntity({this.productPricingEnabled, this.product});

  @override
  List<Object?> get props => [productPricingEnabled, product];

  ProductCarouselEntity copyWith(
      {bool? productPricingEnabled, ProductEntity? product}) {
    return ProductCarouselEntity(
        productPricingEnabled:
            productPricingEnabled ?? this.productPricingEnabled,
        product: product ?? this.product);
  }
}
