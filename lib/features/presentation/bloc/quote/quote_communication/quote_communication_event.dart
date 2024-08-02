import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuoteCommunicationEvent {}

class LoadQuoteQummunicationMessagesEvent extends QuoteCommunicationEvent {
  final QuoteDto quoteDto;

  LoadQuoteQummunicationMessagesEvent(this.quoteDto);
}

class QuoteAddMessageEvent extends QuoteCommunicationEvent {
  final String message;
  final QuoteDto quoteDto;

  QuoteAddMessageEvent({required this.message, required this.quoteDto});
}
