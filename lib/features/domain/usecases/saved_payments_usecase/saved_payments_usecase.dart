import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SavedPaymentsUsecase extends BaseUseCase {
  SavedPaymentsUsecase() : super();

  Future<Result<AccountPaymentProfileCollectionResult, ErrorResponse>>
      getSavedPayments(PaymentProfileQueryParameters parameters) async {
    return commerceAPIServiceProvider
        .getAccountService()
        .getPaymentProfiles(parameters: parameters);
  }
}
