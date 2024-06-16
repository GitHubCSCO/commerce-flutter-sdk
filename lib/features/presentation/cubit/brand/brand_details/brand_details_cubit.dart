import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/usecases/brand_usecase/brand_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/brand/brand_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'brand_details_state.dart';

class BrandDetailsCubit extends Cubit<BrandDetailsState> {

  final BrandUseCase _brandUseCase;

  BrandDetailsCubit({required BrandUseCase brandUseCase}) : _brandUseCase = brandUseCase, super(BrandDetailsInitial());

  Future<void> getBrandDetails(Brand brand) async {
    emit(BrandDetailsLLoading());

    final response = await _brandUseCase.getBrandDetails(brand);
    emit(BrandDetailsLoaded(brandDetailsEntity: response));
  }

  Future<GetBrandSubCategoriesResult?> onSelectBrandCategory(BrandCategory? brandCategory) async {
    final brandCategoriesQueryParameter = BrandCategoriesQueryParameter(
      brandId: brandCategory?.brandId,
      categoryId: brandCategory?.categoryId
    );
    final response = await _brandUseCase.getBrandCategorySubCategories(brandCategoriesQueryParameter);
    return response.getResultSuccessValue();
  }
}
