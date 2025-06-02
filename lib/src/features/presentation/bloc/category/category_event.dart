part of 'category_bloc.dart';

abstract class CategoryEvent {}

class TopCategoryLoadEvent extends CategoryEvent {}

class CategoryLoadEvent extends CategoryEvent {
  Category? category;
  CategoryLoadEvent({this.category});
}
