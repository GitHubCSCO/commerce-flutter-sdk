import 'package:commerce_flutter_sdk/src/features/domain/entity/quote_line_entity.dart';

abstract class QuotePricingEvent {}

class QuotePricingInitialEvent extends QuotePricingEvent {}

class LoadQuotePricingEvent extends QuotePricingEvent {
  final QuoteLineEntity quoteLineEntity;

  LoadQuotePricingEvent({required this.quoteLineEntity});
}

class AddQuotePriceBreakEvent extends QuotePricingEvent {}

class ResetQuotePriceBreakEvent extends QuotePricingEvent {}

class QuoteStartQuantityUpdateEvent extends QuotePricingEvent {
  final String startQuantity;
  final int id;

  QuoteStartQuantityUpdateEvent(
      {required this.startQuantity, required this.id});
}

class QuoteEndQuantityUpdateEvent extends QuotePricingEvent {
  final String endQuantity;
  final int id;

  QuoteEndQuantityUpdateEvent({required this.endQuantity, required this.id});
}

class QuotePriceUpdateEvent extends QuotePricingEvent {
  final String price;
  final int id;

  QuotePriceUpdateEvent({required this.price, required this.id});
}

class QuotePiricngBreakDeletionEvent extends QuotePricingEvent {
  final int id;

  QuotePiricngBreakDeletionEvent({required this.id});
}

class ApplyQuoteLinePricingEvent extends QuotePricingEvent {}
