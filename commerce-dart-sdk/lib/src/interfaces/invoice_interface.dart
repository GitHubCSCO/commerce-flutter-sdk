import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IInvoiceService {
  Future<Result<GetInvoiceResult, ErrorResponse>> getInvoices(
      {InvoiceQueryParameters? parameters});

  Future<Result<Invoice, ErrorResponse>> getInvoice(
      InvoiceDetailParameter parameters);

  Future<Result<bool, ErrorResponse>> sendEmail(
      {InvoiceEmailParameter? parameters});
}
