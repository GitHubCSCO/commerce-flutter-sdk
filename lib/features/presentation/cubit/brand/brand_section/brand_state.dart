part of 'brand_cubit.dart';

abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandLoaded extends BrandState {

  BrandAlphabetResult? alphabetResult;
  final int currentPanelIndex;

  BrandLoaded(this.alphabetResult, this.currentPanelIndex);

}

class BrandFailed extends BrandState {

  final String error;

  BrandFailed({required this.error});

}
