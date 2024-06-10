import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/tokenex_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/credit_card_info_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/add_credit_card/add_credit_card_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/add_credit_card/add_credit_card_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/add_credit_card/add_credit_card_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/billing_address/billing_address_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/billing_address/billing_address_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/card_expiration_cubit.dart/card_expiration_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/card_expiration_cubit.dart/card_expiration_state.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/payment_details/token_ex_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddCreditCardScreen extends StatelessWidget {
  const AddCreditCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: OptiAppColors.backgroundWhite,
          title: const Text(LocalizationConstants.addCreditCard),
          centerTitle: false,
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<AddCreditCardBloc>(
              create: (context) =>
                  sl<AddCreditCardBloc>()..add(SetUpDataSourceEvent())),
          BlocProvider<BillingAddressCubit>(
              create: (context) =>
                  sl<BillingAddressCubit>()..setUpDataBillingAddress()),
          BlocProvider<TokenExBloc>(create: (context) => sl<TokenExBloc>()),
          BlocProvider<CardExpirationCubit>(
              create: (context) => sl<CardExpirationCubit>()),
        ], child: AddCreditCardPage()));

    // return MultiBlocProvider(providers: [
    //   BlocProvider<AddCreditCardCubit>(
    //       create: (context) => sl<AddCreditCardCubit>()..setUpDataSource()),
    //   BlocProvider<TokenExBloc>(create: (context) => sl<TokenExBloc>()),
    // ], child: AddCreditCardPage());
  }
}

