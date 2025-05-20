import 'package:commerce_flutter_sdk/src/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/location_search_type.dart';

class VMILocationSelectCallbackHelper {
  final LocationSearchType locationSearchType;
  final WarehouseEntity? selectedPickupWarehouse;

  const VMILocationSelectCallbackHelper({
    this.selectedPickupWarehouse,
    required this.locationSearchType,
  });

  factory VMILocationSelectCallbackHelper.fromJson(Map<String, dynamic> json) {
    return VMILocationSelectCallbackHelper(
      locationSearchType:
          LocationSearchType.fromJson(json['locationSearchType']),
      selectedPickupWarehouse: json['selectedPickupWarehouse'] != null
          ? WarehouseEntity.fromJson(json['selectedPickupWarehouse'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationSearchType': locationSearchType.toJson(),
      'selectedPickupWarehouse': selectedPickupWarehouse?.toJson(),
    };
  }
}
