import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class AddShippingAddressState {}

class AddShippingAddtessInitialState extends AddShippingAddressState {}

class AddShippingAddtessLoadingState extends AddShippingAddressState {}

class AddShippingAddtessLoadedState extends AddShippingAddressState {
  final List<Country> countries;
  final List<StateModel>? states;
  AddShippingAddtessLoadedState({
    required this.countries,
    required this.states,
  });
}

class AddShippingAddressUpdateToggleState extends AddShippingAddressState {}
