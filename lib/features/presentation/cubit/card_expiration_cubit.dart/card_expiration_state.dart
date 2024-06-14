import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class CardExpirationState {}

class CardExpirationInitialState extends CardExpirationState {}

class CardExpirationLoadingState extends CardExpirationState {}

class CardExpirationLoadedState extends CardExpirationState {}
