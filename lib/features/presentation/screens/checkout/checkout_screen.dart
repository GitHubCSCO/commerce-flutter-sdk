import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/billing_shipping_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/review_order_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/expansion_panel/expansion_panel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/payment_details/checkout_payment_details.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/review_order/review_order_widget.dart';
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
                sl<CheckoutBloc>()..add(LoadCheckoutEvent(cart: cart))),
        BlocProvider<TokenExBloc>(create: (context) => sl<TokenExBloc>()),
        BlocProvider<ReviewOrderCubit>(create: (context) => sl<ReviewOrderCubit>())
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
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                LocalizationConstants.cancel,
                style: OptiTextStyles.subtitleLink,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                switch (state) {
                  case CheckoutInitial():
                  case CheckoutLoading():
                    return const Center(child: CircularProgressIndicator());
                  case CheckoutDataLoaded():
                    return SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        _buildSummary(state.cart, state.promotions),
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
                                        .equalsIgnoreCase(
                                            ShippingOption.pickUp.name)
                                    ? ShippingOption.pickUp
                                    : ShippingOption.ship),
                                carriers: state.cart.carriers,
                                cartSettings: state.cartSettings,
                                selectedCarrier: state.cart.carrier,
                                selectedService: state.cart.shipVia);

                            final reviewOrderEntity = ReviewOrderEntity(
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
                                      return const ListTile(
                                        title: Text(LocalizationConstants.billingShipping),
                                      );
                                    },
                                    body: BillingShippingWidget(
                                        billingShippingEntity: billingShippingEntity),
                                    isExpanded: list?[0].isExpanded ?? true,
                                    canTapOnHeader: true),
                                ExpansionPanel(
                                    headerBuilder:
                                        (BuildContext context, bool isExpanded) {
                                      return const ListTile(
                                        title: Text(LocalizationConstants.paymentDetails),
                                      );
                                    },
                                    body: _buildPaymentDetails(
                                        context.read<CheckoutBloc>().cart!, context),
                                    isExpanded: list?[1].isExpanded ?? false,
                                    canTapOnHeader: true),
                                ExpansionPanel(
                                    headerBuilder:
                                        (BuildContext context, bool isExpanded) {
                                      return const ListTile(
                                        title: Text(LocalizationConstants.reviewOrder),
                                      );
                                    },
                                    body: ReviewOrderWidget(reviewOrderEntity: reviewOrderEntity),
                                    isExpanded: list?[2].isExpanded ?? false,
                                    canTapOnHeader: true),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                      ]),
                    );
                  default:
                    return const Center(child: Text('Error'));
                }
              },
            ),
          ),
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Colors.white),
            child: PrimaryButton(
              onPressed: () {
                var index = context.read<ExpansionPanelCubit>().expansionIndex;
                switch(index) {
                  // case 0:
                  //   final carrier = context.read<CheckoutBloc>().selectedCarrier;
                  //   final service = context.read<CheckoutBloc>().selectedService;
                  //   if (carrier != null && service != null) {
                  //     context.read<ExpansionPanelCubit>().onContinueClick();
                  //   }
                  case 1:
                    context.closeKeyboard();
                    // context.read<TokenExBloc>().add(TokenExValidateEvent());
                    context.read<ExpansionPanelCubit>().onContinueClick();
                  case 2:
                    context.read<ExpansionPanelCubit>().onContinueClick();
                  default:
                    context.read<ExpansionPanelCubit>().onContinueClick();
                }
              },
              text: LocalizationConstants.continueText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails(Cart cart, BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PaymentDetailsBloc>(
          create: (context) => sl<PaymentDetailsBloc>()
            ..add(LoadPaymentDetailsEvent(cart: cart)),
        ),
      ],
      child: CheckoutPaymentDetails(
          cart: cart,
          onCompleteCheckoutPaymentSection: (Cart updatedCart) {
            context.read<ExpansionPanelCubit>().onContinueClick();
          }
          ),
    );
  }

  Widget _buildSummary(Cart cart, PromotionCollectionModel promotionCollectionModel) {
    String promotionInfo;
    String promotionValue;

    var promotions = promotionCollectionModel.promotions?.where((x) => x.amount != 0).toList();

    if (promotions == null || promotions.isEmpty) {
      promotionInfo = '';
      promotionValue = '';
    }

    var lastPromotion = promotions?.last;
    var info = '';

    if (promotions != null && promotions.length > 1) {
      info = LocalizationConstants.promoCodesMore.format([lastPromotion?.name, promotions.length - 1]);
    } else {
      info = LocalizationConstants.promoCodes.format([lastPromotion?.name]);
    }

    var amount = promotions?.fold(0, (previousValue, element) => previousValue + (element.amount?.toInt() ?? 0));

    var promotion = promotions?.first;
    var currencySymbol = '';

    if (promotion != null && promotion.amountDisplay != null && promotion.amountDisplay!.isNotEmpty) {
      currencySymbol = promotion.amountDisplay!.substring(0, 1);
    }

    promotionInfo = info;
    promotionValue = '- $currencySymbol${amount ?? 0.toStringAsFixed(2)}';

    List<Widget> list = [];
    list.add(_buildRow(promotionInfo, promotionValue, OptiTextStyles.bodyFade)!);
    list.add(_buildRow(LocalizationConstants.subtotal, cart.orderGrandTotalDisplay ?? '', OptiTextStyles.subtitle)!);

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(mainAxisSize: MainAxisSize.min, children: list),
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
