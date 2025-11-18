import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class CurrencyEvent {}

class CurrencyLoadEvent extends CurrencyEvent {}

class CurrencyListLoadEvent extends CurrencyEvent {}

class CurrencyChangeEvent extends CurrencyEvent {
  final Currency currency;
  CurrencyChangeEvent({
    required this.currency,
  });
}
