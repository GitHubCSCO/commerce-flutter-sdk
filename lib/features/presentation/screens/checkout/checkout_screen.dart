import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CheckoutScreen extends StatelessWidget {
  Cart cart;
  CheckoutScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CheckoutBloc>(
          create: (context) =>
              sl<CheckoutBloc>()..add(LoadCheckoutEvent(cart: cart))),
    ], child: const CheckoutPage());
  }
}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
      switch (state) {
        case CheckoutInitial():
        case CheckoutLoading():
          return const Center(child: CircularProgressIndicator());
        case CheckkoutDataLoaded():
          return Scaffold(
              appBar: AppBar(
                title: const Text(LocalizationConstants.checkout),
                backgroundColor: Colors.white,
              ),
              body: Text(
                state.cart.paymentOptions?.paymentMethods?.length?.toString() ??
                    "",
              ));
        default:
          return const Center(child: Text('Error'));
      }
    });
  }
}
