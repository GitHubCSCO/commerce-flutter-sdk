part of 'brand_category_bloc.dart';

abstract class BrandCategoryState {}

class BrandCategoryInitial extends BrandCategoryState {}

class BrandCategoryLoading extends BrandCategoryState {}

class BrandSubCategoryLoaded extends BrandCategoryState {
  List<GetBrandSubCategoriesResult> list;
  BrandSubCategoryLoaded({required this.list});
}

class BrandCategoryLoaded extends BrandCategoryState {
  List<BrandCategory> list;
  BrandCategoryLoaded({required this.list});
}

class BrandCategoryFailed extends BrandCategoryState {
  final String error;
  BrandCategoryFailed({required this.error});
}
