import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';

abstract class QuotePricingEvent {}

class QuotePricingInitialEvent extends QuotePricingEvent {}

class LoadQuotePricingEvent extends QuotePricingEvent {
  final QuoteLineEntity quoteLineEntity;

  LoadQuotePricingEvent({required this.quoteLineEntity});
}

class AddQuotePriceBreakEvent extends QuotePricingEvent {}

class QuoteStartQuantityUpdateEvent extends QuotePricingEvent {
  final String startQuantity;
  final int index;

  QuoteStartQuantityUpdateEvent(
      {required this.startQuantity, required this.index});
}

class QuoteEndQuantityUpdateEvent extends QuotePricingEvent {
  final String endQuantity;
  final int index;

  QuoteEndQuantityUpdateEvent({required this.endQuantity, required this.index});
}

class QuotePriceUpdateEvent extends QuotePricingEvent {
  final String price;
  final int index;

  QuotePriceUpdateEvent({required this.price, required this.index});
}
