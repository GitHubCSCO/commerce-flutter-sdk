import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/credit_card_add_callback_helper.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/payment_details/token_ex_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/add_credit_card_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/add_promotion_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

typedef OnCompleteCheckoutPaymentSection = void Function();

class CheckoutPaymentDetails extends StatelessWidget {
  final Cart cart;
  final OnCompleteCheckoutPaymentSection onCompleteCheckoutPaymentSection;

  CheckoutPaymentDetails({
    Key? key,
    required this.cart,
    required this.onCompleteCheckoutPaymentSection,
  }) : super(key: key);

  PaymentMethodDto? getPaymenmentMedthodDtoFromCart(
      Cart cart, AccountPaymentProfile accountPaymentProfile) {
    for (var mehtod in cart.paymentOptions!.paymentMethods!) {
      if (mehtod.name?.toLowerCase() ==
          accountPaymentProfile.cardIdentifier?.toLowerCase()) {
        return mehtod;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentDetailsBloc, PaymentDetailsState>(
      listener: (_, state) {
        if (state is PaymentDetailsLoaded) {
          context.read<TokenExBloc>().resetTokenExData();

          if (context.read<PaymentDetailsBloc>().accountPaymentProfile !=
                  null &&
              state.isNewCreditCard == false) {
            context.read<PaymentDetailsBloc>().add(
                  UpdatePaymentMethodEvent(
                    paymentMethodDto: getPaymenmentMedthodDtoFromCart(
                        context.read<PaymentDetailsBloc>().cart!,
                        context
                            .read<PaymentDetailsBloc>()
                            .accountPaymentProfile!),
                    isCVVRequired: false,
                  ),
                );
          }
        }

        if (state is PaymentDetailsNewCardSelectedState) {}
      },
      child: BlocBuilder<PaymentDetailsBloc, PaymentDetailsState>(
        builder: (_, state) {
          switch (state) {
            case PaymentDetailsInitial():
            case PaymentDetailsLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PaymentDetailsLoaded():
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddPromotionWidget(
                    shouldShowPromotionList: false,
                    fromCartPage: false,
                  ),
                  _buildPaymentMethodPicker(state, context),
                  if (state.cardDetails != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child:
                          Text(state.cardDetails!, style: OptiTextStyles.body),
                    ),
                  if (state.tokenExEntity != null)
                    _buildTokenExWebView(state, context),
                  if (state.showPOField!) _buildPOField(state, context),
                  _buildAddPaymentMethodButton(context)
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  int getIndexForSelectedPaymentMethod(List<PaymentMethodDto>? paymentMethods,
      PaymentMethodDto paymentMethodDto) {
    for (var i = 0; i < (paymentMethods?.length ?? 0); i++) {
      if (paymentMethods?[i].name == paymentMethodDto.name) {
        return i;
      }
    }
    return 0;
  }

  Widget _buildPaymentMethodPicker(
      PaymentDetailsLoaded state, BuildContext context) {
    var paymentMethods =
        context.read<PaymentDetailsBloc>().getPaymentMethods(state.cart) ?? [];
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              LocalizationConstants.paymentMethod,
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
                          items: paymentMethods,
                          selectedIndex: getIndexForSelectedPaymentMethod(
                              paymentMethods,
                              context
                                      .read<PaymentDetailsBloc>()
                                      .selectedPaymentMethod ??
                                  PaymentMethodDto()),
                          callback: _onPaymentMethodSelect)),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildTokenExWebView(
      PaymentDetailsLoaded state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
      child: Container(
        height: 60,
        child: TokenExWebView(
          tokenExEntity: state.tokenExEntity!,
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
            context.read<PaymentDetailsBloc>().add(
                  UpdateCreditCartInfoEvent(
                    cardNumber: cardNumber,
                    cardType: cardType,
                    securityCode: securityCode,
                  ),
                );

            onCompleteCheckoutPaymentSection();
          },
        ),
      ),
    );
  }

  Widget _buildPOField(PaymentDetailsLoaded state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Input(
        label: LocalizationConstants.pONumber,
        hintText: cart.requiresPoNumber!
            ? LocalizationConstants.pONumberRequired
            : LocalizationConstants.pONumberOptional,
        controller: state.poTextEditingController,
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onEditingComplete: () {
          FocusManager.instance.primaryFocus?.nextFocus();
        },
      ),
    );
  }

  void _onPaymentMethodSelect(BuildContext context, Object item) {
    context.read<CheckoutBloc>().add(
          SelectPaymentMethodEvent(item as PaymentMethodDto),
        );
    context.read<PaymentDetailsBloc>().add(
          UpdatePaymentMethodEvent(
            paymentMethodDto: item,
            isCVVRequired: true,
          ),
        );
  }

  Widget _buildAddPaymentMethodButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        AppRoute.addCreditCard.navigateBackStack(context,
            extra: CreditCardAddCallbackHelper(
                addCreditCardEntity:
                    AddCreditCardEntity(isAddNewCreditCard: true),
                onAddedCeditCard: (paymentProfile) {
                  context.read<PaymentDetailsBloc>().add(
                        UpdateNewAccountPaymentProfileEvent(
                          accountPaymentProfile: paymentProfile,
                        ),
                      );
                  context.read<CheckoutBloc>().add(
                        SelectPaymentMethodEvent(PaymentMethodDto(
                            name: paymentProfile.cardIdentifier,
                            cardType: paymentProfile.cardType,
                            isCreditCard: true,
                            description:
                                "${paymentProfile.cardType} ${paymentProfile.maskedCardNumber}",
                            isPaymentProfile: true)),
                      );
                  context
                      .read<PaymentDetailsBloc>()
                      .add(LoadPaymentDetailsEvent(
                        cart: context.read<PaymentDetailsBloc>().cart!,
                      ));
                  onCompleteCheckoutPaymentSection();
                }));
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white, // Button color
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        textStyle: OptiTextStyles.linkMedium,
      ),
      child: const Text('+ New Payment Method'),
    );
  }
}
