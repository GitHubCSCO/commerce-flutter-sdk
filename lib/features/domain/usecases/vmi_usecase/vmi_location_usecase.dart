import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VMILocationUseCase extends BaseUseCase {
  VMILocationUseCase() : super();

  Future<Result<GetVmiLocationResult, ErrorResponse>> getVMILocations() async {
    VmiLocationQueryParameters param = VmiLocationQueryParameters(
      pageSize: 16,
      page: 1,
      expand: ['customer'],
    );

    return await commerceAPIServiceProvider
        .getVmiLocationsService()
        .getVmiLocations(parameters: param);
  }

  Future<LatLong?> getPlaceFromAddresss(Address? address) async {
    return await coreServiceProvider
        .getVmiService()
        .getPlaceFromAddress(address);
  }
}
