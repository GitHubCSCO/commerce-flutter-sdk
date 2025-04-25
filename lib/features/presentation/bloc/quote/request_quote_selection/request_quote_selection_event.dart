import 'package:commerce_flutter_sdk/features/domain/enums/request_quote_type.dart';

abstract class RequestQuoteSelectionEvent {}

class RequestQuoteSelectionChangeEvent extends RequestQuoteSelectionEvent {
  final RequestQuoteType requestQuoteType;

  RequestQuoteSelectionChangeEvent(this.requestQuoteType);
}

class RequestQuoteSelectionDefaultEvent extends RequestQuoteSelectionEvent {
  final RequestQuoteType requestQuoteType;

  RequestQuoteSelectionDefaultEvent(this.requestQuoteType);
}
