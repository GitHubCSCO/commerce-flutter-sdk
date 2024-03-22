import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_event.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/payment_details/token_ex_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CheckoutPaymentDetails extends StatelessWidget {
  Cart cart;

  CheckoutPaymentDetails({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentDetailsBloc, PaymentDetailsState>(
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
                child: Container(
                  width: 382,
                  height: 20,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        LocalizationConstants.paymentMethod,
                        style: OptiTextStyles.subtitle,
                      ),
                      const SizedBox(width: 12),
                      PaymentMethodPicker(
                          paymentMethodValue: loadedState.paymentMethodValue,
                          cart: cart,
                          onPaymentMethodChanged: (value) {
                            context.read<PaymentDetailsBloc>().add(
                                UpdatePaymentMethodEvent(
                                    paymentMethodDto: value!));
                          }),
                      const SizedBox(width: 12),
                      Container(
                        width: 10,
                        height: 16,
                        child: SvgPicture.asset(
                          AssetConstants.checkoutArrowIcon,
                          fit: BoxFit.fitWidth,
                        ),
                      )
                    ],
                  ),
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
                          print(urlString);
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
            ],
          );
        default:
          return const SizedBox();
      }
    });
  }
}

class PaymentMethodPicker extends StatelessWidget {
  final Cart cart;
  final String paymentMethodValue;
  final ValueChanged<PaymentMethodDto?> onPaymentMethodChanged;

  PaymentMethodPicker(
      {required this.cart,
      required this.onPaymentMethodChanged,
      required this.paymentMethodValue});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200.0, // Adjust height according to your need
              child: CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  onPaymentMethodChanged(
                      cart.paymentOptions?.paymentMethods?[index]);
                },
                children: cart.paymentOptions?.paymentMethods?.map((method) {
                      return Text(
                        method.description ?? "",
                        style: TextStyle(fontSize: 20.0),
                      );
                    }).toList() ??
                    [],
              ),
            );
          },
        );
      },
      child: Text(
        paymentMethodValue,
        style: TextStyle(fontSize: 10.0),
      ),
    );
  }
}
