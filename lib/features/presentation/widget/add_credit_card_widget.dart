import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
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
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/payment_details/token_ex_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddCreditCardEntity {
  final AccountPaymentProfile? accountPaymentProfile;
  final bool isAddNewCreditCard;
  AddCreditCardEntity({
    required this.isAddNewCreditCard,
    this.accountPaymentProfile,
  });
}

class AddCreditCardScreen extends StatelessWidget {
  final AddCreditCardEntity addCreditCardEntity;
  final void Function(AccountPaymentProfile) onCreditCardAdded;
  final void Function()? onCreditCardDeleted;
  const AddCreditCardScreen(
      {super.key,
      this.onCreditCardDeleted,
      required this.onCreditCardAdded,
      required this.addCreditCardEntity});

  String getTitle() {
    if (addCreditCardEntity.isAddNewCreditCard) {
      return LocalizationConstants.addCreditCard.localized();
    } else {
      return LocalizationConstants.editCreditCard.localized();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: OptiAppColors.backgroundWhite,
          title: Text(getTitle()),
          centerTitle: false,
        ),
        body: MultiBlocProvider(
            providers: [
              BlocProvider<AddCreditCardBloc>(
                  create: (context) => sl<AddCreditCardBloc>()
                    ..add(SetUpDataSourceEvent(
                        addCreditCardEntity: addCreditCardEntity))),
              BlocProvider<BillingAddressCubit>(
                  create: (context) => sl<BillingAddressCubit>()
                    ..setUpDataBillingAddress(addCreditCardEntity)),
              BlocProvider<CardExpirationCubit>(
                  create: (context) => sl<CardExpirationCubit>()),
            ],
            child: AddCreditCardPage(
              onCreditCardAdded: onCreditCardAdded,
              onCreditCardDeleted: onCreditCardDeleted,
              addCreditCardEntity: addCreditCardEntity,
            )));
  }
}

class AddCreditCardPage extends StatelessWidget {
  final ValueNotifier<bool> validateNotifier = ValueNotifier(false);

  final AddCreditCardEntity addCreditCardEntity;

  final void Function(AccountPaymentProfile) onCreditCardAdded;
  final void Function()? onCreditCardDeleted;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddCreditCardPage({
    super.key,
    this.onCreditCardDeleted,
    required this.onCreditCardAdded,
    required this.addCreditCardEntity,
  });

