import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/billing_shipping_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/review_order_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/expansion_panel/expansion_panel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/base_checkout.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/checkout_success_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/payment_details/checkout_payment_details.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/review_order/review_order_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/product_list_with_basicInfo.dart';
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
        BlocProvider<ReviewOrderCubit>(
            create: (context) => sl<ReviewOrderCubit>()),
        BlocProvider<PaymentDetailsBloc>(
          create: (context) => sl<PaymentDetailsBloc>()
            ..add(LoadPaymentDetailsEvent(cart: cart)),
        ),
      ],
      child: CheckoutPage(cart: cart),
    );
  }
}

class CheckoutPage extends StatelessWidget with BaseCheckout {
  final Cart cart;

  CheckoutPage({super.key, required this.cart});

  bool get hasOnlyQuoteRequiredProducts {
    return (cart.cartLines != null && (cart.cartLines ?? []).isNotEmpty) &&
        (cart.cartLines ?? []).every((x) => x.quoteRequired ?? false);
  }

  bool get hasQuoteRequiredProducts {
    return cart.cartLines != null &&
        (cart.cartLines ?? []).any((x) => x.quoteRequired ?? false);
  }

  bool get isCartCheckoutDisabled {
    return (!(cart.canCheckOut ?? true) && !(cart.canRequisition ?? true)) ||
        isCartEmpty ||
        hasRestrictedCartLines;
  }

  bool get isCartEmpty {
    return cart.cartLines == null || (cart.cartLines ?? []).isEmpty;
  }

  bool get hasRestrictedCartLines {
    return cart.cartLines != null &&
        (cart.cartLines ?? []).any((x) => x.isRestricted ?? false);
  }

