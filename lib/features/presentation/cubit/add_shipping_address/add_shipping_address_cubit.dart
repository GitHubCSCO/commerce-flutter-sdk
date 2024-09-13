import 'dart:collection';

import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/usecases/add_shipping_address_usecase/add_shipping_address_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_shipping_address/add_shipping_address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddShippingAddressCubit extends Cubit<AddShippingAddressState> {
  final AddShippingAddressUsecase _addShippingAddressUseCase;
  Country? selectedCountry;
  StateModel? selectedState;
  bool isSavedAddress = false;
  AddShippingAddressCubit(
      {required AddShippingAddressUsecase addShippingAddressUsecase})
      : _addShippingAddressUseCase = addShippingAddressUsecase,
        super(AddShippingAddressInitialState());

  Future<void> setUpDataShippingAddress() async {
    var countryListResponse = await _addShippingAddressUseCase.getCountries();

    List<Country> countries = (countryListResponse is Success)
        ? (countryListResponse as Success).value.countries
        : [];

    final siteMessages = await _loadSiteMessages();

    emit(AddShippingAddressLoadedState(
        countries: countries,
        states: (selectedCountry != null) ? selectedCountry!.states : [],
        siteMessages: siteMessages));
  }

  Future<HashMap<String, String>> _loadSiteMessages() async {
    var siteMessages = HashMap<String, String>();

    var siteMessagePairs = [
      [
        SiteMessageConstants.nameAddressInfoNameRequired,
        SiteMessageConstants.defaultValueAddressNameRequired
      ],
      [
        SiteMessageConstants.nameAddressInfoAddressOneRequired,
        SiteMessageConstants.defaultValueAddressAddressOneRequired
      ],
      [
        SiteMessageConstants.nameAddressInfoCountryRequired,
        SiteMessageConstants.defaultValueAddressCountryRequired
      ],
      [
        SiteMessageConstants.nameAddressInfoCityRequired,
        SiteMessageConstants.defaultValueAddressCityRequired
      ],
      [
        SiteMessageConstants.nameAddressInfoZipRequired,
        SiteMessageConstants.defaultValueAddressZipRequired
      ],
      [
        SiteMessageConstants.nameAddressInfoStateRequired,
        SiteMessageConstants.defaultValueAddressStateRequired
      ],
      [
        SiteMessageConstants.nameAddressInfoEmailAddressRequired,
        SiteMessageConstants.defaultValueAddressEmailRequired
      ],
      [
        SiteMessageConstants.nameAddressEmailInvalid,
        SiteMessageConstants.defaultValueAddressEmailInvalid
      ]
    ];

    final futureResult = await Future.wait(siteMessagePairs.map((pair) {
      return _addShippingAddressUseCase.getSiteMessage(pair[0], pair[1]);
    }));

    for (var i = 0; i < siteMessagePairs.length; i++) {
      siteMessages[siteMessagePairs[i][0]] = futureResult[i];
    }

    return siteMessages;
  }

  Future<void> onSelectCountry(Country? country) async {
    if (selectedCountry != null && selectedCountry?.id != country?.id) {
      selectedState = null;
    }
    selectedCountry = country;
    await setUpDataShippingAddress();
  }

  Future<void> onSelectState(StateModel? state) async {
    selectedState = state;
    await setUpDataShippingAddress();
  }

  Future<void> onUpdateSaveAddressToggle(bool value) async {
    isSavedAddress = value;
    emit(AddShippingAddressUpdateToggleState());
  }
}
