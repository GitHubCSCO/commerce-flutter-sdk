abstract class ProductDetailsEvent {}

class FetchProductDetailsEvent extends ProductDetailsEvent {
  final String productId;

  FetchProductDetailsEvent(this.productId);
}
