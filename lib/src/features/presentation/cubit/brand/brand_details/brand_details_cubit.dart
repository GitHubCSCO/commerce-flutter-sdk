import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/brand_usecase/brand_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/brand/brand_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'brand_details_state.dart';

class BrandDetailsCubit extends Cubit<BrandDetailsState> {
  final BrandUseCase _brandUseCase;

  BrandDetailsCubit({required BrandUseCase brandUseCase})
      : _brandUseCase = brandUseCase,
        super(BrandDetailsInitial());

  Future<void> getBrandDetails(Brand brand) async {
    emit(BrandDetailsLLoading());

    final response = await _brandUseCase.getBrandDetails(brand);

    switch (response) {
      case Success(value: final value):
        {
          emit(BrandDetailsLoaded(brandDetailsEntity: value!));
        }
      case Failure(errorResponse: final errorResponse):
        {
          _brandUseCase.trackError(errorResponse);
          emit(BrandDetailsFailed(
              error: errorResponse.message ??
                  LocalizationConstants.noBrandDetailsFound.localized()));
        }
    }
  }

  Future<GetBrandSubCategoriesResult?> onSelectBrandCategory(
      BrandCategory? brandCategory) async {
    final brandCategoriesQueryParameter = BrandCategoriesQueryParameter(
        brandId: brandCategory?.brandId, categoryId: brandCategory?.categoryId);
    final response = await _brandUseCase
        .getBrandCategorySubCategories(brandCategoriesQueryParameter);
    return response.getResultSuccessValue();
  }

  Future<BrandCategory?> getShopAllBrandStartingCategory() async {
    var startingCategoryId = await _brandUseCase.coreServiceProvider
        .getAppConfigurationService()
        .startingCategoryForBrowsing();
    if (startingCategoryId.isNullOrEmpty ||
        startingCategoryId == CoreConstants.emptyGuidString) {
      return null;
    }
    return BrandCategory(categoryId: startingCategoryId);
  }
}
