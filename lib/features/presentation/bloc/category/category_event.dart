part of 'category_bloc.dart';

abstract class CategoryEvent {}

class TopCategoryLoadEvent extends CategoryEvent {}

class CategoryLoadEvent extends CategoryEvent {
  String? categoryId;
  CategoryLoadEvent({this.categoryId});
}
