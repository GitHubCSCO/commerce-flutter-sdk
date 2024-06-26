part of 'brand_bloc.dart';

abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandSectionLoaded extends BrandState {

  BrandAlphabetResult? alphabetResult;
  final int currentPanelIndex;

  BrandSectionLoaded(this.alphabetResult, this.currentPanelIndex);

}

class BrandSectionFailed extends BrandState {

  final String error;

  BrandSectionFailed({required this.error});

}

class BrandAutoCompleteLoaded extends BrandState {

  List<AutocompleteBrand>? brandList;

  BrandAutoCompleteLoaded(this.brandList);

}

class BrandAutoCompleteFailed extends BrandState {

  final String error;

  BrandAutoCompleteFailed({required this.error});

}


class BrandLoaded extends BrandState {

  final Brand brand;

  BrandLoaded({required this.brand});

}


