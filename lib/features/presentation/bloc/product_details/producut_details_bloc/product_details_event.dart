import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';

abstract class ProductDetailsEvent {}

class FetchProductDetailsEvent extends ProductDetailsEvent {
  final ProductEntity productParameter;

  FetchProductDetailsEvent(this.productParameter);
}
