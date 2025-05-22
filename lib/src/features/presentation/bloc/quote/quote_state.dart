import 'package:commerce_flutter_sdk/src/features/domain/enums/quote_page_type.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuoteState {}

class QuoteInitial extends QuoteState {}

class QuoteLoading extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final QuotePageType quotePageType;
  final List<QuoteDto>? quotes;
  final bool moreLoading;
  final int page;
  final String? notFoundInfoText;

  QuoteLoaded({
    required this.quotePageType,
    required this.notFoundInfoText,
    required this.quotes,
    this.moreLoading = false,
    this.page = 1,
  });

  QuoteLoaded copyWith({
    QuotePageType? quotePageType,
    List<QuoteDto>? quotes,
    bool? moreLoading,
    int? page,
    String? notFoundInfoText,
  }) {
    return QuoteLoaded(
      notFoundInfoText: notFoundInfoText ?? this.notFoundInfoText,
      quotePageType: quotePageType ?? this.quotePageType,
      quotes: quotes ?? this.quotes,
      moreLoading: moreLoading ?? this.moreLoading,
      page: page ?? this.page,
    );
  }
}

class JobQuoteLoaded extends QuoteState {
  final QuotePageType quotePageType;
  final List<JobQuoteDto>? jobQuotes;
  final String? notFoundInfoText;

  JobQuoteLoaded({
    required this.quotePageType,
    required this.jobQuotes,
    required this.notFoundInfoText,
  });
}

class QuoteFailed extends QuoteState {
  final String error;
  final QuotePageType quotePageType;
  QuoteFailed({required this.error, required this.quotePageType});
}
