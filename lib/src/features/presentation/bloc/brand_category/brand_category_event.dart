part of 'brand_category_bloc.dart';

abstract class BrandCategoryEvent {}

class BrandCategoryLoadEvent extends BrandCategoryEvent {
  BrandCategory? brandCategory;
  GetBrandSubCategoriesResult? brandSubCategories;
  Brand brand;
  BrandCategoryLoadEvent(
      {required this.brand, this.brandCategory, this.brandSubCategories});
}
