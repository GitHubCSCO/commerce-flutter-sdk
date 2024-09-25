import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class CartContentEvent {}

class CartContentQuantityChangedEvent extends CartContentEvent {
  final CartLineEntity cartLineEntity;
  final String? orderNumber;

  CartContentQuantityChangedEvent(
      {required this.cartLineEntity, required this.orderNumber});
}

class CartContentRemoveEvent extends CartContentEvent {
  final CartLine cartLine;
  final String? orderNumber;
  CartContentRemoveEvent({required this.cartLine, required this.orderNumber});
}

class CartContentClearAllEvent extends CartContentEvent {
  CartContentClearAllEvent();
}
