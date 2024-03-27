import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/payment_details/token_ex_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

typedef onCompleteCheckoutPaymentSection = void Function(Cart cart);

class CheckoutPaymentDetails extends StatelessWidget {
  Cart cart;
  Function onCompleteCheckoutPaymentSection;
  CheckoutPaymentDetails(
      {super.key,
      required this.cart,
      required this.onCompleteCheckoutPaymentSection});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentDetailsBloc, PaymentDetailsState>(
      listener: (context, state) {
        if (state is PaymentDetailsCompletedState) {
          var updatedCart = context.read<PaymentDetailsBloc>().cart;
          onCompleteCheckoutPaymentSection(updatedCart);
        }
      },
      child: BlocBuilder<PaymentDetailsBloc, PaymentDetailsState>(
          builder: (context, state) {
        switch (state) {
          case PaymentDetailsInitial():
          case PaymentDetailsLoading():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case PaymentDetailsLoaded():
            var loadedState = state as PaymentDetailsLoaded;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocalizationConstants.paymentMethod,
                        textAlign: TextAlign.center,
                        style: OptiTextStyles.body,
                      ),
                      PaymentMethodPicker(
                          // paymentMethodValue: loadedState.paymentMethodValue,
                          cart: cart,
                          onPaymentMethodChanged: (value) {
                            context.read<PaymentDetailsBloc>().add(
                                UpdatePaymentMethodEvent(
                                    paymentMethodDto: value!));
                          }),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                if (loadedState.tokenExEntity != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
                    child: Container(
                      height: 60,
                      child: TokenExWebView(
                          tokenExEntity: loadedState.tokenExEntity!,
                          handleWebViewRequestFromTokenEX: (urlString) {
                            // Handle web view request
                            context
                                .read<TokenExBloc>()
                                .add(HandleTokenExEvent(urlString: urlString));
                          },
                          handleTokenExFinishedData:
                              (cardNumber, cardType, securityCode) {
                            print(cardNumber);

                            context.read<PaymentDetailsBloc>().add(
                                UpdateCreditCartInfoEvent(
                                    cardNumber: cardNumber,
                                    cardType: cardType,
                                    securityCode: securityCode));
                          }),
                    ),
                  ),
                if (loadedState.showPOField!)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Input(
                      label: LocalizationConstants.pONumber,
                      hintText: LocalizationConstants.pONumberOptional,
                      controller: loadedState.poTextEditingController,
                      onTapOutside: (p0) => context.closeKeyboard(),
                      onEditingComplete: () => context.nextFocus(),
                    ),
                  )
              ],
            );
          default:
            return const SizedBox();
        }
      }),
    );
  }
}

class PaymentMethodPicker extends StatelessWidget {
  final Cart cart;
  final ValueChanged<PaymentMethodDto?> onPaymentMethodChanged;

  PaymentMethodPicker({
    required this.cart,
    required this.onPaymentMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListPickerWidget(
        items: cart.paymentOptions!.paymentMethods!,
        callback: _onPaymentMethodSelect);
  }

  void _onPaymentMethodSelect(BuildContext context, Object item) {
    onPaymentMethodChanged(item as PaymentMethodDto);
  }
}
