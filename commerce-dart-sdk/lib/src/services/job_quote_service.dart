import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class JobQuoteService extends ServiceBase implements IJobQuoteService {
  JobQuoteService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<JobQuoteDto, ErrorResponse>> getJobQuote(
      String jobQuoteId) async {
    if (jobQuoteId.isEmpty) {
      return Failure(ErrorResponse(message: 'jobQuoteId is required'));
    }

    return await getAsyncNoCache<JobQuoteDto>(
      '${CommerceAPIConstants.jobQuoteUrl}/$jobQuoteId',
      JobQuoteDto.fromJson,
    );
  }

  @override
  Future<Result<JobQuoteResult, ErrorResponse>> getJobQuotes() async {
    return await getAsyncNoCache<JobQuoteResult>(
        CommerceAPIConstants.jobQuoteUrl, JobQuoteResult.fromJson);
  }

  @override
  Future<Result<JobQuoteDto, ErrorResponse>> updateJobQuote(
    JobQuoteUpdateParameter jobQuoteUpdate,
  ) async {
    if (jobQuoteUpdate.jobQuoteId.isNullOrEmpty) {
      return Failure(ErrorResponse(message: 'jobQuoteId is required'));
    }

    return await patchAsyncNoCache<JobQuoteDto>(
      '${CommerceAPIConstants.jobQuoteUrl}/${jobQuoteUpdate.jobQuoteId}',
      jobQuoteUpdate.toJson(),
      JobQuoteDto.fromJson,
    );
  }
}
