abstract class QuoteDetailsEvent {}

class LoadQuoteDetailsDataEvent extends QuoteDetailsEvent {
  final String quoteId;
  LoadQuoteDetailsDataEvent({required this.quoteId});
}
