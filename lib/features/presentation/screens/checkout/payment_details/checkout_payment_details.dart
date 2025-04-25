import 'package:commerce_flutter_sdk/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/payment_details/payment_details_state.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/checkout/payment_details/token_ex_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/add_credit_card_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/add_promotion_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

typedef OnCompleteCheckoutPaymentSection = void Function();

class CheckoutPaymentDetails extends StatelessWidget {
  final Cart cart;
  final OnCompleteCheckoutPaymentSection onCompleteCheckoutPaymentSection;
  final ValueNotifier<bool> validateNotifier = ValueNotifier(false);
  final bool? isVmiCheckout;

  CheckoutPaymentDetails({
    super.key,
    required this.cart,
    required this.onCompleteCheckoutPaymentSection,
    this.isVmiCheckout,
  });

  PaymentMethodDto? getPaymenmentMedthodDtoFromCart(
      Cart cart, AccountPaymentProfile accountPaymentProfile) {
    for (var mehtod in cart.paymentOptions!.paymentMethods!) {
      if (mehtod.name?.toLowerCase() ==
          accountPaymentProfile.cardIdentifier?.toLowerCase()) {
        return mehtod;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentDetailsBloc, PaymentDetailsState>(
      listener: (_, state) {
        if (state is PaymentDetailsLoaded) {
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
        } else if (state is PaymentDetailsNewCardSelectedState) {
        } else if (state is PaymentDetailsValidateTokenState) {
          validatePaymentToken(true);
        }
      },
      child: BlocBuilder<PaymentDetailsBloc, PaymentDetailsState>(
        buildWhen: (previous, current) {
          if (current is! PaymentDetailsValidateTokenState) {
            return true;
          }
          return false;
        },
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
                  if (!(isVmiCheckout ?? false))
                    AddPromotionWidget(
                      shouldShowPromotionList: false,
                      fromCartPage: false,
                    ),
                  _buildPaymentMethodPicker(state, context),
                  if (state.cardDetails != null) ...{
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child:
                          Text(state.cardDetails!, style: OptiTextStyles.body),
                    )
                  },
                  _buildPaymentIFrame(state, context),
                  if (state.showPOField == true) ...{
                    _buildPOField(state, context)
                  },
                  if (state.cart?.showCreditCard != false &&
                      isVmiCheckout != true) ...{
                    _buildAddPaymentMethodButton(context)
                  },
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildPaymentIFrame(PaymentDetailsLoaded state, BuildContext context) {
    if (state.useSpreedlyDropIn == true) {
      return const Center();
    }
    return state.tokenExEntity != null
        ? _buildTokenExWebView(state, context)
        : const Center();
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
              LocalizationConstants.paymentMethod.localized(),
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
      key: UniqueKey(),
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
      child: SizedBox(
        height: 60,
        child: TokenExWidget(
          tokenExEntity: state.tokenExEntity!,
          handleWebViewRequestFromTokenEX: (urlString, mContext) {
            mContext
                ?.read<TokenExBloc>()
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
          tokenExValidateNotifier: validateNotifier,
        ),
      ),
    );
  }

  Widget _buildPOField(PaymentDetailsLoaded state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Input(
        label: LocalizationConstants.pONumber.localized(),
        hintText: cart.requiresPoNumber!
            ? LocalizationConstants.pONumberRequired.localized()
            : LocalizationConstants.pONumberOptional.localized(),
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

  void trackNewPaymentCheckoutEvent(BuildContext context) {
    context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
        AnalyticsConstants.eventNewPaymentCheckout,
        AnalyticsConstants.screenNameCheckout)));
  }

  Widget _buildAddPaymentMethodButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        trackNewPaymentCheckoutEvent(context);
        final result = await context.pushNamed(
          AppRoute.addCreditCard.name,
          extra: AddCreditCardEntity(isAddNewCreditCard: true),
        ) as AddCreditCardScreenResponse?;

        if (result == null) {
          return;
        }

        if (result.isAddNewCreditCard == true) {
          final paymentProfile = result.accountPaymentProfile;
          if (paymentProfile == null || !context.mounted) {
            return;
          }

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
          context.read<PaymentDetailsBloc>().add(LoadPaymentDetailsEvent(
                cart: context.read<PaymentDetailsBloc>().cart!,
              ));
          onCompleteCheckoutPaymentSection();
        }
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white, // Button color
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        textStyle: OptiTextStyles.linkMedium,
      ),
      child: Text(
        LocalizationConstants.newPaymentMethod.localized(),
      ),
    );
  }

  void validatePaymentToken(bool value) {
    validateNotifier.value = value;
  }
}
