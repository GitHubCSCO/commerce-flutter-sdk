import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/location_search_type.dart';

class VMILocationSelectCallbackHelper {
  final LocationSearchType locationSearchType;
  final void Function(CurrentLocationDataEntity)? onSelectVMILocation;
  final void Function(WarehouseEntity)? onWarehouseLocationSelected;
  const VMILocationSelectCallbackHelper({
    required this.locationSearchType,
    required this.onSelectVMILocation,
    this.onWarehouseLocationSelected,
  });
}
