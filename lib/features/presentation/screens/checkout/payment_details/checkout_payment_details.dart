import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CheckoutPaymentDetails extends StatelessWidget {
  Cart cart;

  CheckoutPaymentDetails({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentDetailsBloc>(
        create: (context) => sl<PaymentDetailsBloc>(),
        child: BlocBuilder<PaymentDetailsBloc, PaymentDetailsState>(
            builder: (context, state) {
          switch (state) {
            case PaymentDetailsInitial():
              return Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    width: 382,
                    height: 20,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Payment Method',
                          style: OptiTextStyles.subtitle,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          cart.paymentOptions?.paymentMethods?.length
                                  ?.toString() ??
                              "",
                          style: OptiTextStyles.body,
                        ),
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
              );
            default:
              return const SizedBox();
          }
        }));
  }
}