  void _setUpEditCreditCardValues(BuildContext context) {
    nameController.text =
        addCreditCardEntity.accountPaymentProfile?.cardHolderName ?? "";
    addressController.text =
        addCreditCardEntity.accountPaymentProfile?.address1 ?? "";
    cityController.text = addCreditCardEntity.accountPaymentProfile?.city ?? "";
    postalCodeController.text =
        addCreditCardEntity.accountPaymentProfile?.postalCode ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: MultiBlocListener(
          listeners: [
            BlocListener<AddCreditCardBloc, AddCreditCardState>(
                listener: (_, state) {
              if (state is CreditCardDeletedSuccessState) {
                CustomSnackBar.showCreditCardDeletedsuccess(context);
                onCreditCardDeleted!();
                Navigator.pop(context);
              }
              if (state is CreditCardDeletedFailureState) {
                CustomSnackBar.showCreditCardDeletedFailed(context);
              }
              if (state is SavedPaymentAddedSuccessState) {
                onCreditCardAdded(state.accountPaymentProfile);
                Navigator.pop(context);
              }
              if (state is SavedPaymentAddedFailureState) {
                CustomSnackBar.showCreditCardSavedFailure(context);
              }
            }),
          ],
          child: BlocBuilder<AddCreditCardBloc, AddCreditCardState>(
            buildWhen: (previous, current) {
              if (current is AddCreditCardLoadedState ||
                  current is AddCreditCardLoadingState) {
                return true;
              }
              return false;
            },
            builder: (_, state) {
              if (state is AddCreditCardInitialState) {
                return Container();
              } else if (state is AddCreditCardLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AddCreditCardLoadedState) {
                if (!addCreditCardEntity.isAddNewCreditCard) {
                  _setUpEditCreditCardValues(context);
                  context.read<CardExpirationCubit>().onLoadCardExpirarionData(
                      addCreditCardEntity,
                      state.expirationYears,
                      state.expirationMonths);
                }

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
                      Visibility(
                          visible: addCreditCardEntity.isAddNewCreditCard,
                          child: _buildContinueButtonWidget(context)),
                      Visibility(
                          visible: !addCreditCardEntity.isAddNewCreditCard,
                          child: _buildDeleteButtonWidget(context))
                    ],
                  ),
                );
              } else
                // ignore: curly_braces_in_flow_control_structures
                return Container();
            },
          )),
    );
  }

  List<Widget> _buildItems(
      AddCreditCardLoadedState state, BuildContext context) {
    List<Widget> list = [];
    list.add(_buildNameField(context));

    if (addCreditCardEntity.isAddNewCreditCard) {
      list.add(
          _buildTokenExWebViewForAddCreditCard(state.tokenExEntity!, context));
    } else {
      list.add(const SizedBox(height: 20));
      list.add(_buildMaskedCardNumberWidget(context));
      list.add(const SizedBox(height: 20));
    }

    list.add(_buildExpirationWidget(
      expirationMonths: state.expirationMonths,
      expirationYears: state.expirationYears,
    ));

    list.add(_buildBillingAddressWidget(
        selectedCountryIndex: -1, selectedStateIndex: -1));
    list.add(_buildToggleSwitchForUseAsDefaultCard(context));

    return list;
  }

  Widget _buildMaskedCardNumberWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          addCreditCardEntity.accountPaymentProfile?.maskedCardNumber ?? "",
          style: const TextStyle(
            color: OptiAppColors.textDisabledColor,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleSwitchForUseAsDefaultCard(BuildContext context) {
    return BlocBuilder<AddCreditCardBloc, AddCreditCardState>(
        buildWhen: (previous, current) {
      if (previous is AddCreditCardLoadingState &&
          current is AddCreditCardLoadedState) {
        return true;
      }
      if (current is UseAsDefaultCardUpdatedState) {
        return true;
      }
      return false;
    }, builder: (_, state) {
      if (state is UseAsDefaultCardUpdatedState ||
          state is AddCreditCardLoadedState) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Switch(
                value: context.read<AddCreditCardBloc>().useAsDefaultCard,
                onChanged: (bool value) {
                  context
                      .read<AddCreditCardBloc>()
                      .add(UpdateUseAsDefaultCardEvent());
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                LocalizationConstants.useAsDefaultCard.localized(),
                style: OptiTextStyles.body,
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }

  Widget _buildToggleSwitchForBillingAddress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Switch(
            value:
                context.read<BillingAddressCubit>().billingAddressAddNewToggle,
            onChanged: (bool value) {
              context
                  .read<BillingAddressCubit>()
                  .updateaddNewBillingAddressToggleState();
            },
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            LocalizationConstants.useBillingAddress.localized(),
            style: OptiTextStyles.body,
          ),
        ],
      ),
    );
  }

  void getInputData(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
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
      validatePaymentToken(true);

      if (context.read<BillingAddressCubit>().billingAddressAddNewToggle) {
        var billTo = context.read<BillingAddressCubit>().billTo;
        address = billTo?.fullAddress ?? "";
        city = billTo?.city ?? "";
        postalCode = billTo?.postalCode ?? "";
        selectCountry = billTo?.country;
        selectState = billTo?.state;
      }

      if (addCreditCardEntity.isAddNewCreditCard) {
        AccountPaymentProfile? paymentProfile = AccountPaymentProfile(
          cardHolderName: name,
          address1: address,
          city: city,
          postalCode: postalCode,
          expirationDate: expirationDate,
          country: selectCountry?.abbreviation,
          state: selectState?.abbreviation,
          securityCode:
              context.read<AddCreditCardBloc>().cardInfo?.securityCode,
          cardIdentifier:
              context.read<AddCreditCardBloc>().cardInfo?.cardIdentifier,
          cardType: context.read<AddCreditCardBloc>().cardInfo?.cardType,
          isDefault: context.read<AddCreditCardBloc>().useAsDefaultCard,
        );

        context.read<AddCreditCardBloc>().add(
            SavePaymentProfileEvent(accountPaymentProfile: paymentProfile));
      } else {
        AccountPaymentProfile? paymentProfile = AccountPaymentProfile(
            cardHolderName: name,
            address1: address,
            city: city,
            postalCode: postalCode,
            expirationDate: expirationDate,
            country: selectCountry?.abbreviation,
            state: selectState?.abbreviation,
            securityCode:
                addCreditCardEntity.accountPaymentProfile?.securityCode,
            cardIdentifier:
                addCreditCardEntity.accountPaymentProfile?.cardIdentifier,
            cardType: addCreditCardEntity.accountPaymentProfile?.cardType,
            isDefault: context.read<AddCreditCardBloc>().useAsDefaultCard,
            id: addCreditCardEntity.accountPaymentProfile?.id);

        context.read<AddCreditCardBloc>().add(
            SavePaymentProfileEvent(accountPaymentProfile: paymentProfile));
      }
    } else {
      context.read<CardExpirationCubit>().validateExpirationDate();
      context.read<BillingAddressCubit>().validateBillingAddress();
    }
  }

  Widget _buildTokenExWebViewForAddCreditCard(
      TokenExEntity tokenExEntity, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
      child: SizedBox(
        height: 120,
        child: TokenExWidget(
          tokenExEntity: tokenExEntity,
          handleWebViewRequestFromTokenEX: (urlString, mContext) {
            mContext
                .read<TokenExBloc>()
                .add(HandleTokenExEvent(urlString: urlString));
          },
          handleTokenExFinishedData:
              (cardNumber, cardType, securityCode, isInvalidCVV) {
            if (isInvalidCVV) {
              CustomSnackBar.showInvalidCVV(context);
              return;
            }
            context.read<AddCreditCardBloc>().updateCreditCardInfo(
                CreditCardInfoEntity(
                    cardIdentifier: cardNumber,
                    cardType: cardType,
                    securityCode: securityCode));
          },
          tokenExValidateNotifier: validateNotifier,
        ),
      ),
    );
  }

  Widget _buildNameField(BuildContext context) {
    return _createInputField(
        LocalizationConstants.name.localized(),
        LocalizationConstants.name.localized(),
        nameController,
        true, validator: (value) {
      if (nameController.text.isEmpty) {
        return context.read<AddCreditCardBloc>().messageNameRequired;
      }
      return null;
    });
  }

  Widget _createInputField(String label, hintText,
      TextEditingController controller, bool? isRequired,
      {FormFieldValidator<String>? validator}) {
    return Input(
      label: label,
      hintText: hintText,
      controller: controller,
      validator: validator,
      isRequired: isRequired,
      onChanged: (p0) {
        _formKey.currentState?.validate();
      },
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
        text: LocalizationConstants.save.localized(),
        onPressed: () {
          getInputData(context);
        },
      ),
    ]);
  }

  Widget _buildDeleteButtonWidget(BuildContext context) {
    return ListInformationBottomSubmitWidget(actions: [
      TertiaryButton(
        text: LocalizationConstants.delete.localized(),
        onPressed: () {
          if (addCreditCardEntity.accountPaymentProfile != null) {
            showDialog(
              context: context,
              builder: (BuildContext alertContext) {
                return AlertDialog(
                  title: Text(LocalizationConstants.delete.localized()),
                  content: Text(LocalizationConstants.deleteCard.localized()),
                  actions: <Widget>[
                    TextButton(
                      child: Text(LocalizationConstants.cancel.localized()),
                      onPressed: () {
                        Navigator.of(alertContext).pop(); // Dismiss the dialog
                      },
                    ),
                    TextButton(
                      child: Text(LocalizationConstants.delete.localized()),
                      onPressed: () {
                        context.read<AddCreditCardBloc>().add(
                            DeletCreditCardEvent(
                                accountPaymentProfile: addCreditCardEntity
                                    .accountPaymentProfile!));
                        Navigator.of(alertContext).pop(); // Dismiss the dialog
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      PrimaryButton(
        text: LocalizationConstants.save.localized(),
        onPressed: () {
          getInputData(context);
        },
      ),
    ]);
  }

  Widget _buildBillingAddressWidget(
      {required int selectedCountryIndex, required int selectedStateIndex}) {
    void onCountrySelect(BuildContext context, Object item) {
      context.read<BillingAddressCubit>().onSelectCountry(item as Country);
    }

    void onStateSelect(BuildContext context, Object item) {
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
      if (state == null) {
        return -1;
      }
      for (int i = 0; i < (states?.length ?? 0); i++) {
        if (states?[i].name == state.name) {
          return i;
        }
      }
      return -1;
    }

    return BlocBuilder<BillingAddressCubit, BillingAddressState>(
        buildWhen: (previous, current) {
      if (current is BilingAddressLoadedState ||
          current is BillingAddressLoadingState) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      if (state is BillingAddressLoadingState) {
        return const CircularProgressIndicator();
      } else if (state is BilingAddressLoadedState) {
        if (state.showNewBillingAddressFields) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildToggleSwitchForBillingAddress(context),
              BillingAddressWidget(
                companyName: state.billTo?.companyName,
                fullAddress: state.billTo?.fullAddress,
                countryName: state.billTo?.country?.name,
                email: state.billTo?.email,
                phone: state.billTo?.phone,
                buildSeperator: false,
              )
            ],
          );
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildToggleSwitchForBillingAddress(context),
              Text(
                LocalizationConstants.billingAddress.localized(),
                textAlign: TextAlign.center,
                style: OptiTextStyles.subtitle,
              ),
              const SizedBox(height: 20),
              _createInputField(
                  LocalizationConstants.address.localized(),
                  LocalizationConstants.address.localized(),
                  addressController,
                  true,
                  validator: addCreditCardEntity.isAddNewCreditCard
                      ? (value) {
                          if (addressController.text.isEmpty) {
                            return SiteMessageConstants
                                .defaultValueAddressRequired;
                          }
                          return null;
                        }
                      : null),
              Row(
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
                                selectedIndex: getIndexOfCountry(
                                    state.countries,
                                    context
                                        .read<BillingAddressCubit>()
                                        .selectedCountry),
                                descriptionText:
                                    LocalizationConstants.country.localized(),
                                callback: onCountrySelect)),
                      ],
                    ),
                  ),
                ],
              ),
              BlocBuilder<BillingAddressCubit, BillingAddressState>(
                  builder: (context, state) {
                return Visibility(
                  visible: state is BillingAddressValidationState &&
                      state.isCountryEmpty,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        context
                            .read<AddCreditCardBloc>()
                            .messageCountryRequired,
                        style: const TextStyle(
                          color: Colors.red, // Change the color if needed
                        ),
                      ),
                    ],
                  ),
                );
              }),
              _createInputField(LocalizationConstants.city.localized(),
                  LocalizationConstants.city.localized(), cityController, true,
                  validator: addCreditCardEntity.isAddNewCreditCard
                      ? (value) {
                          if (cityController.text.isEmpty) {
                            return context
                                .read<AddCreditCardBloc>()
                                .messageCityRequired;
                          }
                          return null;
                        }
                      : null),
              Row(
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
                                selectedIndex: getIndexOfState(
                                    state.states,
                                    context
                                        .read<BillingAddressCubit>()
                                        .selectedState),
                                descriptionText:
                                    LocalizationConstants.state.localized(),
                                callback: onStateSelect)),
                      ],
                    ),
                  ),
                ],
              ),
              BlocBuilder<BillingAddressCubit, BillingAddressState>(
                  builder: (context, state) {
                return Visibility(
                  visible: state is BillingAddressValidationState &&
                      state.isStateEmpty,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        context.read<AddCreditCardBloc>().messageStateRequired,
                        style: const TextStyle(
                          color: Colors.red, // Change the color if needed
                        ),
                      ),
                    ],
                  ),
                );
              }),
              _createInputField(
                  LocalizationConstants.postalCode.localized(),
                  LocalizationConstants.postalCode.localized(),
                  postalCodeController,
                  true,
                  validator: addCreditCardEntity.isAddNewCreditCard
                      ? (value) {
                          if (postalCodeController.text.isEmpty) {
                            return context
                                .read<AddCreditCardBloc>()
                                .messageZipRequired;
                          }
                          return null;
                        }
                      : null),
            ],
          );
        }
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
      for (int i = 0; i < (expirationMonths?.length ?? 0); i++) {
        if (expirationMonths?[i].key == selectedExpirationMonth?.key) {
          return i;
        }
      }
      return -1;
    }

    int getIndexForSelectedExpirationYears(
        List<KeyValuePair<int, int>>? expirationYears,
        KeyValuePair<int, int>? selectedExpirationYear) {
      for (int i = 0; i < (expirationYears?.length ?? 0); i++) {
        if (expirationYears?[i].key == selectedExpirationYear?.key) {
          return i;
        }
      }
      return -1;
    }

    return BlocBuilder<CardExpirationCubit, CardExpirationState>(
        builder: (context, state) {
      if (state is CardExpirationLoadedState ||
          state is CardExpirationInitialState ||
          state is CardExpirationValidationState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalizationConstants.cardExpirationDate.localized(),
              textAlign: TextAlign.center,
              style: OptiTextStyles.subtitle,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text(
                        LocalizationConstants.month.localized(),
                        textAlign: TextAlign.start,
                        style: OptiTextStyles.body,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '*',
                        style: TextStyle(
                          color: Colors.red, // Change the color if needed
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                          child: ListPickerWidget(
                              items: (expirationMonths != null)
                                  ? expirationMonths as List<Object>
                                  : [],
                              descriptionText:
                                  LocalizationConstants.selectMonth.localized(),
                              selectedIndex:
                                  getIndexForSelectedExpirationMonths(
                                      expirationMonths,
                                      context
                                          .read<CardExpirationCubit>()
                                          .selectedExpirationMonth),
                              callback: _onMonthSelect)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                    visible: state is CardExpirationValidationState &&
                        state.isMonthInvalid,
                    child: Text(
                      SiteMessageConstants
                          .defaultValueCreditCardInfoExpirationMonthRequired,
                      style: const TextStyle(
                        color: Colors.red, // Change the color if needed
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text(
                        LocalizationConstants.year.localized(),
                        textAlign: TextAlign.start,
                        style: OptiTextStyles.body,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '*',
                        style: TextStyle(
                          color: Colors.red, // Change the color if needed
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                          child: ListPickerWidget(
                              items: (expirationYears != null)
                                  ? expirationYears as List<Object>
                                  : [],
                              descriptionText:
                                  LocalizationConstants.selectYear.localized(),
                              selectedIndex: getIndexForSelectedExpirationYears(
                                  expirationYears,
                                  context
                                      .read<CardExpirationCubit>()
                                      .selectedExpirationYear),
                              callback: _onYearSelect)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                    visible: state is CardExpirationValidationState &&
                        state.isYearInvalid,
                    child: Text(
                      SiteMessageConstants
                          .defaultValueCreditCardInfoExpirationYearRequired,
                      style: const TextStyle(
                        color: Colors.red, // Change the color if needed
                      ),
                    )),
              ],
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }

  void validatePaymentToken(bool value) {
    validateNotifier.value = value;
  }

  void _onYearSelect(BuildContext context, Object item) {
    context
        .read<CardExpirationCubit>()
        .onSelectExpirationYear(item as KeyValuePair<int, int>);
    context.read<CardExpirationCubit>().validateExpirationDate();
  }

  void _onMonthSelect(BuildContext context, Object item) {
    context
        .read<CardExpirationCubit>()
        .onSelectExpirationMonth(item as KeyValuePair<String, int>);
    context.read<CardExpirationCubit>().validateExpirationDate();
  }
}
