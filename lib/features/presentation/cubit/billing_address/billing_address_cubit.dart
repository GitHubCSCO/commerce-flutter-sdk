import 'package:commerce_flutter_app/features/domain/usecases/billing_address_create_usecase/billing_address_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/billing_address/billing_address_state.dart';
import 'package:commerce_flutter_app/features/presentation/widget/add_credit_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BillingAddressCubit extends Cubit<BillingAddressState> {
  final BillingAddressUsecase _billingAddressUsecase;

  AddCreditCardEntity? addCreditCardEntity;
  bool billingAddressAddNewToggle = false;
  Country? selectedCountry;
  Session? session;
  StateModel? selectedState;
  List<Country>? countries;
  BillTo? billTo;

  BillingAddressCubit({required BillingAddressUsecase billingAddressUsecase})
      : _billingAddressUsecase = billingAddressUsecase,
        super(BillingAddressInitialState());

  Future<void> setUpDataBillingAddress(
      AddCreditCardEntity? addCreditCardEntity) async {
    this.addCreditCardEntity = addCreditCardEntity;
    if (countries == null || countries!.isEmpty) {
      emit(BillingAddressLoadingState());
      var countryListResponse = await _billingAddressUsecase.getCountries();

      countries = (countryListResponse is Success)
          ? (countryListResponse as Success).value.countries
          : [];
    }

    if (addCreditCardEntity != null &&
        !addCreditCardEntity.isAddNewCreditCard) {
      setSelectedCountryFromSavedCard(addCreditCardEntity);
    }
    var showAddNewBillingAddressFields = !billingAddressAddNewToggle;
    if (showAddNewBillingAddressFields) {
      emit(BilingAddressLoadedState(
          showNewBillingAddressFields: billingAddressAddNewToggle,
          countries: countries ?? [],
          states: (selectedCountry != null) ? selectedCountry!.states : []));
    } else {
      if (session == null) {
        emit(BillingAddressLoadingState());
        var sessionResponse = await _billingAddressUsecase.getCurrentSession();
        Session? session = sessionResponse is Success
            ? (sessionResponse as Success).value as Session
            : null;

        this.session = session;
      }

      billTo = session?.billTo;

      if (session != null) {
        emit(BilingAddressLoadedState(
            showNewBillingAddressFields: billingAddressAddNewToggle,
            countries: countries ?? [],
            states: (selectedCountry != null) ? selectedCountry!.states : [],
            billTo: session?.billTo));
      }
    }
  }

  void setSelectedCountryFromSavedCard(
      AddCreditCardEntity addCreditCardEntity) {
    for (var country in countries!) {
      if (country.abbreviation ==
          addCreditCardEntity.accountPaymentProfile?.country) {
        selectedCountry = country;
        break;
      }
    }

    for (var state in selectedCountry?.states ?? []) {
      if (state.abbreviation ==
          addCreditCardEntity.accountPaymentProfile?.state) {
        selectedState = state;
        break;
      }
    }
  }

  Future<void> onSelectCountry(Country? counrty) async {
    selectedCountry = counrty;
    setUpDataBillingAddress(addCreditCardEntity);
  }

  Future<void> onSelectState(StateModel? state) async {
    selectedState = state;
    setUpDataBillingAddress(addCreditCardEntity);
  }

  Future<void> updateaddNewBillingAddressToggleState() async {
    billingAddressAddNewToggle = !billingAddressAddNewToggle;
    setUpDataBillingAddress(addCreditCardEntity);
  }
}
