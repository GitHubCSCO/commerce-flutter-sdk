import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/mixins/validator_mixin.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_shipping_address/add_shipping_address_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_shipping_address/add_shipping_address_state.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddShippingAddressScreen extends StatelessWidget {
  final void Function(ShipTo) onShippingAddressAdded;

  const AddShippingAddressScreen({
    super.key,
    required this.onShippingAddressAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: OptiAppColors.backgroundWhite,
          title: Text(LocalizationConstants.shippingAddress.localized()),
          centerTitle: false,
        ),
        body: MultiBlocProvider(
            providers: [
              BlocProvider<AddShippingAddressCubit>(
                  create: (context) => sl<AddShippingAddressCubit>()
                    ..setUpDataShippingAddress()),
            ],
            child: AddShippingAddressPage(
                onShippingAddressAdded: onShippingAddressAdded)));
  }
}

class AddShippingAddressPage extends StatelessWidget with ValidatorMixin {
  final void Function(ShipTo) onShippingAddressAdded;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController addressOneController = TextEditingController();
  final TextEditingController addressTwoController = TextEditingController();
  final TextEditingController addressThreeController = TextEditingController();
  final TextEditingController addressFourController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();

  AddShippingAddressPage({super.key, required this.onShippingAddressAdded});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddShippingAddressCubit, AddShippingAddressState>(
      buildWhen: (previous, current) {
        return current is AddShippingAddressInitialState ||
            current is AddShippingAddressLoadedState;
      },
      builder: (context, state) {
        switch (state) {
          case AddShippingAddressInitialState():
            return const Center(child: CircularProgressIndicator());
          case AddShippingAddressLoadedState():
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _buildItems(context, state.siteMessages),
                        ),
                      ),
                    ),
                    _buildContinueButtonWidget(context)
                  ],
                ),
              ),
            );
          default:
            return const Center();
        }
      },
    );
  }

  Widget _createInputField(
      String label, String hintText, TextEditingController controller,
      {FormFieldValidator<String>? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Input(
        label: label,
        hintText: hintText,
        controller: controller,
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onEditingComplete: () {
          FocusManager.instance.primaryFocus?.nextFocus();
        },
        validator: validator,
      ),
    );
  }

  List<Widget> _buildItems(
      BuildContext context, Map<String, String> siteMessages) {
    var list = <Widget>[];
    list.add(_createInputField(
        LocalizationConstants.firstName.localized(),
        LocalizationConstants.firstName.localized(),
        firstNameController, validator: (value) {
      if (value == null || value.isEmpty) {
        return siteMessages[SiteMessageConstants.nameAddressInfoNameRequired];
      }
      return null;
    }));
    list.add(_createInputField(
        LocalizationConstants.lastName.localized(),
        LocalizationConstants.lastName.localized(),
        lastNameController, validator: (value) {
      if (value == null || value.isEmpty) {
        return siteMessages[SiteMessageConstants.nameAddressInfoNameRequired];
      }
      return null;
    }));
    list.add(_createInputField(LocalizationConstants.companyName.localized(),
        LocalizationConstants.companyName.localized(), companyNameController));

    list.add(_addCountryWidget(context));

    list.add(_createInputField(
        LocalizationConstants.addressOne.localized(),
        LocalizationConstants.addressOne.localized(),
        addressOneController, validator: (value) {
      if (value == null || value.isEmpty) {
        return siteMessages[
            SiteMessageConstants.nameAddressInfoAddressOneRequired];
      }
      return null;
    }));
    list.add(_createInputField(LocalizationConstants.addressTwo.localized(),
        LocalizationConstants.addressTwo.localized(), addressTwoController));
    list.add(_createInputField(
        LocalizationConstants.addressThree.localized(),
        LocalizationConstants.addressThree.localized(),
        addressThreeController));
    list.add(_createInputField(LocalizationConstants.addressFour.localized(),
        LocalizationConstants.addressFour.localized(), addressFourController));
    list.add(_createInputField(
        LocalizationConstants.postalCode.localized(),
        LocalizationConstants.postalCode.localized(),
        postalCodeController, validator: (value) {
      if (value == null || value.isEmpty) {
        return siteMessages[SiteMessageConstants.nameAddressInfoZipRequired];
      }
      return null;
    }));
    list.add(_createInputField(
        LocalizationConstants.city.localized(),
        LocalizationConstants.city.localized(),
        cityController, validator: (value) {
      if (value == null || value.isEmpty) {
        return siteMessages[SiteMessageConstants.nameAddressInfoCityRequired];
      }
      return null;
    }));

    list.add(_addStateWidget(context));

    list.add(_createInputField(LocalizationConstants.email.localized(),
        LocalizationConstants.email.localized(), emailController,
        validator: (value) => validateEmail(emailController.text.trim(),
            emptyWarning: siteMessages[
                SiteMessageConstants.nameAddressInfoEmailAddressRequired],
            invalidWarning:
                siteMessages[SiteMessageConstants.nameAddressEmailInvalid])));
    list.add(_createInputField(LocalizationConstants.phoneNumber.localized(),
        LocalizationConstants.phoneNumber.localized(), phonenumberController,
        validator: validatePhoneNumber));
    list.add(_buildSavedAddressWiget(context));
    return list;
  }

  Widget _buildSavedAddressWiget(BuildContext context) {
    return BlocBuilder<AddShippingAddressCubit, AddShippingAddressState>(
        builder: (_, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocalizationConstants.saveThisAddress.localized(),
              style: OptiTextStyles.body,
            ),
            Switch(
              value: context.watch<AddShippingAddressCubit>().isSavedAddress,
              onChanged: (value) {
                context
                    .read<AddShippingAddressCubit>()
                    .onUpdateSaveAddressToggle(value);
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildContinueButtonWidget(BuildContext context) {
    return ListInformationBottomSubmitWidget(actions: [
      PrimaryButton(
        text: LocalizationConstants.continueText.localized(),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // Collect all data
            final firstName = firstNameController.text;
            final lastName = lastNameController.text;
            final companyName = companyNameController.text;
            final addressOne = addressOneController.text;
            final addressTwo = addressTwoController.text;
            final addressThree = addressThreeController.text;
            final addressFour = addressFourController.text;
            final postalCode = postalCodeController.text;
            final city = cityController.text;
            final email = emailController.text;
            final phoneNumber = phonenumberController.text;

            ShipTo shipto = ShipTo();

            shipto.firstName = firstName;
            shipto.lastName = lastName;
            shipto.companyName = companyName;
            shipto.address1 = addressOne;
            shipto.address2 = addressTwo;
            shipto.address3 = addressThree;
            shipto.address4 = addressFour;
            shipto.postalCode = postalCode;
            shipto.city = city;
            shipto.email = email;
            shipto.phone = phoneNumber;
            shipto.state =
                context.read<AddShippingAddressCubit>().selectedState;
            shipto.country =
                context.read<AddShippingAddressCubit>().selectedCountry;

            shipto.isNew = true;
            shipto.oneTimeAddress =
                !context.read<AddShippingAddressCubit>().isSavedAddress;
            shipto.isVmiLocation = false;
            shipto.isDefault = false;

            var customerValidation = CustomerValidationDto();

            var validationCountry = FieldValidationDto(
              isDisabled: false,
              isRequired: true,
            );
            customerValidation.country = validationCountry;

            var validationState = FieldValidationDto(
              isDisabled: false,
              isRequired: false,
            );
            customerValidation.state = validationState;

            var validation = FieldValidationDto(
              isDisabled: false,
              isRequired: false,
              maxLength: 40,
            );

            customerValidation.firstName = validation;
            customerValidation.lastName = validation;
            customerValidation.companyName = validation;
            customerValidation.attention = validation;
            customerValidation.address2 = validation;
            customerValidation.address3 = validation;
            customerValidation.address4 = validation;

            customerValidation.postalCode = validation;
            customerValidation.email = validation;
            customerValidation.phone = validation;
            customerValidation.address1 = validation;
            customerValidation.city = validation;

            shipto.validation = customerValidation;

            onShippingAddressAdded(shipto);
            Navigator.pop(context);

            // Handle the data (e.g., send it to the backend or another cubit)
          }
        },
      ),
    ]);
  }

  void _onCountrySelect(BuildContext context, Object item) {
    context.read<AddShippingAddressCubit>().onSelectCountry(item as Country);
  }

  void _onStateSelect(BuildContext context, Object item) {
    context.read<AddShippingAddressCubit>().onSelectState(item as StateModel);
  }

  int _getIndexOfCountry(List<Country> countries, Country? country) {
    for (int i = 0; i < countries.length; i++) {
      if (countries[i].name == country?.name) {
        return i;
      }
    }
    return -1;
  }

  int _getIndexOfState(List<StateModel>? states, StateModel? state) {
    for (int i = 0; i < (states?.length ?? 0); i++) {
      if (states?[i].name == state?.name) {
        return i;
      }
    }
    return -1;
  }

  Widget _addCountryWidget(BuildContext context) {
    return BlocBuilder<AddShippingAddressCubit, AddShippingAddressState>(
        buildWhen: (previous, current) {
      if (current is AddShippingAddressLoadedState ||
          current is AddShippingAddressInitialState) {
        return true;
      }

      return false;
    }, builder: (_, state) {
      if (state is AddShippingAddressLoadedState) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                LocalizationConstants.selectCountry.localized(),
                textAlign: TextAlign.start,
                style: OptiTextStyles.body,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                      child: ListPickerWidget(
                          items: state.countries,
                          selectedIndex: _getIndexOfCountry(
                              state.countries,
                              context
                                  .read<AddShippingAddressCubit>()
                                  .selectedCountry),
                          descriptionText:
                              LocalizationConstants.country.localized(),
                          callback: _onCountrySelect)),
                ],
              ),
            ),
          ],
        );
      } else
        return Container();
    });
  }

  Widget _addStateWidget(BuildContext context) {
    return BlocBuilder<AddShippingAddressCubit, AddShippingAddressState>(
        buildWhen: (previous, current) {
      if (current is AddShippingAddressLoadedState ||
          current is AddShippingAddressInitialState) {
        return true;
      }

      return false;
    }, builder: (_, state) {
      if (state is AddShippingAddressLoadedState) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                LocalizationConstants.selectState.localized(),
                textAlign: TextAlign.start,
                style: OptiTextStyles.body,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                      child: ListPickerWidget(
                          items: state.states ?? [],
                          selectedIndex: _getIndexOfState(
                              state.states,
                              context
                                  .read<AddShippingAddressCubit>()
                                  .selectedState),
                          descriptionText:
                              LocalizationConstants.state.localized(),
                          callback: _onStateSelect)),
                ],
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
