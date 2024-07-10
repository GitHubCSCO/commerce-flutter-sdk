import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';

abstract class RequestQuoteEvent {}

class LoadRequestQuoteCartLinesEvent extends RequestQuoteEvent {
  LoadRequestQuoteCartLinesEvent();
}

class DeleteCartLineEvent extends RequestQuoteEvent {
  final CartLineEntity cartLineEntity;
  DeleteCartLineEvent({required this.cartLineEntity});
}
