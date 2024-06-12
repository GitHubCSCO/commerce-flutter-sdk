import 'package:commerce_flutter_app/features/domain/usecases/category_usecase/category_useacase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  final CategoryUseCase _categoryUseCase;

  CategoryBloc({required CategoryUseCase categoryUseCase})
      : _categoryUseCase = categoryUseCase,
        super(CategoryInitial()) {
    on<CategoryLoadEvent>((event, emit) => _onCategoryLoadEvent(event, emit));
  }

  Future<void> _onCategoryLoadEvent(CategoryLoadEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());

    final response = await _categoryUseCase.getCategories();

    switch (response) {
      case Success(value: final data):
        emit(CategoryLoaded(list: data ?? []));
      case Failure(errorResponse: final error):
        emit(CategoryFailed(error: error.message ?? ''));
    }
  }

}
