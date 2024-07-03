import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:latlong2/latlong.dart';
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

  Future<LatLng> getCurrentLocation() async {
    var response =
        await coreServiceProvider.getGeoLocationService().getCurrentLocation();

    switch (response) {
      case Success(value: final data):
        {
          return LatLng(data?.latitude, data?.longitude);
        }
      case Failure():
        {
          return LatLng(0, 0);
        }
    }
    return LatLng(0, 0);
  }

  bool isCloseToLocation(LatLng fromSource, LatLng toSource) {
    return coreServiceProvider
            .getGeoLocationService()
            .getDistanceBetweenPoints(fromSource, toSource) <
        CoreConstants.vmiLocationSearchRadius;
  }

  Future<void> saveCurrentVmiLocation(VmiLocationModel vmiLocation) async {
    coreServiceProvider.getVmiService().saveCurrentVmiLocation(vmiLocation);
  }

  VmiLocationModel? getCurrentVMILocation() {
    return coreServiceProvider.getVmiService().currentVmiLocation;
  }
}