class AddCreditCardPage extends StatelessWidget {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  AddCreditCardPage({super.key});
  @override
  Widget build(BuildContext context) {
    // return Text("dsfdsfsd");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: MultiBlocListener(
          listeners: [
            BlocListener<AddCreditCardBloc, AddCreditCardState>(
                listener: (context, state) {
              if (state is AddCreditCardLoadedState) {
                context.read<TokenExBloc>().resetTokenExData();
              }
            }),
          ],
          child: BlocBuilder<AddCreditCardBloc, AddCreditCardState>(
            builder: (_, state) {
              if (state is AddCreditCardInitialState) {
                return Container();
              } else if (state is AddCreditCardLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is AddCreditCardLoadedState) {
                // return Text("data");
                return Column(
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
                );
              } else
                return Container();
            },
          )),
    );
  }

  void getInputData(BuildContext context) {
    var name = nameController.text;
    var address = addressController.text;
    var city = cityController.text;
    var postalCode = postalCodeController.text;
    var expirationMonth =
        context.read<CardExpirationCubit>().selectedExpirationMonth;
    var expirationYear =
        context.read<CardExpirationCubit>().selectedExpirationYear;
    var selectCountry = context.read<BillingAddressCubit>().selectedCountry;
    var selectState = context.read<BillingAddressCubit>().selectedState;
    var expirationDate =
        "${expirationMonth?.value.toString().padLeft(2, '0')}/${expirationYear!.key % 100}";

    print('Name: $name');
    print('Address: $address');
    print('City: $city');
    print('Postal Code: $postalCode');
    print(expirationYear?.key);
    print(expirationMonth?.key);
    print('Selected Country: $selectCountry');
    print('Selected State: $selectState');

    context.read<TokenExBloc>().add(TokenExValidateEvent());

    AccountPaymentProfile? paymentProfile = AccountPaymentProfile(
        cardHolderName: name,
        address1: address,
        city: city,
        postalCode: postalCode,
        expirationDate: expirationDate,
        country: selectCountry?.abbreviation,
        state: selectState?.abbreviation,
        securityCode: context.read<TokenExBloc>().cardInfo?.securityCode,
        cardIdentifier: context.read<TokenExBloc>().cardInfo?.cardIdentifier,
        cardType: context.read<TokenExBloc>().cardInfo?.cardType,
        isDefault: false,
        
        );

    context
        .read<AddCreditCardBloc>()
        .add(SavePaymentProfileEvent(accountPaymentProfile: paymentProfile));
  }

  List<Widget> _buildItems(
      AddCreditCardLoadedState state, BuildContext context) {
    List<Widget> list = [];
    list.add(_buildNameField());
    list.add(
        _buildTokenExWebViewForAddCreditCard(state.tokenExEntity!, context));

    list.add(_buildExpirationWidget(
      expirationMonths: state.expirationMonths,
      expirationYears: state.expirationYears,
    ));

    list.add(_buildBillingAddressWidget(
        selectedCountryIndex: -1, selectedStateIndex: -1));

    return list;
  }

  Widget _buildTokenExWebViewForAddCreditCard(
      TokenExEntity tokenExEntity, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
      child: Container(
        height: 120,
        child: TokenExWebView(
          tokenExEntity: tokenExEntity,
          handleWebViewRequestFromTokenEX: (urlString) {
            context
                .read<TokenExBloc>()
                .add(HandleTokenExEvent(urlString: urlString));
          },
          handleTokenExFinishedData:
              (cardNumber, cardType, securityCode, isInvalidCVV) {
            if (isInvalidCVV) {
              CustomSnackBar.showInvalidCVV(context);
              return;
            }
            context.read<TokenExBloc>().add(UpdateCreditCardInfo(
                cardInfoEntity: CreditCardInfoEntity(
                    cardIdentifier: cardNumber,
                    cardType: cardType,
                    securityCode: securityCode)));
            // onCompleteCheckoutPaymentSection();
          },
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return _createInputField(
        LocalizationConstants.name, LocalizationConstants.name, nameController);
  }

  Widget _createInputField(
      String label, hintText, TextEditingController controller) {
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
    );
  }

  Widget _buildContinueButtonWidget(BuildContext context) {
    return ListInformationBottomSubmitWidget(actions: [
      PrimaryButton(
        text: LocalizationConstants.continueText,
        onPressed: () {
          getInputData(context);
        },
      ),
    ]);
  }

  Widget _buildBillingAddressWidget(
      {required int selectedCountryIndex, required int selectedStateIndex}) {
    void _onCountrySelect(BuildContext context, Object item) {
      context.read<BillingAddressCubit>().onSelectCountry(item as Country);
    }

    void _onStateSelect(BuildContext context, Object item) {
      context.read<BillingAddressCubit>().onSelectState(item as StateModel);
    }

    int getIndexOfCountry(List<Country> countries, Country? country) {
      for (int i = 0; i < countries.length; i++) {
        if (countries[i].name == country?.name) {
          return i;
        }
      }
      return -1;
    }

    int getIndexOfState(List<StateModel>? states, StateModel? state) {
      for (int i = 0; i < (states?.length ?? 0); i++) {
        if (states?[i].name == state?.name) {
          return i;
        }
      }
      return -1;
    }

    return BlocBuilder<BillingAddressCubit, BillingAddressState>(
        builder: (context, state) {
      if (state is BillingAddressLoadingState) {
        return const CircularProgressIndicator();
      } else if (state is BilingAddressLoadedState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalizationConstants.billingAddress,
              textAlign: TextAlign.center,
              style: OptiTextStyles.subtitle,
            ),
            const SizedBox(height: 20),
            _createInputField(LocalizationConstants.address,
                LocalizationConstants.address, addressController),
            Row(
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
                              selectedIndex: getIndexOfCountry(
                                  state.countries,
                                  context
                                      .read<BillingAddressCubit>()
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
            ),
            _createInputField(LocalizationConstants.city,
                LocalizationConstants.city, cityController),
            Row(
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
                              selectedIndex: getIndexOfState(
                                  state.states,
                                  context
                                      .read<BillingAddressCubit>()
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
            ),
            _createInputField(LocalizationConstants.postalCode,
                LocalizationConstants.postalCode, postalCodeController),
          ],
        );
      } else {
        return Container();
      }
    });
  }

  Widget _buildExpirationWidget(
      {required List<KeyValuePair<String, int>>? expirationMonths,
      required List<KeyValuePair<int, int>>? expirationYears}) {
    int getIndexForSelectedExpirationMonths(
        List<KeyValuePair<String, int>>? expirationMonths,
        KeyValuePair<String, int>? selectedExpirationMonth) {
      for (int i = 0; i < expirationMonths!.length; i++) {
        if (expirationMonths[i].key == selectedExpirationMonth?.key) {
          return i;
        }
      }
      return 0;
    }

    int getIndexForSelectedExpirationYears(
        List<KeyValuePair<int, int>>? expirationYears,
        KeyValuePair<int, int>? selectedExpirationYear) {
      for (int i = 0; i < expirationYears!.length; i++) {
        if (expirationYears[i].key == selectedExpirationYear?.key) {
          return i;
        }
      }
      return 0;
    }

    return BlocBuilder<CardExpirationCubit, CardExpirationState>(
        builder: (context, state) {
      if (state is CardExpirationLoadedState ||
          state is CardExpirationInitialState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalizationConstants.cardExpirationDate,
              textAlign: TextAlign.center,
              style: OptiTextStyles.subtitle,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    LocalizationConstants.month,
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
                              items: expirationMonths as List<Object>,
                              selectedIndex:
                                  getIndexForSelectedExpirationMonths(
                                      expirationMonths,
                                      context
                                          .read<CardExpirationCubit>()
                                          .selectedExpirationMonth),
                              callback: _onMonthSelect)),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    LocalizationConstants.year,
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
                              items: expirationYears as List<Object>,
                              selectedIndex: getIndexForSelectedExpirationYears(
                                  expirationYears,
                                  context
                                      .read<CardExpirationCubit>()
                                      .selectedExpirationYear),
                              callback: _onYearSelect)),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      } else
        return Container();
    });
  }

  void _onYearSelect(BuildContext context, Object item) {
    context
        .read<CardExpirationCubit>()
        .onSelectExpirationYear(item as KeyValuePair<int, int>);
  }

  void _onMonthSelect(BuildContext context, Object item) {
    context
        .read<CardExpirationCubit>()
        .onSelectExpirationMonth(item as KeyValuePair<String, int>);
  }
}
