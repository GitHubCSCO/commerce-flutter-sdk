// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import 'package:commerce_flutter_app/core/models/gogole_place.dart';
import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/vmi_service_interface.dart';

class VMIService implements IVmiService {
  final ICommerceAPIServiceProvider _commerceAPIServiceProvider;
  final ICoreServiceProvider _coreServiceProvider;

  VMIService(
      {required ICommerceAPIServiceProvider commerceAPIServiceProvider,
      required ICoreServiceProvider coreServiceProvider})
      : _commerceAPIServiceProvider = commerceAPIServiceProvider,
        _coreServiceProvider = coreServiceProvider;
  @override
  // TODO: implement currentVmiLocation
  VmiLocationModel get currentVmiLocation => throw UnimplementedError();

  Future<VmiLocationModel> getClosestVmiLocation() async {
    throw UnimplementedError();
    // String key =
    //     '${CoreConstants.currentVmiLocationKey}:${_commerceAPIServiceProvider.getClientService().host}:${_commerceAPIServiceProvider.getSessionService().currentSession?.userName}';
    // VmiLocationModel closestVmiLocation = await _commerceAPIServiceProvider
    //     .getCacheService()
    //     .loadPersistedData<VmiLocationModel>(key);

    // if (closestVmiLocation == null) {
    //   VmiLocationQueryParameters param = VmiLocationQueryParameters(
    //     pageSize: 1,
    //     page: 1,
    //     expand: ['customer'],
    //   );

    //   var result = await _commerceAPIServiceProvider
    //       .getVmiLocationsService()
    //       .getVmiLocations(param);

    //   closestVmiLocation = result.model?.vmiLocations?.first;

    //   this.currentVmiLocation = closestVmiLocation;
    //   await _commerceAPIServiceProvider
    //       .getCacheService()
    //       .persistData<VmiLocationModel>(key, closestVmiLocation);
    // }

    // return closestVmiLocation;
  }

  @override
  Future<GooglePlace> getPlace(String searchQuery) {
    // TODO: implement getPlace
    throw UnimplementedError();
  }

  @override
  Future<LatLong> getPlaceFromAddress(Address address) {
    // TODO: implement getPlaceFromAddress
    throw UnimplementedError();
  }

  @override
  void saveCurrentVmiLocation(VmiLocationModel vmiLocation) {
    // TODO: implement saveCurrentVmiLocation
  }

  @override
  void updateCurrentVmiLocation() {
    // TODO: implement updateCurrentVmiLocation
  }
}
