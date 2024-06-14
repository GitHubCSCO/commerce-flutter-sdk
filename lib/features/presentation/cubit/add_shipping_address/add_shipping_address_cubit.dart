import 'package:commerce_flutter_app/features/domain/usecases/add_shipping_address_usecase/add_shipping_address_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_shipping_address/add_shipping_address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddShippingAddressCubit extends Cubit<AddShippingAddressState> {
  final AddShippingAddressUsecase _addShippingAddressUsecase;
  Country? selectedCountry;
  StateModel? selectedState;
  AddShippingAddressCubit(
      {required AddShippingAddressUsecase addShippingAddressUsecase})
      : _addShippingAddressUsecase = addShippingAddressUsecase,
        super(AddShippingAddtessInitialState());

  Future<void> setUpDataShippingAddress() async {
    emit(AddShippingAddtessLoadingState());
    var countryListResponse = await _addShippingAddressUsecase.getCountries();

    List<Country> countries = (countryListResponse is Success)
        ? (countryListResponse as Success).value.countries
        : [];

    emit(AddShippingAddtessLoadedState(
        countries: countries,
        states: (selectedCountry != null) ? selectedCountry!.states : []));
  }

  Future<void> onSelectCountry(Country? counrty) async {
    selectedCountry = counrty;

    setUpDataShippingAddress();
  }

  Future<void> onSelectState(StateModel? state) async {
    selectedState = state;
    setUpDataShippingAddress();
  }
}
