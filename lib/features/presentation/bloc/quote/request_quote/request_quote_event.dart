import 'package:commerce_flutter_sdk/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/request_quote_type.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class RequestQuoteEvent {}

class LoadRequestQuoteCartLinesEvent extends RequestQuoteEvent {
  LoadRequestQuoteCartLinesEvent();
}

class RequestQuoteAddCartEvent extends RequestQuoteEvent {
  final Cart? cart;
  RequestQuoteAddCartEvent({required this.cart});
}

class DeleteCartLineEvent extends RequestQuoteEvent {
  final CartLineEntity cartLineEntity;
  DeleteCartLineEvent({required this.cartLineEntity});
}

class UpdateCartLineEvent extends RequestQuoteEvent {
  final CartLineEntity cartLineEntity;
  UpdateCartLineEvent({required this.cartLineEntity});
}

class SubmitQuoteEvent extends RequestQuoteEvent {
  final RequestQuoteType requestQuoteType;
  final String? jobName;
  final String? note;
  SubmitQuoteEvent({
    required this.requestQuoteType,
    this.jobName,
    this.note,
  });
}

class SelectUserForSalesRepEvent extends RequestQuoteEvent {
  final CatalogTypeDto selectedUser;
  SelectUserForSalesRepEvent({required this.selectedUser});
}
