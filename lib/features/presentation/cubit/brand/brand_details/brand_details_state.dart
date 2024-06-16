part of 'brand_details_cubit.dart';

abstract class BrandDetailsState {}

class BrandDetailsInitial extends BrandDetailsState {}
class BrandDetailsLLoading extends BrandDetailsState {}
class BrandDetailsLoaded extends BrandDetailsState {

  final BrandDetailsEntity brandDetailsEntity;

  BrandDetailsLoaded({required this.brandDetailsEntity});

}
class BrandDetailsFailed extends BrandDetailsState {

  final String error;

  BrandDetailsFailed({required this.error});

}
