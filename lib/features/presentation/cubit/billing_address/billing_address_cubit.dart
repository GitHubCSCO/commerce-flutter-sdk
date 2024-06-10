import 'package:commerce_flutter_app/features/domain/usecases/billing_address_create_usecase/billing_address_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/billing_address/billing_address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BillingAddressCubit extends Cubit<BillingAddressState> {
  final BillingAddressUsecase _billingAddressUsecase;

  Country? selectedCountry;
  StateModel? selectedState;

  BillingAddressCubit({required BillingAddressUsecase billingAddressUsecase})
      : _billingAddressUsecase = billingAddressUsecase,
        super(BillingAddressInitialState());

  Future<void> setUpDataBillingAddress() async {
    emit(BillingAddressLoadingState());
    var countryListResponse = await _billingAddressUsecase.getCountries();

    List<Country> countries = (countryListResponse is Success)
        ? (countryListResponse as Success).value.countries
        : [];

    emit(BilingAddressLoadedState(
        countries: countries,
        states: (selectedCountry != null) ? selectedCountry!.states : []));
  }

  Future<void> onSelectCountry(Country? counrty) async {
    selectedCountry = counrty;

    setUpDataBillingAddress();
  }

  Future<void> onSelectState(StateModel? state) async {
    selectedState = state;
    setUpDataBillingAddress();
  }
}
