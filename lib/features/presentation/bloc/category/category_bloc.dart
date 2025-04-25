import 'package:commerce_flutter_sdk/features/domain/usecases/category_usecase/category_useacase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUseCase _categoryUseCase;

  CategoryBloc({required CategoryUseCase categoryUseCase})
      : _categoryUseCase = categoryUseCase,
        super(CategoryInitial()) {
    on<TopCategoryLoadEvent>(
        (event, emit) => _onTopCategoryLoadEvent(event, emit));
    on<CategoryLoadEvent>((event, emit) => _onCategoryLoadEvent(event, emit));
  }

  Future<void> _onTopCategoryLoadEvent(
      TopCategoryLoadEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());

    final response = await _categoryUseCase.getTopCategories();

    switch (response) {
      case Success(value: final data):
        {
          emit(CategoryLoaded(list: data ?? []));
          break;
        }
      case Failure(errorResponse: final error):
        {
          _categoryUseCase.trackError(error);
          emit(CategoryFailed(error: error.message ?? ''));
          break;
        }
    }
  }

  Future<void> _onCategoryLoadEvent(
      CategoryLoadEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());

    final response =
        await _categoryUseCase.getCategories(categoryId: event.category?.id);

    switch (response) {
      case Success(value: final data):
        {
          emit(CategoryLoaded(list: data ?? []));
          break;
        }
      case Failure(errorResponse: final error):
        {
          _categoryUseCase.trackError(error);
          emit(CategoryFailed(error: error.message ?? ''));
          break;
        }
    }
  }
}
