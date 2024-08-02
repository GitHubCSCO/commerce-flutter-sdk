import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quick_order_usecase/count_inventory_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'count_inventory_state.dart';

class CountInventoryCubit extends Cubit<CountInventoryState> {
  final CountInventoryUseCase _countInventoryUseCase;

  CountInventoryCubit({required CountInventoryUseCase countInventoryUseCase})
      : _countInventoryUseCase = countInventoryUseCase,
        super(CountInventoryInitial());

  Future<void> updateInventoryQuantity(
      VmiBinModelEntity vmiBinEntity, String qtyStr) async {
    int qty = convertStringToInt(qtyStr);

    if (qty <= 0) {
      emit(CountInventoryAlert(
          LocalizationConstants.quantityIsRequired.localized()));
    } else {
      final result =
          await _countInventoryUseCase.saveBinCount(vmiBinEntity, qty);
      switch (result) {
        case Success(value: final countModel):
          {
            if (countModel != null) {
              emit(CountInventorySuccess(qty));
            } else {
              emit(CountInventoryAlert(
                  LocalizationConstants.failed.localized()));
            }
          }
        case Failure(errorResponse: final errorResponse):
          {
            emit(CountInventoryAlert(errorResponse.message ??
                LocalizationConstants.failed.localized()));
          }
      }
    }
  }

  int convertStringToInt(String str) {
    try {
      return int.parse(str);
    } catch (e) {
      return 0;
    }
  }
}
