import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase _searchUseCase;

  String searchQuery = "";
  BarcodeFormat? barcodeFormat;
  bool isSearchProductActive = false;

  SearchBloc({required SearchUseCase searchUseCase})
      : _searchUseCase = searchUseCase,
        super(SearchCmsInitialState()) {
    on<SearchAutoCompleteLoadEvent>(_onSearchAutoCompleteLoadEvent);
    on<SearchFocusEvent>(_onSearchFocusEvent);
    on<SearchTypingEvent>(_onSearchTypingEvent, transformer: restartable());
    on<SearchFieldPopulateEvent>(_onSearchFieldPopulateEvent);
    on<SearchUnFocusEvent>(_onSearchUnFocusEvent);
    on<SearchSearchEvent>(_onSearchSearchEvent);
    on<SearchCloseEvent>(_onSearchCloseEvent);
    on<AutoCompleteCategoryEvent>(_onAutoCompleteCategoryEvent);
    on<AutoCompleteBrandEvent>(_onAutoCompleteBrandEvent);
  }

  Future<void> _onSearchAutoCompleteLoadEvent(
      SearchAutoCompleteLoadEvent event, Emitter<SearchState> emit) async {
    var result = await _searchUseCase.loadAutocompleteResults(event.query);
    switch (result) {
      case Success(value: final data):
        emit(SearchAutoCompleteLoadedState(result: data));
      case Failure(errorResponse: final errorResponse):
        emit(SearchAutoCompleteFailureState(
            errorResponse.errorDescription ?? ''));
      default:
    }
  }

  Future<void> _onSearchFocusEvent(
      SearchFocusEvent event, Emitter<SearchState> emit) async {
    if (event.autoFocus) {
      emit(SearchAutoFocusResetState());
    }
    if (event.autoFocus == false) {
      if (searchQuery.isEmpty) {
        emit(SearchAutoCompleteInitialState());
      } else {
        emit(SearchLoadingState());
        final result =
            await _searchUseCase.loadAutocompleteResults(searchQuery);

        if (state is SearchCmsInitialState ||
            state is SearchProductsLoadedState) {
          return;
        }
        switch (result) {
          case Success(value: final data):
            emit(SearchAutoCompleteLoadedState(result: data));
          case Failure(errorResponse: final errorResponse):
            emit(SearchAutoCompleteFailureState(
                errorResponse.errorDescription ?? ''));
          default:
        }
      }
    }
  }

  Future<void> _onSearchFieldPopulateEvent(
      SearchFieldPopulateEvent event, Emitter<SearchState> emit) async {
    searchQuery = event.searchQuery;
    emit(SearchQueryLoadedState(searchQuery: event.searchQuery));
  }

  Future<void> _onSearchTypingEvent(
      SearchTypingEvent event, Emitter<SearchState> emit) async {
    searchQuery = event.searchQuery;
    if (searchQuery.isEmpty) {
      emit(SearchAutoCompleteInitialState());
    } else {
      emit(SearchLoadingState());
      final result = await _searchUseCase.loadAutocompleteResults(searchQuery);

      if (state is SearchCmsInitialState ||
          state is SearchProductsLoadedState) {
        return;
      }

      switch (result) {
        case Success(value: final data):
          emit(SearchAutoCompleteLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(SearchAutoCompleteFailureState(
              errorResponse.errorDescription ?? ''));
        default:
      }
    }
  }

  Future<void> _onSearchUnFocusEvent(
      SearchUnFocusEvent event, Emitter<SearchState> emit) async {
    if (searchQuery.isEmpty) {
      emit(SearchCmsInitialState());
    }
  }

  Future<void> _onSearchSearchEvent(
      SearchSearchEvent event, Emitter<SearchState> emit) async {
    if (searchQuery.isNotEmpty) {
      emit(SearchLoadingState());
      var result =
          await _searchUseCase.loadSearchProductsResults(searchQuery, 1);

      var apiCallIsSuccessful = false;
      var totalItemCount = result
              ?.getResultSuccessValue(trackError: false)
              ?.pagination
              ?.totalItemCount ??
          0;

      //This is a workaround for ICM-4422 where leading 0 in EAN-13 code gets dropped by the MLKit
      if (totalItemCount == 0 && barcodeFormat != null) {
        _searchUseCase.trackEvent(AnalyticsEvent(
                AnalyticsConstants.eventScanBarcode,
                AnalyticsConstants.screenNameSearch)
            .withProperty(
                name: AnalyticsConstants.eventPropertyBarcode,
                strValue: searchQuery)
            .withProperty(
                name: AnalyticsConstants.eventPropertyBarcodeFormat,
                strValue: barcodeFormat?.name));
        /*
        For example we have a product: 012546011099
        It's UPC-A will be: 0-12546-01109-9
        It's EAN-13 will be: 0-125460-110998
        When we scan UPC-A, it return successfully and we get 012546011099 and barcode format is BarcodeFormat.upca
        But, when we scan EAN-13, it returns 125460110998 and barcode format is BarcodeFormat.upca
        */
        if ((barcodeFormat == BarcodeFormat.ean13 ||
                barcodeFormat == BarcodeFormat.upca) &&
            searchQuery.length == 12) {
          //since in both cases result text is 12 digit it's difficult to know whether it's upc-a or ean13
          //upc-a can also have non-zero leading digit, since we didn't find any result with that
          //let's assume it's ean-13
          if (searchQuery[0] != '0') {
            var modifiedSearchQuery = "0$searchQuery";
            result = await _searchUseCase.loadSearchProductsResults(
                modifiedSearchQuery, 1);
            totalItemCount = result
                    ?.getResultSuccessValue(trackError: false)
                    ?.pagination
                    ?.totalItemCount ??
                0;
            searchQuery = modifiedSearchQuery;
          }
        }
      }

      if (state is SearchCmsInitialState) {
        return;
      }

      switch (result) {
        case Success(value: final data):
          apiCallIsSuccessful = true;
          emit(SearchProductsLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(
              SearchProductsFailureState(errorResponse.errorDescription ?? ''));
        default:
      }

      _trackViewSearchResultsEvent(
          searchQuery, apiCallIsSuccessful, totalItemCount);
    }
  }

  Future<void> _onSearchCloseEvent(
      SearchCloseEvent event, Emitter<SearchState> emit) async {
    searchQuery = "";
    emit(SearchCmsInitialState());
  }

  Future<void> _onAutoCompleteCategoryEvent(
      AutoCompleteCategoryEvent event, Emitter<SearchState> emit) async {
    final categoryId = event.category.id;
    if (categoryId == null) {
      return;
    }

    emit(SearchLoadingState());

    final category =
        (await _searchUseCase.getCategory(categoryId)).getResultSuccessValue();
    if (category == null) {
      return;
    }

    if ((category.subCategories ?? []).isNotEmpty) {
      emit(AutoCompleteCategoryState(category));
    } else {
      final parameters =
          CategoryQueryParameters(maxDepth: 2, startCategoryId: category.id);

      final subCategories = (await _searchUseCase.getCategoryList(parameters))
          .getResultSuccessValue();
      if (subCategories == null || subCategories.isEmpty) {
        final pageEntity = ProductPageEntity('', ProductParentType.category,
            category: category);
        emit(AutoCompleteProductListState(pageEntity));
      } else {
        emit(AutoCompleteCategoryState(category));
      }
    }

    if (state is SearchCmsInitialState) {
      return;
    }

    add(SearchAutoCompleteLoadEvent(searchQuery));
  }

  Future<void> _onAutoCompleteBrandEvent(
      AutoCompleteBrandEvent event, Emitter<SearchState> emit) async {
    final brandId = event.brand.id;
    if (brandId == null) {
      return;
    }

    emit(SearchLoadingState());

    final brand =
        (await _searchUseCase.getBrand(brandId)).getResultSuccessValue();
    if (brand == null) {
      return;
    }

    if (event.brand.productLineId != null) {
      final brandProductLine = BrandProductLine(
          id: event.brand.productLineId, name: event.brand.productLineName);
      final productPageEntity = ProductPageEntity(
        '',
        ProductParentType.brandProductLine,
        brandProductLine: brandProductLine,
        brandEntityId: brand.id,
        pageTitle: brandProductLine.name,
      );
      emit(AutoCompleteProductListState(productPageEntity));
    } else {
      emit(AutoCompleteBrandState(brand));
    }

    if (state is SearchCmsInitialState) {
      return;
    }

    add(SearchAutoCompleteLoadEvent(searchQuery));
  }

  void _trackViewSearchResultsEvent(
      String query, bool apiCallIsSuccessful, int resultsCount) {
    var viewScreenEvent = AnalyticsEvent(
            AnalyticsConstants.eventViewSearchResults,
            AnalyticsConstants.screenNameSearch)
        .withProperty(
            name: AnalyticsConstants.eventPropertySearchTerm, strValue: query)
        .withProperty(
            name: AnalyticsConstants.eventPropertyResultsCount,
            strValue: resultsCount.toString())
        .withProperty(
            name: AnalyticsConstants.eventPropertySuccessful,
            boolValue: apiCallIsSuccessful);
    _searchUseCase.trackEvent(viewScreenEvent);
  }
}
