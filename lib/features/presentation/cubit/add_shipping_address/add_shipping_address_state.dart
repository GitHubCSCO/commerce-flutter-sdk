import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class AddShippingAddressState {}

class AddShippingAddressInitialState extends AddShippingAddressState {}

class AddShippingAddressLoadingState extends AddShippingAddressState {}

class AddShippingAddressLoadedState extends AddShippingAddressState {
  final List<Country> countries;
  final List<StateModel>? states;
  final Map<String, String> siteMessages;
  AddShippingAddressLoadedState({
    required this.countries,
    required this.states,
    required this.siteMessages,
  });
}

class AddShippingAddressUpdateToggleState extends AddShippingAddressState {}
