import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BillToShipToAddressSelectionUseCase extends BaseUseCase {
  Future<Result<GetBillTosResult, ErrorResponse>> getBillToAddresses(
      String searchQuery, int currentPage) async {
    final parameters =
        BillTosQueryParameters(filter: searchQuery, page: currentPage, exclude: [
      'excludeshowall',
      'showall'
    ] //excludeshowall seem to be not working but showall in exclude seem to be working, keeping both
            );

    return await commerceAPIServiceProvider
        .getBillToService()
        .getBillTosAsync(parameters: parameters);
  }

  Future<Result<GetShipTosResult, ErrorResponse>> getShipToAddresses(
      String billToId, String searchQuery, int currentPage) async {
    final parameters =
        ShipTosQueryParameters(filter: searchQuery, page: currentPage, exclude: [
      'excludeshowall',
      'showall'
    ] //excludeshowall seem to be not working but showall in exclude seem to be working, keeping both
            );

    return await commerceAPIServiceProvider
        .getBillToService()
        .getShipTosAsync(billToId, parameters: parameters);
  }
}
