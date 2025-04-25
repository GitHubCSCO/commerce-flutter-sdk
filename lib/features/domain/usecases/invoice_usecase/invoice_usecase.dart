import 'package:commerce_flutter_sdk/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class InvoiceUseCase extends BaseUseCase {
  Future<GetInvoiceResult?> loadInvoiceHistory({
    required InvoiceQueryParameters invoiceQueryParameters,
  }) async {
    final result = await commerceAPIServiceProvider
        .getInvoiceService()
        .getInvoices(parameters: invoiceQueryParameters);

    return result.getResultSuccessValue();
  }

  Future<BillTo?> getBillToAddress() async {
    var session = commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession();
    session ??= (await commerceAPIServiceProvider
            .getSessionService()
            .getCurrentSession())
        .getResultSuccessValue();

    return session?.billTo;
  }

  Future<Invoice?> loadInvoice({
    required String? invoiceId,
  }) async {
    final result =
        await commerceAPIServiceProvider.getInvoiceService().getInvoice(
              InvoiceDetailParameter(
                invoiceNumber: invoiceId,
                expand: ['invoicelines', 'shipments'],
              ),
            );

    return result.getResultSuccessValue();
  }

  Session? getCurrentSession() {
    return commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession();
  }

  Future<bool> sendInvoiceEmail(
      {required InvoiceEmailParameter parameter}) async {
    final result =
        await commerceAPIServiceProvider.getInvoiceService().sendEmail(
              parameters: parameter,
            );

    return result.getResultSuccessValue() ?? false;
  }
}
