import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
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
          title: const Text(LocalizationConstants.addCreditCard),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: MultiBlocListener(
          listeners: [
            BlocListener<AddShippingAddressCubit, AddShippingAddressState>(
                listener: (_, state) {}),
          ],
          child: BlocBuilder<AddShippingAddressCubit, AddShippingAddressState>(
            builder: (_, state) {
              if (state is AddShippingAddtessLoadingState) {
                return CircularProgressIndicator();
              } else if (state is AddShippingAddtessLoadedState) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _buildItems(state, context),
                          ),
                        ),
                      ),
                      _buildContinueButtonWidget(context)
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }

  Widget _createInputField(
      String label, String hintText, TextEditingController controller,
      {FormFieldValidator<String>? validator}) {
    return Input(
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
    );
  }

  List<Widget> _buildItems(
      AddShippingAddtessLoadedState state, BuildContext context) {
    List<Widget> list = [];
    list.add(_createInputField(
        LocalizationConstants.firstName,
        LocalizationConstants.firstName,
        firstNameController, validator: (value) {
      if (value == null || value.isEmpty) {
        return 'First Name cannot be empty';
      }
      return null;
    }));
    list.add(_createInputField(LocalizationConstants.lastName,
        LocalizationConstants.lastName, lastNameController, validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Last Name cannot be empty';
      }
      return null;
    }));
    list.add(_createInputField(LocalizationConstants.companyName,
        LocalizationConstants.companyName, companyNameController));

    list.add(_addCountryWidget(context, state));

    list.add(_createInputField(
        LocalizationConstants.addressOne,
        LocalizationConstants.addressOne,
        addressOneController, validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Address Line 1 cannot be empty';
      }
      return null;
    }));
    list.add(_createInputField(LocalizationConstants.addressTwo,
        LocalizationConstants.addressTwo, addressTwoController));
    list.add(_createInputField(LocalizationConstants.addressThree,
        LocalizationConstants.addressThree, addressThreeController));
    list.add(_createInputField(LocalizationConstants.addressFour,
        LocalizationConstants.addressFour, addressFourController));
    list.add(_createInputField(
        LocalizationConstants.postalCode,
        LocalizationConstants.postalCode,
        postalCodeController, validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Postal Code cannot be empty';
      }
      return null;
    }));
    list.add(_createInputField(
        LocalizationConstants.city, LocalizationConstants.city, cityController,
        validator: (value) {
      if (value == null || value.isEmpty) {
        return 'City cannot be empty';
      }
      return null;
    }));

    list.add(_addStateWidget(context, state));

    list.add(_createInputField(LocalizationConstants.email,
        LocalizationConstants.email, emailController,
        validator: validateEmail));
    list.add(_createInputField(LocalizationConstants.phoneNumber,
        LocalizationConstants.phoneNumber, phonenumberController,
        validator: validatePhoneNumber));
    return list;
  }

  Widget _buildContinueButtonWidget(BuildContext context) {
    return ListInformationBottomSubmitWidget(actions: [
      PrimaryButton(
        text: LocalizationConstants.continueText,
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

  Widget _addCountryWidget(
      BuildContext context, AddShippingAddtessLoadedState state) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            LocalizationConstants.selectCountry,
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
                      descriptionText: LocalizationConstants.country,
                      callback: _onCountrySelect)),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _addStateWidget(
      BuildContext context, AddShippingAddtessLoadedState state) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            LocalizationConstants.selectState,
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
                      descriptionText: LocalizationConstants.state,
                      callback: _onStateSelect)),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
