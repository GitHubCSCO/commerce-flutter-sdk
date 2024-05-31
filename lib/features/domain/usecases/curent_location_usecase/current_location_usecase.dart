import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CurrentLocationUseCase extends BaseUseCase {
  CurrentLocationUseCase() : super();

  VmiLocationModel? getCurrentLocation() {
    return coreServiceProvider.getVmiService().currentVmiLocation;
  }

  Future<LatLong?> getPlaceFromAddresss(Address? address) async {
    return await coreServiceProvider
        .getVmiService()
        .getPlaceFromAddress(address);
  }

  Future<void> saveCurrentVmiLocation(VmiLocationModel vmiLocation) async {
    coreServiceProvider.getVmiService().saveCurrentVmiLocation(vmiLocation);
  }
}
