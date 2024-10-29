import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/payment_summary_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/shipping_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/domain/mapper/warehouse_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_shipping/cart_shipping_selection_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/promo_code_cubit/promo_code_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/saved_order_handler/saved_order_handler_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/wish_list_callback_helpers.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line_list.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_payment_summary_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/error_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void _reloadCartPage(BuildContext context) {
  context.read<CartCountCubit>().loadCurrentCartCount();
  context.read<CartPageBloc>().add(CartPageLoadEvent());
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CartPageBloc>(
          create: (context) =>
              sl<CartPageBloc>()..add(CartPageLoadEvent(trackScreen: true))),
      BlocProvider<PromoCodeCubit>(create: (context) => sl<PromoCodeCubit>()),
    ], child: const CartPage());
  }
}

class CartPage extends StatelessWidget {
  final websitePath = WebsitePaths.cartWebsitePath;

  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        title: Text(LocalizationConstants.cart.localized()),
        backgroundColor: Colors.white,
        actions: [
          BottomMenuWidget(
              websitePath: websitePath,
              screenName: AnalyticsConstants.screenNameCart)
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<RootBloc, RootState>(
            listener: (context, state) async {
              if (state is RootConfigReload ||
                  state is RootCartReload ||
                  state is RootPricingInventoryReload) {
                _reloadCartPage(context);
              }
            },
          ),
          BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                authCubitChangeTrigger(previous, current),
            listener: (context, state) {
              _reloadCartPage(context);
            },
          ),
          BlocListener<DomainCubit, DomainState>(
            listener: (context, state) {
              if (state is DomainLoaded) {
                _reloadCartPage(context);
              }
            },
          ),
          BlocListener<CartCountCubit, CountState>(
            listener: (context, state) {
              if (state is CartTabReloadState) {
                bool isCartItemChanged =
                    context.read<CartCountCubit>().cartItemChanged();
                if (isCartItemChanged) {
                  context.read<CartCountCubit>().setCartItemChange(false);
                  _reloadCartPage(context);
                }
              }
            },
          ),
          BlocListener<CartPageBloc, CartPageState>(
            listener: (_, state) {
              if (state is CartPageWarningDialogShowState) {
                showRequestQuoteWarningDialog(context,
                    message: state.warningMsg);
              } else if (state is CartProceedToCheckoutState) {
                var cartPageBloc = context.read<CartPageBloc>();
                navigateToCheckout(context, cartPageBloc);
              }
            },
          )
        ],
        child: RefreshIndicator(
          onRefresh: () async {
            _reloadCartPage(context);
          },
          child: BlocBuilder<CartPageBloc, CartPageState>(
            buildWhen: (previous, current) {
              if (current is CartPageWarningDialogShowState ||
                  current is CartProceedToCheckoutState ||
                  current is CartPageCheckoutButtonLoadingState) {
                return false;
              }
              return true;
            },
            builder: (_, state) {
              switch (state) {
                case CartPageInitialState():
                case CartPageLoadingState():
                  return const Center(child: CircularProgressIndicator());
                case CartPageLoadedState():
                  return Column(
                    children: [
                      if (state.cartWarningMsg.isNotEmpty)
                        BuildCartErrorWidget(
                            cartErrorMsg: state.cartWarningMsg),
                      Expanded(
                        child: ListView(
                          children: _buildCartWidgets(
                              state.cart,
                              state.cartSettings,
                              state.warehouse,
                              state.promotions,
                              state.isCustomerOrderApproval,
                              state.hasWillCall,
                              state.shippingMethod,
                              state.hidePricingEnable,
                              state.hideInventoryEnable,
                              context),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TertiaryBlackButton(
                                    text: LocalizationConstants.addAllToList
                                        .localized(),
                                    onPressed: () {
                                      final currentState =
                                          context.read<AuthCubit>().state;
                                      handleAuthStatusForAddToWishList(
                                          context, currentState.status);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TertiaryBlackButton(
                                    text: LocalizationConstants.saveOrder
                                        .localized(),
                                    onPressed: () {
                                      final currentState =
                                          context.read<AuthCubit>().state;
                                      handleAuthStatusForSaveOrder(
                                          context, currentState.status, state);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: context
                                  .watch<CartPageBloc>()
                                  .canSubmitForQuote,
                              child: PrimaryButton(
                                onPressed: () {
                                  final currentState =
                                      context.read<AuthCubit>().state;
                                  handleAuthStatusForSubmitQuote(
                                      context, currentState.status, state);
                                },
                                text: context
                                    .watch<CartPageBloc>()
                                    .submitForQuoteTitle,
                              ),
                            ),
                            _buildCheckoutButton(context),
                          ],
                        ),
                      ),
                    ],
                  );
                case CartPageNoDataState():
                  return CustomScrollView(slivers: <Widget>[
                    SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            child: const SvgAssetImage(
                              assetName: AssetConstants.iconCart,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Text(state.message),
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: TertiaryButton(
                              onPressed: () {
                                _trackContinueShoppingEvent(
                                    context,
                                    context
                                            .read<CartPageBloc>()
                                            .cart
                                            ?.orderNumber ??
                                        '');
                                AppRoute.shop.navigate(context);
                              },
                              text: LocalizationConstants.continueShopping
                                  .localized(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]);
                default:
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverFillRemaining(
                          child: OptiErrorWidget(
                        onRetry: () {
                          _reloadCartPage(context);
                        },
                        errorText:
                            LocalizationConstants.errorLoadingCart.localized(),
                      )),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  void _trackContinueShoppingEvent(BuildContext context, String orderNumber) {
    context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
            AnalyticsConstants.eventContinueShopping,
            AnalyticsConstants.screenNameCart)
        .withProperty(
            name: AnalyticsConstants.eventPropertyOrderNumber,
            strValue: orderNumber)));
  }

  void _trackAddToListEvent(BuildContext context, String orderNumber) {
    context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
                AnalyticsConstants.eventCartToListSelected,
                AnalyticsConstants.screenNameCart)
            .withProperty(
          name: AnalyticsConstants.eventPropertyOrderNumber,
          strValue: orderNumber,
        )));
  }

  void _trackAddToListSuccessfulEvent(
      BuildContext context, String orderNumber) {
    context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
                AnalyticsConstants.eventCartToListSuccessful,
                AnalyticsConstants.screenNameCart)
            .withProperty(
          name: AnalyticsConstants.eventPropertyOrderNumber,
          strValue: orderNumber,
        )));
  }

  void _trackBeginCheckoutEvent(BuildContext context, String grandTotal) {
    context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
            AnalyticsConstants.eventBeginCheckout,
            AnalyticsConstants.screenNameCheckout)
        .withProperty(
            name: AnalyticsConstants.eventPropertyValue,
            strValue: grandTotal)));
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return BlocBuilder<CartPageBloc, CartPageState>(
      builder: (_, state) {
        if (state is CartPageCheckoutButtonLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Visibility(
            visible: context.watch<CartPageBloc>().checkoutButtonVisible,
            child: PrimaryButton(
              isEnabled: context.watch<CartPageBloc>().isCheckoutButtonEnabled,
              onPressed: () {
                final currentState = context.read<AuthCubit>().state;
                handleAuthStatusForCheckout(
                    context, currentState.status, context.read<CartPageBloc>());
              },
              text: context.watch<CartPageBloc>().approvalButtonVisible
                  ? LocalizationConstants.checkoutForApproval.localized()
                  : LocalizationConstants.checkout.localized(),
            ),
          );
        }
      },
    );
  }

  void handleAuthStatusForCheckout(
      BuildContext context, AuthStatus status, CartPageBloc cartPageBloc) {
    if (status == AuthStatus.authenticated) {
      cartPageBloc.add(CartPageCheckoutEvent());
    } else {
      showSignInDialog(context,
          message: LocalizationConstants.signInBeforeCheckout.localized());
    }
  }

  void handleAuthStatusForSubmitQuote(
      BuildContext context, AuthStatus status, CartPageLoadedState state) {
    if (status == AuthStatus.authenticated) {
      AppRoute.requestQuote.navigateBackStack(context, extra: state.cart);
    } else {
      showSignInDialog(context,
          message: LocalizationConstants.signInBeforeSubmitQuote.localized());
    }
  }

  void handleAuthStatusForAddToWishList(
      BuildContext context, AuthStatus status) {
    if (status == AuthStatus.authenticated) {
      _trackAddToListEvent(
          context, context.read<CartPageBloc>().cart?.orderNumber ?? '');
      final addCartLines = context.read<CartPageBloc>().getAddCartLines();
      WishListCallbackHelper.addItemsToWishList(
        context,
        addToCartCollection: WishListAddToCartCollection(
          wishListLines: addCartLines,
        ),
        onAddedToCart: () {
          _trackAddToListSuccessfulEvent(
              context, context.read<CartPageBloc>().cart?.orderNumber ?? '');
        },
      );
    } else {
      showSignInDialog(context,
          message: LocalizationConstants.signInBeforeList.localized());
    }
  }

  void handleAuthStatusForSaveOrder(
      BuildContext context, AuthStatus status, CartPageLoadedState state) {
    if (status == AuthStatus.authenticated) {
      context
          .read<SavedOrderHandlerCubit>()
          .addCartToSavedOrders(cart: state.cart);
    } else {
      showSignInDialog(context,
          message: LocalizationConstants.signInBeforeSaveOrder.localized());
    }
  }

  void navigateToCheckout(BuildContext context, CartPageBloc cartPageBloc) {
    _trackBeginCheckoutEvent(context,
        context.read<CartPageBloc>().cart?.orderGrandTotalDisplay ?? '');
    AppRoute.checkout.navigateBackStack(context, extra: cartPageBloc.cart);
  }

  void showRequestQuoteWarningDialog(BuildContext context, {String? message}) {
    displayDialogWidget(
      context: context,
      message: message,
      actions: [
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.cancel.localized()),
        ),
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
            var cartPageBloc = context.read<CartPageBloc>();
            navigateToCheckout(context, cartPageBloc);
          },
          child: Text(LocalizationConstants.oK.localized()),
        ),
      ],
    );
  }

  void showSignInDialog(BuildContext context, {String? message}) {
    displayDialogWidget(
      context: context,
      title: LocalizationConstants.notSignedIn.localized(),
      message: message,
      actions: [
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.cancel.localized()),
        ),
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
            AppRoute.login.navigateBackStack(context);
          },
          child: Text(LocalizationConstants.signIn.localized()),
        ),
      ],
    );
  }

  List<Widget> _buildCartWidgets(
      Cart? cart,
      CartSettings? settings,
      Warehouse? warehouse,
      PromotionCollectionModel? promotions,
      bool isCustomerOrderApproval,
      bool hasWillCall,
      String shippingMethod,
      bool? hidePricingEnable,
      bool? hideInventoryEnable,
      BuildContext context) {
    List<Widget> list = [];

    final paymentSummaryEntity = PaymentSummaryEntity(
        cart: cart,
        cartSettings: settings,
        promotions: promotions,
        isCustomerOrderApproval: isCustomerOrderApproval);
    final shippingEntity = ShippingEntity(
        hasWillCall: hasWillCall,
        warehouse: warehouse,
        shippingMethod:
            (shippingMethod.equalsIgnoreCase(ShippingOption.pickUp.name)
                ? ShippingOption.pickUp
                : ShippingOption.ship));

    if (!(hidePricingEnable ?? false)) {
      list.add(
          CartPaymentSummaryWidget(paymentSummaryEntity: paymentSummaryEntity));
    }
    list.add(BlocProvider<CartShippingSelectionBloc>(
      create: (context) => sl<CartShippingSelectionBloc>()
        ..add(CartShippingOptionDefaultEvent(shippingEntity.shippingMethod!)),
      child: CartShippingWidget(
        shippingEntity: shippingEntity,
        onCallBack: _handlePickUpLocationCallBack,
      ),
    ));

    list.add(BlocProvider<CartContentBloc>(
      create: (context) => sl<CartContentBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<SavedOrderHandlerCubit, SavedOrderHandlerState>(
            listener: (context, state) {
              if (state.status == SavedOrderHandlerStatus.shouldClearCart) {
                context.read<CartContentBloc>().add(CartContentClearAllEvent());

                AppRoute.savedOrderDetails.navigate(
                  context,
                  pathParameters: {
                    'cartId': context
                            .read<SavedOrderHandlerCubit>()
                            .state
                            .savedCart
                            .id ??
                        '',
                  },
                );
              }
            },
            child: CartLineWidgetList(
              oderNumber: context.read<CartPageBloc>().cart?.orderNumber ?? '',
              cartLineEntities: context.read<CartPageBloc>().getCartLines(),
              onCartChangeCallBack: (context) {
                context.read<CartCountCubit>().loadCurrentCartCount();
                context.read<CartPageBloc>().add(CartPageLoadEvent());
              },
              hidePricingEnable: hidePricingEnable,
              hideInventoryEnable: hideInventoryEnable,
            ),
          );
        },
      ),
    ));
    list.add(const SizedBox(height: 8));

    return list;
  }

  void _handlePickUpLocationCallBack(
      BuildContext context, WarehouseEntity wareHouse) {
    context.read<CartPageBloc>().add(CartPagePickUpLocationChangeEvent(
        WarehouseEntityMapper.toModel(wareHouse)));
  }
}

class BuildCartErrorWidget extends StatelessWidget {
  final String cartErrorMsg;
  const BuildCartErrorWidget({
    required this.cartErrorMsg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: OptiAppColors.invalidColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10),
              child: const SvgAssetImage(
                assetName: AssetConstants.cartErrorIcon,
                fit: BoxFit.fitWidth,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  maxLines: null,
                  cartErrorMsg,
                  style: OptiTextStyles.errorTextStyles,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
