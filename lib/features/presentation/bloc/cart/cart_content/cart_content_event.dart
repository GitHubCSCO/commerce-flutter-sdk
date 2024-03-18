import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class CartContentEvent {}


class CartContentQuantityChangedEvent extends CartContentEvent {
  final int quantity;

  CartContentQuantityChangedEvent(this.quantity);
}

class CartContentRemoveEvent extends CartContentEvent {
  final CartLine cartLine;

  CartContentRemoveEvent(this.cartLine);
}

class CartContentClearAllEvent extends CartContentEvent {
  CartContentClearAllEvent();
}
