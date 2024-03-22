import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/billing_shipping_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/expansion_panel/expansion_panel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/date_selection/date_selection_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CheckoutScreen extends StatelessWidget {
  final Cart cart;

  const CheckoutScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExpansionPanelCubit>(
          create: (context) => sl<ExpansionPanelCubit>(),
        ),
        BlocProvider<CheckoutBloc>(
            create: (context) =>
            sl<CheckoutBloc>()
              ..add(LoadCheckoutEvent(cart: cart))),
      ],
      child: const CheckoutPage(),
    );
  }

}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocalizationConstants.checkout),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              LocalizationConstants.cancel,
              style: OptiTextStyles.subtitleLink,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SizedBox(
          height: 50,
          child: PrimaryButton(
            onPressed: () {
              context.read<ExpansionPanelCubit>().onContinueClick();
            },
            text: LocalizationConstants.continueText,
          ),
        ),
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          switch (state) {
            case CheckoutInitial():
            case CheckoutLoading():
              return const Center(child: CircularProgressIndicator());
            case CheckoutDataLoaded():
              return SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  _buildSummary(),
                  BlocBuilder<ExpansionPanelCubit, ExpansionPanelState>(
                    builder: (context, panelState) {
                      List<Item>? list;
                      switch (panelState) {
                        case ExpansionPanelChangeState():
                          list = panelState.list;
                      }

                      final billingShippingEntity = BillingShippingEntity(
                          billTo: state.billToAddress,
                          shipTo: state.shipToAddress,
                          warehouse: state.wareHouse,
                          shippingMethod: (state.shippingMethod
                              .equalsIgnoreCase(ShippingOption.pickUp.name)
                              ? ShippingOption.pickUp
                              : ShippingOption.ship),
                          carriers: state.cart.carriers,
                          cartSettings: state.cartSettings);

                      return ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          context
                              .read<ExpansionPanelCubit>()
                              .onPanelExpansionChange(index);
                        },
                        children: [
                          ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text('Billing & Shipping'),
                                );
                              },
                              body: BlocProvider<DateSelectionCubit>(
                                create: (context) => sl<DateSelectionCubit>(),
                                child: BillingShippingWidget(
                                    billingShippingEntity: billingShippingEntity),
                              ),
                              isExpanded: list?[0].isExpanded ?? true,
                              canTapOnHeader: true),
                          ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text('Payment Details'),
                                );
                              },
                              body: ListTile(
                                title: Text('Item 2 child'),
                                subtitle: Text('Details goes here'),
                              ),
                              isExpanded: list?[1].isExpanded ?? false,
                              canTapOnHeader: true),
                          ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text('Review Order'),
                                );
                              },
                              body: ListTile(
                                title: Text('Item 3 child'),
                                subtitle: Text('Details goes here'),
                              ),
                              isExpanded: list?[2].isExpanded ?? false,
                              canTapOnHeader: true),
                        ],
                      );
                    },
                  )
                ]),
              );
            default:
              return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }

  Widget _buildSummary() {
    List<Widget> list = [];
    list.add(_buildRow('Promo', '-\$20', OptiTextStyles.bodyFade)!);
    list.add(_buildRow('Subtotal', '-\$283.50', OptiTextStyles.subtitle)!);

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: list
      ),
    );
  }

  Widget? _buildRow(String title, String body, TextStyle textStyle) {
    if (title.isEmpty || body.isEmpty) {
      return null;
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          Text(
            body,
            textAlign: TextAlign.center,
            style: textStyle,
          )
        ],
      );
    }
  }

}