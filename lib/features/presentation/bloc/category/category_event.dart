part of 'category_bloc.dart';

abstract class CategoryEvent {}

class CategoryLoadEvent extends CategoryEvent {
  String? categoryId;
  CategoryLoadEvent({this.categoryId});
}
