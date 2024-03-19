import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class CartContentEvent {}

class CartContentQuantityChangedEvent extends CartContentEvent {
  final CartLineEntity cartLineEntity;

  CartContentQuantityChangedEvent({required this.cartLineEntity});
}

class CartContentRemoveEvent extends CartContentEvent {
  final CartLine cartLine;

  CartContentRemoveEvent({required this.cartLine});
}

class CartContentClearAllEvent extends CartContentEvent {
  CartContentClearAllEvent();
}
