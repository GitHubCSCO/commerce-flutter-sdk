import 'package:commerce_flutter_sdk/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/brand_category_usecase/brand_category_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'brand_category_event.dart';
part 'brand_category_state.dart';

class BrandCategoryBloc extends Bloc<BrandCategoryEvent, BrandCategoryState> {
  final BrandCategoryUseCase _brandCategoryUseCase;

  BrandCategoryBloc({required BrandCategoryUseCase brandCategoryUseCase})
      : _brandCategoryUseCase = brandCategoryUseCase,
        super(BrandCategoryInitial()) {
    on<BrandCategoryLoadEvent>(
        (event, emit) => _onBrandCategoryLoadEvent(event, emit));
  }

  Future<void> _onBrandCategoryLoadEvent(
      BrandCategoryLoadEvent event, Emitter<BrandCategoryState> emit) async {
    emit(BrandCategoryLoading());

    final brandCategoriesQueryParameter =
        BrandCategoriesQueryParameter(brandId: event.brand.id, maximumDepth: 3);

    if (event.brandCategory != null) {
      brandCategoriesQueryParameter.categoryId =
          event.brandCategory?.categoryId;
      brandCategoriesQueryParameter.productListPagePath =
          event.brandCategory?.productListPagePath;
      final response = await _brandCategoryUseCase
          .getBrandCategorySubCategories(brandCategoriesQueryParameter);
      switch (response) {
        case Success(value: final data):
          {
            if (data?.subCategories != null) {
              var brandCatagories = data?.subCategories!
                      .map((e) => BrandCategory.mapCategoryToBrandCategory(e)!)
                      .toList() ??
                  [];
              emit(BrandCategoryLoaded(list: brandCatagories));
            } else {
              emit(BrandCategoryLoaded(list: []));
            }
          }
        case Failure(errorResponse: final error):
          {
            emit(BrandCategoryFailed(error: error.message ?? ''));
          }
      }
    } else {
      brandCategoriesQueryParameter.pageSize = CoreConstants.maxPageSize;
      final response = await _brandCategoryUseCase
          .getBrandCategories(brandCategoriesQueryParameter);
      switch (response) {
        case Success(value: final data):
          {
            emit(BrandCategoryLoaded(list: data?.brandCategories ?? []));
          }
        case Failure(errorResponse: final error):
          {
            emit(BrandCategoryFailed(error: error.message ?? ''));
          }
      }
    }
  }

  Future<GetBrandSubCategoriesResult?> onSelectBrandCategory(
      BrandCategory? brandCategory) async {
    final brandCategoriesQueryParameter = BrandCategoriesQueryParameter(
        brandId: brandCategory?.brandId, categoryId: brandCategory?.categoryId);
    final response = await _brandCategoryUseCase
        .getBrandCategorySubCategories(brandCategoriesQueryParameter);
    return response.getResultSuccessValue();
  }
}
