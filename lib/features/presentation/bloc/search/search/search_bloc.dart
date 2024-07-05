import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final SearchUseCase _searchUseCase;

  String searchQuery = "";
  bool isSearchProductActive = false;

  SearchBloc({required SearchUseCase searchUseCase})
      : _searchUseCase = searchUseCase,
        super(SearchCmsInitialState()) {
    on<SearchAutoCompleteLoadEvent>(_onSearchAutoCompleteLoadEvent);
    on<SearchFocusEvent>(_onSearchFocusEvent);
    on<SearchTypingEvent>(_onSearchTypingEvent);
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
        emit(SearchAutoCompleteFailureState(errorResponse.errorDescription ?? ''));
      default:
    }
  }

  Future<void> _onSearchFocusEvent(SearchFocusEvent event, Emitter<SearchState> emit) async {
    if (searchQuery.isEmpty) {
      emit(SearchAutoCompleteInitialState());
    } else {
      emit(SearchLoadingState());
      final result = await _searchUseCase.loadAutocompleteResults(searchQuery);
      switch (result) {
        case Success(value: final data):
          emit(SearchAutoCompleteLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(SearchAutoCompleteFailureState(errorResponse.errorDescription ?? ''));
        default:
      }
    }
  }

  Future<void> _onSearchTypingEvent(SearchTypingEvent event, Emitter<SearchState> emit) async {
    searchQuery = event.searchQuery;
    if (searchQuery.isEmpty) {
      emit(SearchAutoCompleteInitialState());
    } else {
      emit(SearchLoadingState());
      final result = await _searchUseCase.loadAutocompleteResults(searchQuery);
      switch (result) {
        case Success(value: final data):
          emit(SearchAutoCompleteLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(SearchAutoCompleteFailureState(errorResponse.errorDescription ?? ''));
        default:
      }
    }
  }

  Future<void> _onSearchUnFocusEvent(SearchUnFocusEvent event, Emitter<SearchState> emit) async {
    if (searchQuery.isEmpty) {
      emit(SearchCmsInitialState());
    }
  }

  Future<void> _onSearchSearchEvent(SearchSearchEvent event, Emitter<SearchState> emit) async {
    if (searchQuery.isNotEmpty) {
      emit(SearchLoadingState());
      final result = await _searchUseCase.loadSearchProductsResults(searchQuery, 1);
      switch (result) {
        case Success(value: final data):
          emit(SearchProductsLoadedState(result: data));
        case Failure(errorResponse: final errorResponse):
          emit(SearchProductsFailureState(errorResponse.errorDescription ?? ''));
        default:
      }
    }
  }

  Future<void> _onSearchCloseEvent(SearchCloseEvent event, Emitter<SearchState> emit) async {
    searchQuery = "";
    emit(SearchCmsInitialState());
  }

  Future<void> _onAutoCompleteCategoryEvent(AutoCompleteCategoryEvent event, Emitter<SearchState> emit) async {
    final categoryId = event.category.id;
    if (categoryId == null) {
      return;
    }
    
    emit(SearchLoadingState());
    
    final category = (await _searchUseCase.getCategory(categoryId)).getResultSuccessValue();
    if (category == null) {
      return;
    }

    if ((category.subCategories ?? []).isNotEmpty) {
      emit(AutoCompleteCategoryState(category));
    } else {
      final parameters = CategoryQueryParameters(
        maxDepth: 2,
        startCategoryId: category.id
      );

      final subCategories = (await _searchUseCase.getCategoryList(parameters)).getResultSuccessValue();
      if (subCategories == null || subCategories.isEmpty) {
        final pageEntity = ProductPageEntity('', ProductParentType.category, category: category);
        emit(AutoCompleteProductListState(pageEntity));
      } else {
        emit(AutoCompleteCategoryState(category));
      }
    }
    add(SearchAutoCompleteLoadEvent(searchQuery));
  }

  Future<void> _onAutoCompleteBrandEvent(AutoCompleteBrandEvent event, Emitter<SearchState> emit) async {
    final brandId = event.brand.id;
    if (brandId == null) {
      return;
    }

    emit(SearchLoadingState());

    final brand = (await _searchUseCase.getBrand(brandId)).getResultSuccessValue();
    if (brand == null) {
      return;
    }

    if (event.brand.productLineId != null) {
      final brandProductLine = BrandProductLine(
        id: event.brand.productLineId,
        name: event.brand.productLineName
      );
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
    add(SearchAutoCompleteLoadEvent(searchQuery));
  }

}
