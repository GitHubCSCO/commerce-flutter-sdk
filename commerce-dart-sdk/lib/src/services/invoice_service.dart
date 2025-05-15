import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class InvoiceService extends ServiceBase implements IInvoiceService {
  InvoiceService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<Invoice, ErrorResponse>> getInvoice(
    InvoiceDetailParameter parameters,
  ) async {
    var url = Uri.parse(
        '${CommerceAPIConstants.invoicesUrl}/${parameters.invoiceNumber}');

    if (parameters.expand != null) {
      url = url.replace(queryParameters: parameters.toJson());
    }

    var result = await getAsyncNoCache(url.toString(), Invoice.fromJson);

    switch (result) {
      case Success(value: final value):
        {
          if (value == null) {
            return Failure(ErrorResponse(
                message: 'The invoice requested cannot be found.'));
          }

          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<GetInvoiceResult, ErrorResponse>> getInvoices({
    InvoiceQueryParameters? parameters,
  }) async {
    var url = Uri.parse(CommerceAPIConstants.invoicesUrl);
    if (parameters != null) {
      url = url.replace(queryParameters: parameters.toJson());
    }

    return await getAsyncNoCache(url.toString(), GetInvoiceResult.fromJson);
  }

  @override
  Future<Result<bool, ErrorResponse>> sendEmail({
    InvoiceEmailParameter? parameters,
  }) async {
    var url = Uri.parse('${CommerceAPIConstants.invoicesUrl}/shareinvoice');
    var data = parameters?.toJson() ?? {};

    var result = await postAsyncNoCache(url.toString(), data, (d) => true);

    switch (result) {
      case Success(value: final value):
        {
          return Success(value ?? false);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }
}
