import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/location_search_type.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VMILocationSelectCallbackHelper {
  final LocationSearchType locationSearchType;
  final WarehouseEntity? selectedPickupWarehouse;
  final void Function(CurrentLocationDataEntity)? onSelectVMILocation;
  final void Function(WarehouseEntity)? onWarehouseLocationSelected;
  const VMILocationSelectCallbackHelper({
    this.selectedPickupWarehouse,
    required this.locationSearchType,
    required this.onSelectVMILocation,
    this.onWarehouseLocationSelected,
  });
}
