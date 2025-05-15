import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IJobQuoteService {
  Future<Result<JobQuoteResult, ErrorResponse>> getJobQuotes();

  Future<Result<JobQuoteDto, ErrorResponse>> getJobQuote(String jobQuoteId);

  Future<Result<JobQuoteDto, ErrorResponse>> updateJobQuote(
      JobQuoteUpdateParameter jobQuoteUpdate);
}
