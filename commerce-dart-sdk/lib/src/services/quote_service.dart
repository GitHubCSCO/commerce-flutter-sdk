import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteService extends ServiceBase implements IQuoteService {
  QuoteService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<bool, ErrorResponse>> deleteQuote(String quoteId) async {
    if (quoteId.isNullOrEmpty) {
      return Failure(ErrorResponse(message: 'quoteId is empty'));
    }

    var url = Uri.parse('${CommerceAPIConstants.quoteUrl}/$quoteId');
    var result = await deleteAsync(
      url.toString(),
    );

    switch (result) {
      case Success(value: final value):
        {
          return Success(
              value != null && StatusCodeExtension.isSuccessStatusCode(value));
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<QuoteDto, ErrorResponse>> getQuote(String quoteId) async {
    if (quoteId.isEmpty) {
      return Failure(ErrorResponse(message: 'quoteId is empty'));
    }

    var url = Uri.parse('${CommerceAPIConstants.quoteUrl}/$quoteId');

    return await getAsyncNoCache<QuoteDto>(url.toString(), QuoteDto.fromJson);
  }

  @override
  Future<Result<QuoteLine, ErrorResponse>> getQuoteLine(
    String quoteId,
    String quoteLineId,
  ) async {
    if (quoteId.isEmpty) {
      return Failure(ErrorResponse(message: 'quoteId is empty'));
    }

    if (quoteLineId.isEmpty) {
      return Failure(ErrorResponse(message: 'quoteLineId is empty'));
    }

    var url = Uri.parse(
      CommerceAPIConstants.quoteLineUrl
          .replaceAll('{0}', quoteId)
          .replaceAll('{1}', quoteLineId),
    );

    return await getAsyncNoCache<QuoteLine>(url.toString(), QuoteLine.fromJson);
  }

  @override
  Future<Result<QuoteResult, ErrorResponse>> getQuotes({
    QuoteQueryParameters? quoteQueryParameters,
  }) async {
    var url = Uri.parse(CommerceAPIConstants.quoteUrl);
    if (quoteQueryParameters != null) {
      url = url.replace(queryParameters: quoteQueryParameters.toJson());
    }

    return await getAsyncNoCache<QuoteResult>(
        url.toString(), QuoteResult.fromJson);
  }

  @override
  Future<Result<QuoteLine, ErrorResponse>> patchQuoteLine(
    String quoteId,
    QuoteLine quoteLine,
  ) async {
    if (quoteId.isEmpty) {
      return Failure(ErrorResponse(message: 'quoteId is empty'));
    }

    var data = quoteLine.toJson();
    var url = Uri.parse(
        '${CommerceAPIConstants.quoteUrl}/$quoteId/quotelines/${quoteLine.id}');
    return await patchAsyncNoCache<QuoteLine>(
      url.toString(),
      data,
      QuoteLine.fromJson,
    );
  }

  @override
  Future<Result<QuoteMessage, ErrorResponse>> postQuoteMessage(
    String quoteId,
    QuoteMessage message,
  ) async {
    if (quoteId.isEmpty) {
      return Failure(ErrorResponse(message: 'quoteId is empty'));
    }

    var data = message.toJson();
    var url = Uri.parse('${CommerceAPIConstants.quoteUrl}/$quoteId');
    return await postAsyncNoCache<QuoteMessage>(
      url.toString(),
      data,
      QuoteMessage.fromJson,
    );
  }

  @override
  Future<Result<QuoteDto, ErrorResponse>> quoteAll(
    QuoteAllQueryParameters param,
  ) async {
    if (param.quoteId.isNullOrEmpty) {
      return Failure(ErrorResponse(message: 'quoteId is empty'));
    }

    var url = Uri.parse('${CommerceAPIConstants.quoteUrl}/${param.quoteId}');
    var data = param.toJson();
    return await patchAsyncNoCache<QuoteDto>(
      url.toString(),
      data,
      QuoteDto.fromJson,
    );
  }

  @override
  Future<Result<QuoteDto, ErrorResponse>> quoteLinePricing(
    String quoteId,
    QuoteLinePricingQueryParameters param,
  ) async {
    if (quoteId.isEmpty) {
      return Failure(ErrorResponse(message: 'quoteId is empty'));
    }

    if (param.id.isNullOrEmpty) {
      return Failure(ErrorResponse(message: 'quoteLineId is empty'));
    }

    var data = param.toJson();
    var url = Uri.parse(
        '${CommerceAPIConstants.quoteUrl}/$quoteId/quotelines/${param.id}');
    return await patchAsyncNoCache<QuoteDto>(
        url.toString(), data, QuoteDto.fromJson);
  }

  @override
  Future<Result<QuoteDto, ErrorResponse>> requestQuote(
    RequesteAQuoteParameters param,
  ) async {
    var data = param.toJson();
    return await postAsyncNoCache<QuoteDto>(
      CommerceAPIConstants.quoteUrl,
      data,
      QuoteDto.fromJson,
    );
  }

  @override
  Future<Result<QuoteDto, ErrorResponse>> requestQuoteSalesRep(
    SalesRepRequesteAQuoteParameters param,
  ) async {
    var data = param.toJson();
    return await postAsyncNoCache<QuoteDto>(
      CommerceAPIConstants.quoteUrl,
      data,
      QuoteDto.fromJson,
    );
  }

  @override
  Future<Result<QuoteDto, ErrorResponse>> saveQuote(QuoteDto quote) async {
    var data = quote.toJson();
    if (quote.quoteNumber.isNullOrEmpty) {
      return await postAsyncNoCache<QuoteDto>(
        CommerceAPIConstants.quoteUrl,
        data,
        QuoteDto.fromJson,
      );
    } else {
      var url = Uri.parse('${CommerceAPIConstants.quoteUrl}/${quote.id}');
      return await patchAsyncNoCache<QuoteDto>(
        url.toString(),
        data,
        QuoteDto.fromJson,
      );
    }
  }

  @override
  Future<Result<QuoteDto, ErrorResponse>> submitQuote(QuoteDto quote) async {
    if (quote.id.isNullOrEmpty) {
      return Failure(ErrorResponse(message: 'quoteId is empty'));
    }

    var quoteRequestParameter = QuoteRequestedParameter(
      quoteId: quote.id,
      status: quote.status,
      expirationDate: quote.expirationDate,
    );

    var data = quoteRequestParameter.toJson();

    if (quoteRequestParameter.quoteId.isNullOrEmpty) {
      return await postAsyncNoCache<QuoteDto>(
        CommerceAPIConstants.quoteUrl,
        data,
        QuoteDto.fromJson,
      );
    }

    return await patchAsyncNoCache<QuoteDto>(
      '${CommerceAPIConstants.quoteUrl}/${quoteRequestParameter.quoteId}',
      data,
      QuoteDto.fromJson,
    );
  }

  @override
  Future<Result<QuoteLine, ErrorResponse>> updateQuoteLine(
    String quoteId,
    QuoteLine quoteLine,
  ) async {
    if (quoteId.isEmpty) {
      return Failure(ErrorResponse(message: 'quoteId is empty'));
    }

    if (quoteLine.id.isNullOrEmpty) {
      return Failure(ErrorResponse(message: 'quoteLineId is empty/null'));
    }

    var data = quoteLine.toJson();
    var url = Uri.parse(
      CommerceAPIConstants.quoteLineUrl
          .replaceAll('{0}', quoteId)
          .replaceAll('{1}', quoteLine.id!),
    );

    return await patchAsyncNoCache<QuoteLine>(
      url.toString(),
      data,
      QuoteLine.fromJson,
    );
  }
}