  bool get isCheckoutButtonEnabled {
    return !isCartCheckoutDisabled || !hasOnlyQuoteRequiredProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (_, state) {
          if (state is CheckoutPlaceOrder) {
            context.read<CartCountCubit>().onCartItemChange();
            AppRoute.checkoutSuccess.navigate(context,
                extra: CheckoutSuccessEntity(
                    orderNumber: state.orderNumber, isVmiCheckout: false));
          }
        },
        builder: (_, state) {
          return BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (_, state) {
              switch (state) {
                case CheckoutInitial():
                case CheckoutLoading():
                  return const Center(child: CircularProgressIndicator());
                case CheckoutDataLoaded():
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildSummary(state.cart, state.promotions),
                              BlocBuilder<ExpansionPanelCubit,
                                  ExpansionPanelState>(
                                builder: (context, panelState) {
                                  List<Item>? list;
                                  switch (panelState) {
                                    case ExpansionPanelChangeState():
                                      list = panelState.list;
                                  }

                                  final billingShippingEntity =
                                      BillingShippingEntity(
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
                                    selectedCarrier: state.selectedCarrier,
                                    selectedService: state.selectedService,
                                    requestDeliveryDate:
                                        state.requestDeliveryDate,
                                  );

                                  final reviewOrderEntity = ReviewOrderEntity(
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
                                      paymentMethod: state.cart.paymentMethod);

                                  return ExpansionPanelList(
                                    expansionCallback:
                                        (int index, bool isExpanded) {
                                      context
                                          .read<ExpansionPanelCubit>()
                                          .onPanelExpansionChange(index);
                                    },
                                    children: [
                                      ExpansionPanel(
                                          headerBuilder: (BuildContext context,
                                              bool isExpanded) {
                                            return const ListTile(
                                              title: Text(LocalizationConstants
                                                  .billingShipping),
                                            );
                                          },
                                          body: BillingShippingWidget(
                                              billingShippingEntity:
                                                  billingShippingEntity),
                                          isExpanded:
                                              list?[0].isExpanded ?? true,
                                          canTapOnHeader: true),
                                      ExpansionPanel(
                                          headerBuilder: (BuildContext context,
                                              bool isExpanded) {
                                            return const ListTile(
                                              title: Text(LocalizationConstants
                                                  .paymentDetails),
                                            );
                                          },
                                          body: CheckoutPaymentDetails(
                                              cart: context
                                                  .read<CheckoutBloc>()
                                                  .cart!,
                                              onCompleteCheckoutPaymentSection:
                                                  () {
                                                context.read<CheckoutBloc>().add(
                                                    SelectPaymentEvent(context
                                                        .read<
                                                            PaymentDetailsBloc>()
                                                        .cart!
                                                        .paymentOptions!));
                                                context
                                                    .read<ExpansionPanelCubit>()
                                                    .onContinueClick();
                                              }),
                                          isExpanded:
                                              list?[1].isExpanded ?? false,
                                          canTapOnHeader: true),
                                      ExpansionPanel(
                                          headerBuilder: (BuildContext context,
                                              bool isExpanded) {
                                            return const ListTile(
                                              title: Text(LocalizationConstants
                                                  .reviewOrder),
                                            );
                                          },
                                          body: ReviewOrderWidget(
                                              reviewOrderEntity:
                                                  reviewOrderEntity),
                                          isExpanded:
                                              list?[2].isExpanded ?? false,
                                          canTapOnHeader: true),
                                    ],
                                  );
                                },
                              ),
                              ProductListWithBasicInfo(
                                totalItemsTitle:
                                    LocalizationConstants.cartContentsItems,
                                list: CartLineListMapper()
                                        .toEntity(CartLineList(
                                            cartLines:
                                                state.cart.cartLines ?? []))
                                        .cartLines ??
                                    [],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: StreamBuilder<String>(
                          stream: context
                              .read<ExpansionPanelCubit>()
                              .buttonTextStream,
                          initialData: LocalizationConstants.continueText,
                          builder: (context, snapshot) {
                            String buttonText = snapshot.data!;
                            var index = context
                                .read<ExpansionPanelCubit>()
                                .expansionIndex;
                            return PrimaryButton(
                              onPressed: () {
                                switch (index) {
                                  case 0:
                                    final carrier = context
                                        .read<CheckoutBloc>()
                                        .selectedCarrier;
                                    final service = context
                                        .read<CheckoutBloc>()
                                        .selectedService;
                                    if (carrier != null && service != null) {
                                      context
                                          .read<ExpansionPanelCubit>()
                                          .onContinueClick();
                                    }
                                  case 1:
                                    var isPaymentCardType = context
                                            .read<PaymentDetailsBloc>()
                                            .selectedPaymentMethod
                                            ?.cardType !=
                                        null;
                                    var isCreditCardSectionCompleted = context
                                        .read<PaymentDetailsBloc>()
                                        .isCreditCardSectionCompleted;

                                    if (isPaymentCardType &&
                                        !isCreditCardSectionCompleted) {
                                      context
                                          .read<TokenExBloc>()
                                          .add(TokenExValidateEvent());
                                    } else {
                                      var poNumber = context
                                          .read<PaymentDetailsBloc>()
                                          .getPONumber();
                                      var cart = context
                                          .read<PaymentDetailsBloc>()
                                          .cart;

                                      if (cart!.requiresPoNumber! &&
                                          poNumber.isNullOrEmpty) {
                                        CustomSnackBar.showPoNumberRequired(
                                            context);
                                      } else {
                                        context
                                            .read<CheckoutBloc>()
                                            .add(UpdatePONumberEvent(poNumber));

                                        context
                                            .read<ExpansionPanelCubit>()
                                            .onContinueClick();
                                      }
                                    }

                                  case 2:
                                    context
                                        .read<CheckoutBloc>()
                                        .add(PlaceOrderEvent());
                                  default:
                                    context
                                        .read<ExpansionPanelCubit>()
                                        .onContinueClick();
                                }
                              },
                              text: buttonText,
                              isEnabled: (index == 2 && isCheckoutButtonEnabled == false)
                                  ? false
                                  : true,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                default:
                  return const Center();
              }
            },
          );
        },
      ),
    );
  }
}
