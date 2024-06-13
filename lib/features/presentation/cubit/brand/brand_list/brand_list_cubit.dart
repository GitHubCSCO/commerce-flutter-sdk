import 'package:commerce_flutter_app/features/domain/usecases/brand_usecase/brand_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'brand_list_state.dart';

class BrandListCubit extends Cubit<BrandListState> {

  final BrandUseCase _brandUseCase;

  BrandListCubit({required BrandUseCase brandUseCase})
      : _brandUseCase = brandUseCase,
        super(BrandListInitial());

  Future<void> getBrands(String name) async {
    emit(BrandListLoading());

    final response = await _brandUseCase.getBrands(name);
    switch (response) {
      case Success(value: final data):
        emit(BrandListLoaded(data));
      case Failure(errorResponse: final error):
        emit(BrandListFailed(error: error.message ?? ''));
    }
  }

}
