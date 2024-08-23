part of 'root_bloc.dart';

abstract class RootState {}

class RootInitial extends RootState {}

class RootPricingInventoryReload extends RootState {}

class RootConfigReload extends RootState {}

class RootCartReload extends RootState {}

class RootInitiateSearch extends RootState {
  final String query;

  RootInitiateSearch(this.query);
}

class RootSearchProduct extends RootState {
  final String query;

  RootSearchProduct(this.query);
}
