import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LocationNoteUsecase extends BaseUseCase {
  LocationNoteUsecase() : super();

  String fetchLocationNote() {
    return coreServiceProvider.getVmiService().currentVmiLocation?.note ?? "";
  }

  Future<Result<Account, ErrorResponse>> getCurrentAccount() async {
    return await commerceAPIServiceProvider
        .getAccountService()
        .getCurrentAccountAsync();
  }
}
