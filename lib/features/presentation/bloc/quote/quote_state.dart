import 'package:commerce_flutter_app/features/domain/enums/quote_page_type.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuoteState {}

class QuoteInitial extends QuoteState {}

class QuoteLoading extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final QuotePageType quotePageType;
  final List<QuoteDto>? quotes;
  QuoteLoaded(
      {required this.quotePageType,
      required this.quotes});
}

class JobQuoteLoaded extends QuoteState {
  final QuotePageType quotePageType;
  final List<JobQuoteDto>? jobQuotes;

  JobQuoteLoaded({required this.quotePageType, required this.jobQuotes});
}

class QuoteFailed extends QuoteState {
  final String error;
  final QuotePageType quotePageType;
  QuoteFailed({required this.error, required this.quotePageType});
}
