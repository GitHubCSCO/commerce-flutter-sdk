import 'package:commerce_flutter_sdk/src/features/domain/usecases/brand_product_lines_usecase/brand_product_lines_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'brand_product_lines_state.dart';

class BrandProductLinesCubit extends Cubit<BrandProductLinesState> {
  final BrandProductLinesUseCase _brandProductLinesUseCase;
  BrandProductLinesCubit(
      {required BrandProductLinesUseCase brandProductLinesUseCase})
      : _brandProductLinesUseCase = brandProductLinesUseCase,
        super(BrandProductLinesInitial());

  Future<void> getBrandProductLines(Brand brand) async {
    emit(BrandProductLinesInitial());
    final response =
        await _brandProductLinesUseCase.getBrandProductLines(brand);
    if (response != null) {
      emit(BrandProductLinesLoaded(list: response));
    } else {
      emit(BrandProductLinesFailed(error: "No product lines found"));
    }
  }
}
