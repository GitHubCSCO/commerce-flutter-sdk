import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
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
}
