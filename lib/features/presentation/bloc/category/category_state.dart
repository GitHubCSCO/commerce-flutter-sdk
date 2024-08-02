part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  List<Category> list;

  CategoryLoaded({required this.list});
}

class CategoryFailed extends CategoryState {
  final String error;

  CategoryFailed({required this.error});
}
