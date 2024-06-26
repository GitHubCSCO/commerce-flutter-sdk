import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/payment_summary_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/shipping_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_shipping/cart_shipping_selection_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/refresh/pull_to_refresh_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void _reloadCartPage(BuildContext context) {
  context.read<CartCountCubit>().onCartItemChange();
  context.read<CartPageBloc>().add(CartPageLoadEvent());
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PullToRefreshBloc>(
          create: (context) => sl<PullToRefreshBloc>()),
      BlocProvider<CartPageBloc>(
          create: (context) => sl<CartPageBloc>()..add(CartPageLoadEvent())),
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
        title: const Text(LocalizationConstants.cart),
        backgroundColor: Colors.white,
        actions: [BottomMenuWidget(websitePath: websitePath)],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PullToRefreshBloc, PullToRefreshState>(
            listener: (context, state) {
              if (state is PullToRefreshLoadState) {
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
        ],
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<PullToRefreshBloc>(context)
                .add(PullToRefreshInitialEvent());
          },
          child: BlocBuilder<CartPageBloc, CartPageState>(
            builder: (_, state) {
              switch (state) {
                case CartPageInitialState():
                case CartPageLoadingState():
                  return const Center(child: CircularProgressIndicator());
                case CartPageLoadedState():
                  return Column(
                    children: [
                      if (state.cartWarningMsg.isNotEmpty)
                        _buildCartEroorWidget(
                            cartErrorMsg: state.cartWarningMsg),
                      Expanded(
                        child: ListView(
                          children: _buildCartWidgets(
                              state.cart,
                              state.cartSettings,
                              state.warehouse,
                              state.promotions,
                              state.isCustomerOrderApproval,
                              state.shippingMethod,
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
                                    child: const Text(
                                      LocalizationConstants.addAllToList,
                                    ),
                                    onPressed: () {
                                      final addCartLines = context
                                          .read<CartPageBloc>()
                                          .getAddCartLines();
                                      WishListCallbackHelper.addItemsToWishList(
                                        context,
                                        addToCartCollection:
                                            WishListAddToCartCollection(
                                          wishListLines: addCartLines,
                                        ),
                                        onAddedToCart: null,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TertiaryBlackButton(
                                    child: const Text(
                                        LocalizationConstants.saveOrder),
                                    onPressed: () {
                                      context
                                          .read<SavedOrderHandlerCubit>()
                                          .addCartToSavedOrders(
                                              cart: state.cart);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            PrimaryButton(
                              onPressed: () {
                                AppRoute.checkout.navigateBackStack(context,
                                    extra: context.read<CartPageBloc>().cart);
                              },
                              text: LocalizationConstants.checkout,
                            ),
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
                            child: SvgPicture.asset(
                              "assets/images/cart.svg",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          const Text('There are no items in your cart'),
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: TertiaryButton(
                              onPressed: () {
                                AppRoute.shop.navigate(context);
                              },
                              child: const Text('Continue Shopping'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]);
                default:
                  return const CustomScrollView(
                    slivers: <Widget>[
                      SliverFillRemaining(
                        child: Center(
                          child: Text(LocalizationConstants.errorLoadingCart),
                        ),
                      ),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCartWidgets(
      Cart? cart,
      CartSettings? settings,
      Warehouse? warehouse,
      PromotionCollectionModel promotions,
      bool isCustomerOrderApproval,
      String shippingMethod,
      BuildContext context) {
    List<Widget> list = [];

    final paymentSummaryEntity = PaymentSummaryEntity(
        cart: cart,
        cartSettings: settings,
        promotions: promotions,
        isCustomerOrderApproval: isCustomerOrderApproval);
    final shippingEntity = ShippingEntity(
        warehouse: warehouse,
        shippingMethod:
            (shippingMethod.equalsIgnoreCase(ShippingOption.pickUp.name)
                ? ShippingOption.pickUp
                : ShippingOption.ship));

    list.add(
        CartPaymentSummaryWidget(paymentSummaryEntity: paymentSummaryEntity));
    list.add(BlocProvider<CartShippingSelectionBloc>(
      create: (context) => sl<CartShippingSelectionBloc>()
        ..add(CartShippingOptionDefaultEvent(shippingEntity.shippingMethod!)),
      child: CartShippingWidget(shippingEntity: shippingEntity),
    ));

    list.add(BlocProvider<CartContentBloc>(
      create: (context) => sl<CartContentBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<SavedOrderHandlerCubit, SavedOrderHandlerState>(
            listener: (context, state) async {
              if (state.status == SavedOrderHandlerStatus.shouldClearCart) {
                context.read<CartContentBloc>().add(CartContentClearAllEvent());
              }

              AppRoute.savedOrders.navigate(context);

              if (context.mounted) {
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
                  extra: () {
                    context
                        .read<SavedOrderHandlerCubit>()
                        .shouldRefreshSavedOrder();
                  },
                );
              }
            },
            child: CartLineWidgetList(
              cartLineEntities: context.read<CartPageBloc>().getCartLines(),
            ),
          );
        },
      ),
    ));
    list.add(const SizedBox(height: 8));

    return list;
  }
}

class _buildCartEroorWidget extends StatelessWidget {
  final String cartErrorMsg;
  const _buildCartEroorWidget({
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
              child: SvgPicture.asset(
                AssetConstants.cartErrorIcon,
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
