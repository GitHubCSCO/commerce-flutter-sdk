part of 'brand_list_cubit.dart';

abstract class BrandListState {}

class BrandListInitial extends BrandListState {}

class BrandListLoading extends BrandListState {}

class BrandListLoaded extends BrandListState {
  GetBrandsResult? brandsResult;

  BrandListLoaded(this.brandsResult);
}

class BrandListFailed extends BrandListState {
  final String error;

  BrandListFailed({required this.error});
}
