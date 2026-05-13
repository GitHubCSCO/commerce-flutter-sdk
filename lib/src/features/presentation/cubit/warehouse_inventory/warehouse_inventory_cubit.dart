import 'package:commerce_flutter_sdk/src/features/domain/model/csco_branch_inventory.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/warehouse_inventory_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/warehouse_inventory/warehouse_inventory_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

/// Drives the "View Availability by Warehouse" modal.
///
/// Loads inventory from the CSCO custom branch endpoint and bucketizes the
/// rows into three groups for display:
///   - Home branch (the one with isDefault == true)
///   - Regional branches (isRegional == true, excluding the home branch)
///   - All other branches (everything else, excluding the home branch)
class WarehouseInventoryCubit extends Cubit<WareHouseInventoryState> {
  WarehouseInventoryCubit({
    required WarehouseInventoryUsecase warehouseInventoryUsecase,
  })  : _warehouseInventoryUsecase = warehouseInventoryUsecase,
        super(WareHouseInventoryInitialState());

  final WarehouseInventoryUsecase _warehouseInventoryUsecase;

  /// `productNumber` and `unitOfMeasure` are kept in the signature for
  /// callsite compatibility but are not used today — the CSCO endpoint is
  /// keyed only on productId, and UoM filtering is a known server-side bug.
  /// When the ERP team fixes UoM, plumb it through `getCscoBranchInventory`.
  Future<void> loadWarehouseInventory(
    String? id,
    String productNumber,
    String unitOfMeasure,
  ) async {
    emit(WareHouseInventoryLoadingState());

    final result = await _warehouseInventoryUsecase.getCscoBranchInventory(id);

    switch (result) {
      case Success(value: final value):
        final all = value?.inventoryList ?? <CscoBranchInventory>[];
        emit(_groupAndSort(all));
      case Failure(errorResponse: final err):
        debugPrint('[WarehouseInventoryCubit] load failed: ${err.message}');
        emit(WareHouseInventoryFailureState());
    }
  }

  WareHouseInventoryLoadedState _groupAndSort(List<CscoBranchInventory> all) {
    CscoBranchInventory? home;
    final regional = <CscoBranchInventory>[];
    final other = <CscoBranchInventory>[];

    for (final b in all) {
      if (b.isDefault == true && home == null) {
        home = b;
      } else if (b.isRegional == true) {
        regional.add(b);
      } else {
        other.add(b);
      }
    }

    int byName(CscoBranchInventory a, CscoBranchInventory b) =>
        (a.warehouse ?? '').toLowerCase().compareTo(
              (b.warehouse ?? '').toLowerCase(),
            );
    regional.sort(byName);
    other.sort(byName);

    return WareHouseInventoryLoadedState(
      homeBranch: home,
      regionalBranches: regional,
      otherBranches: other,
    );
  }
}
