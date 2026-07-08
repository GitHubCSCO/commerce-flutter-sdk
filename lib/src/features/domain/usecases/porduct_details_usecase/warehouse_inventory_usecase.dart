import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/model/csco_branch_inventory.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/csco_inventory_service.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

/// Usecase backing the "View Availability by Warehouse" modal.
///
/// CSCO uses a custom endpoint that returns warehouse-by-warehouse stock for
/// a given product. We no longer call the standard Optimizely real-time
/// inventory or product/expand=warehouses endpoints here — the ERP doesn't
/// populate them in a useful way for this customer.
class WarehouseInventoryUsecase extends BaseUseCase {
  WarehouseInventoryUsecase() : super();

  Future<Result<CscoBranchInventoryResponse, ErrorResponse>>
      getCscoBranchInventory(String? productId) async {
    return sl<ICscoInventoryService>().getBranchInventory(productId ?? '');
  }
}
