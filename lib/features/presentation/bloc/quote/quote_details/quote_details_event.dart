import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuoteDetailsEvent {}

class QuoteDetailsInitEvent extends QuoteDetailsEvent {}

class LoadQuoteDetailsDataEvent extends QuoteDetailsEvent {
  final String quoteId;
  LoadQuoteDetailsDataEvent({required this.quoteId});
}

class DeleteQuoteEvent extends QuoteDetailsEvent {
  final String quoteId;
  DeleteQuoteEvent({required this.quoteId});
}

class SubmitQuoteEvent extends QuoteDetailsEvent {
  final QuoteDto quoteDto;
  SubmitQuoteEvent({required this.quoteDto});
}

class AcceptQuoteEvent extends QuoteDetailsEvent {}

class ProceedToCheckoutEvent extends QuoteDetailsEvent {}

class ExpirationDateSelectEvent extends QuoteDetailsEvent {
  final DateTime expirationDate;
  ExpirationDateSelectEvent({required this.expirationDate});
}
