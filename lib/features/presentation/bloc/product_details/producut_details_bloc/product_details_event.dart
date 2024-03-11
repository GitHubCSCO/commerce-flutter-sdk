import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';

abstract class ProductDetailsEvent {}

class FetchProductDetailsEvent extends ProductDetailsEvent {
  final String productId;
  final ProductEntity? product;

  FetchProductDetailsEvent(this.productId, this.product);
}
