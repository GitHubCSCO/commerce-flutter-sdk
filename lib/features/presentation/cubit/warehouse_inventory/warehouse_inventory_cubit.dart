import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/warehouse_inventory_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/warehouse_inventory/warehouse_inventory_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WarehouseInventoryCubit extends Cubit<WareHouseInventoryState> {
  final WarehouseInventoryUsecase _warehouseInventoryUsecase;
  WarehouseInventoryCubit(
      {required WarehouseInventoryUsecase warehouseInventoryUsecase})
      : _warehouseInventoryUsecase = warehouseInventoryUsecase,
        super(WareHouseInventoryInitialState());

  Future<void> loadWarehouseInventory(
      String? id, String productNumber, String unitOfMeasure) async {
    var realtimeSupport =
        await _warehouseInventoryUsecase.getRealtimeSupportType();

    var warehouses = <InventoryWarehouse>[];
    if (realtimeSupport != null &&
        (realtimeSupport == RealTimeSupport.RealTimeInventory ||
            realtimeSupport == RealTimeSupport.RealTimePricingAndInventory ||
            realtimeSupport ==
                RealTimeSupport.RealTimePricingWithInventoryIncluded)) {
      warehouses = await _getRealTimeInventory(id, unitOfMeasure);
    } else {
      warehouses = await _getProductInventory(id, unitOfMeasure);
    }

    emit(WareHouseInventoryLoadedState(warehouses: warehouses));

    // need to implement empty warehouse logic
  }

  Future<List<InventoryWarehouse>> _getProductInventory(
      String? productId, String unitOfMeasure) async {
    var productParameters = ProductQueryParameters(
        expand: "warehouses",
        unitOfMeasure: unitOfMeasure,
        replaceProducts: false);
    var productWithWarehousesResponse = await _warehouseInventoryUsecase
        .getProduct(productId, productParameters);

    GetProductResult? productWithWarehouses =
        productWithWarehousesResponse is Success
            ? (productWithWarehousesResponse as Success).value
            : null;

    var warehouses = productWithWarehouses?.product?.warehouses ?? [];

    return warehouses;
  }

  Future<List<InventoryWarehouse>> _getRealTimeInventory(
      String? productId, String unitOfMeasure) async {
    var parameters = RealTimeInventoryParameters(
        expand: "warehouses", productIds: [productId ?? ""]);

    var realTimeInventoryResponse =
        await _warehouseInventoryUsecase.getRealTimeInventory(parameters);
    GetRealTimeInventoryResult? realTimeInventory =
        realTimeInventoryResponse is Success
            ? (realTimeInventoryResponse as Success).value
            : null;

    if (realTimeInventory != null) {
      var realTimeInventoryResult = realTimeInventory.realTimeInventoryResults
          ?.firstWhere((o) => o.productId == productId);

      if (realTimeInventoryResult != null) {
        var inventoryWarehousesDto =
            realTimeInventoryResult.inventoryWarehousesDtos?.firstWhere((o) =>
                o.unitOfMeasure?.toLowerCase() == unitOfMeasure.toLowerCase());
        return inventoryWarehousesDto?.warehouseDtos ?? [];
      }
    }

    return [];
  }
}
