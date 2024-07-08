import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuoteState {}

class QuoteInitial extends QuoteState {}

class QuoteLoading extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final bool isActiveJob;
  final JobQuoteResult jobQuoteResult;
  final QuoteResult quoteResult;
  QuoteLoaded(
      {required this.isActiveJob,
      required this.jobQuoteResult,
      required this.quoteResult});
}

class QuoteFailed extends QuoteState {
  final String error;

  QuoteFailed(this.error);
}
