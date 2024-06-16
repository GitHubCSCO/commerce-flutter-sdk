part of 'brand_product_line_cubit.dart';

abstract class BrandProductLinesState {}

class BrandProductLinesInitial extends BrandProductLinesState {}

class BrandProductLinesLoading extends BrandProductLinesState {}

class BrandProductLinesLoaded extends BrandProductLinesState {
  final List<BrandProductLine> list;
  BrandProductLinesLoaded({required this.list});
}

class BrandProductLinesFailed extends BrandProductLinesState {
  final String error;
  BrandProductLinesFailed({required this.error});
}
