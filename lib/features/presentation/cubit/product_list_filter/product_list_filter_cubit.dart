import 'package:commerce_flutter_app/features/domain/enums/product_list_filter_status.dart';
import 'package:commerce_flutter_app/features/domain/enums/product_list_type.dart';
import 'package:commerce_flutter_app/features/domain/usecases/product_list_filter_usecase/product_list_filter_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'product_list_filter_state.dart';

class ProductListFilterCubit extends Cubit<ProductListFilterState> {
  final ProductListFilterUsecase _productListFilterUsecase;

  ProductListFilterCubit(
      {required ProductListFilterUsecase productListFilterUsecase})
      : _productListFilterUsecase = productListFilterUsecase,
        super(
          ProductListFilterState(
            productsParameters: ProductsQueryParameters(
              replaceProducts: false,
              getAllAttributeFacets: false,
              includeAlternateInventory: true,
              previouslyPurchasedProducts: false,
              stockedItemsOnly: false,
              page: 1,
              pageSize: 16,
              makeBrandUrls: false,
              expand: ["pricing", "facets", "brand"],
              includeSuggestions: "True",
            ),
            productSettings: ProductSettings(),
            searchSettings: SearchSettings(),
            status: ProductListFilterStatus.initial,
            filterValues: const [],
          ),
        );

  Future<void> initialize({
    required ProductListType productListType,
    required ProductsQueryParameters productsParameters,
  }) async {
    emit(
      state.copyWith(
        status: ProductListFilterStatus.loading,
        productsParameters: productsParameters,
      ),
    );

    final settingsCollection =
        await _productListFilterUsecase.loadSettingsCollection();

    if (settingsCollection == null) {
      emit(state.copyWith(status: ProductListFilterStatus.failure));
      return;
    }

    emit(
      state.copyWith(
        productSettings: settingsCollection.productSettings,
        searchSettings: settingsCollection.searchSettings,
      ),
    );

    await loadFilters(productListType: productListType);
  }

  Future<void> loadFilters({
    required ProductListType productListType,
  }) async {
    if (state.status != ProductListFilterStatus.loading) {
      emit(state.copyWith(status: ProductListFilterStatus.loading));
    }

    final filters = await _productListFilterUsecase.loadFilters(
      productsQueryParameters: state.productsParameters,
      productSettings: state.productSettings,
      searchSettings: state.searchSettings,
      productListType: productListType,
    );

    if (filters == null) {
      emit(state.copyWith(status: ProductListFilterStatus.failure));
      return;
    }

    emit(
      state.copyWith(
        filterValues: filters,
        status: ProductListFilterStatus.success,
      ),
    );
  }
}
