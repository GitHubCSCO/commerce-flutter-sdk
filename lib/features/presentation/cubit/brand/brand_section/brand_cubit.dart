import 'package:commerce_flutter_app/features/domain/usecases/brand_usecase/brand_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {

  final BrandUseCase _brandUseCase;

  BrandCubit({required BrandUseCase brandUseCase})
      : _brandUseCase = brandUseCase,
        super(BrandInitial());

  Future<void> getBrandAlphabet() async {
    emit(BrandLoading());

    final response = await _brandUseCase.getAlphabet();
    switch (response) {
      case Success(value: final data):
        emit(BrandLoaded(data, -1));
      case Failure(errorResponse: final error):
        emit(BrandFailed(error: error.message ?? ''));
    }
  }

  void togglePanel(int index) {
    if (state is BrandLoaded) {
      final currentState = state as BrandLoaded;
      final newIndex = currentState.currentPanelIndex == index ? -1 : index;
      emit(BrandLoaded(currentState.alphabetResult, newIndex));
    }
  }

}
