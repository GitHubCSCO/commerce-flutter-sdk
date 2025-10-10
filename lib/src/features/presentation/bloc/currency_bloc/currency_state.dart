import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {}

class CurrencyListLoaded extends CurrencyState {
  final List<Currency>? currencies;
  final Currency? selectedCurrency;

  CurrencyListLoaded(this.currencies, this.selectedCurrency);
}

class CurrencyFailedToLoad extends CurrencyState {
  final String error;
  CurrencyFailedToLoad(this.error);
}

class CurrencyChanged extends CurrencyState {}
