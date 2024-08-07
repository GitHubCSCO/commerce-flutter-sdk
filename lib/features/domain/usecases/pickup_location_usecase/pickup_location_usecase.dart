import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/warehouse_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:latlong2/latlong.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PickUpLocationUseCase extends BaseUseCase {
  PickUpLocationUseCase() : super();

  Future<List<WarehouseEntity>> getWarehouses(
      {double? latitude, double? longitude}) async {
    WarehousesQueryParameters param = WarehousesQueryParameters(
        pageSize: 16,
        page: 1,
        sort: "Distance",
        latitude: latitude,
        longitude: longitude,
        excludeCurrentPickupWarehouse: true,
        onlyPickupWarehouses: true);

    var response = await commerceAPIServiceProvider
        .getWarehouseService()
        .getWarehouses(parameters: param);

    List<WarehouseEntity> warehouses = [];
    switch (response) {
      case Success(value: final data):
        {
          for (var warehouse in data?.warehouses ?? []) {
            var warehouseEntity = WarehouseEntityMapper.toEntity(warehouse);
            warehouseEntity = warehouseEntity.copyWith(
                latLong: LatLong(
                    latitude: warehouse.latitude?.toDouble() ?? 0.0,
                    longitude: warehouse.longitude?.toDouble() ?? 0.0));
            warehouses.add(warehouseEntity);
          }
          return warehouses;
        }
      case Failure(errorResponse: final errorResponse):
        {
          return [];
        }
    }
  }

  Future<LatLong?> getPlaceFromAddresss(Address? address) async {
    return await coreServiceProvider
        .getVmiService()
        .getPlaceFromAddress(address);
  }

  Future<LatLng> getCurrentLocation() async {
    var response =
        await coreServiceProvider.getGeoLocationService().getCurrentLocation();
    return LatLng(response?.latitude ?? 0.0, response?.longitude ?? 0.0);
  }

  bool isCloseToLocation(LatLng fromSource, LatLng toSource) {
    return coreServiceProvider
            .getGeoLocationService()
            .getDistanceBetweenPoints(fromSource, toSource) <
        CoreConstants.vmiLocationSearchRadius;
  }
}
