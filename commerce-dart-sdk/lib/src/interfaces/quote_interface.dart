import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IQuoteService {
  Future<Result<QuoteResult, ErrorResponse>> getQuotes(
      {QuoteQueryParameters? quoteQueryParameters});

  Future<Result<QuoteDto, ErrorResponse>> getQuote(String quoteId);

  Future<Result<QuoteDto, ErrorResponse>> saveQuote(QuoteDto quote);

  Future<Result<QuoteDto, ErrorResponse>> requestQuote(
      RequesteAQuoteParameters param);

  Future<Result<QuoteDto, ErrorResponse>> requestQuoteSalesRep(
      SalesRepRequesteAQuoteParameters param);

  Future<Result<bool, ErrorResponse>> deleteQuote(String quoteId);

  Future<Result<QuoteDto, ErrorResponse>> submitQuote(QuoteDto quote);

  Future<Result<QuoteMessage, ErrorResponse>> postQuoteMessage(
      String quoteId, QuoteMessage message);

  Future<Result<QuoteDto, ErrorResponse>> quoteAll(
      QuoteAllQueryParameters param);

  Future<Result<QuoteLine, ErrorResponse>> patchQuoteLine(
      String quoteId, QuoteLine quoteLine);

  Future<Result<QuoteDto, ErrorResponse>> quoteLinePricing(
      String quoteId, QuoteLinePricingQueryParameters param);

  Future<Result<QuoteLine, ErrorResponse>> getQuoteLine(
      String quoteId, String quoteLineId);

  Future<Result<QuoteLine, ErrorResponse>> updateQuoteLine(
      String quoteId, QuoteLine quoteLine);
}
