import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/payment_summary_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/shipping_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_shipping/cart_shipping_selection_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/refresh/pull_to_refresh_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line_list.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_payment_summary_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void _reloadCartPage(BuildContext context) {
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
    ], child: const CartPage());
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        title: const Text(LocalizationConstants.cart),
        backgroundColor: Colors.white,
        actions: [BottomMenuWidget()],
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
                AuthCubitChangeTrigger(previous, current),
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
        ],
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<PullToRefreshBloc>(context)
                .add(PullToRefreshInitialEvent());
          },
          child: BlocBuilder<CartPageBloc, CartPageState>(
            builder: (context, state) {
              switch (state) {
                case CartPageInitialState():
                case CartPageLoadingState():
                  return const Center(child: CircularProgressIndicator());
                case CartPageLoadedState():
                  return ListView(
                    children: _buildCartWidgets(
                        state.cart,
                        state.cartSettings,
                        state.warehouse,
                        state.promotions,
                        state.isCustomerOrderApproval,
                        state.shippingMethod),
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
                                CustomSnackBar.showComingSoonSnackBar(context);
                              },
                              child: Text('Continue Shopping'),
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
      String shippingMethod) {
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
      child: CartLineWidgetList(
          cartLineEntities: CartLineListMapper()
              .toEntity(CartLineList(cartLines: cart!.cartLines))),
    ));

    return list;
  }
}
