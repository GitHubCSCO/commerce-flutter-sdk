// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class BillingAddressState {}

class BillingAddressInitialState extends BillingAddressState {}

class BillingAddressLoadingState extends BillingAddressState {}

class BilingAddressLoadedState extends BillingAddressState {
  final List<Country> countries;
  final List<StateModel>? states;
  BilingAddressLoadedState({
    required this.countries,
    required this.states,
  });
}
