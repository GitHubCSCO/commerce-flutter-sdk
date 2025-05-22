import 'dart:async';

import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_content/cart_content_state.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/cart/cart_line/cart_line_header_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/cart/cart_line/cart_line_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/cart/cart_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/error_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void _reloadCartItemsList(BuildContext context) {
  unawaited(context.read<CartCountCubit>().loadCurrentCartCount());
  context.read<CartPageBloc>().add(CartPageLoadEvent());
}

class CartAllListScreen extends StatelessWidget {
  const CartAllListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CartPageBloc>()..add(CartPageLoadEvent()),
        ),
        BlocProvider<CartContentBloc>(
          create: (context) => sl<CartContentBloc>(),
        ),
      ],
      child: const CartAllListPage(),
    );
  }
}

class CartAllListPage extends StatelessWidget {
  const CartAllListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Cart Details'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<RootBloc, RootState>(
            listener: (context, state) async {
              if (state is RootConfigReload ||
                  state is RootCartReload ||
                  state is RootPricingInventoryReload) {
                _reloadCartItemsList(context);
              }
            },
          ),
          BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                authCubitChangeTrigger(previous, current),
            listener: (context, state) {
              _reloadCartItemsList(context);
            },
          ),
          BlocListener<DomainCubit, DomainState>(
            listener: (context, state) {
              if (state is DomainLoaded) {
                _reloadCartItemsList(context);
              }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: () async {
            _reloadCartItemsList(context);
          },
          child: BlocConsumer<CartContentBloc, CartContentState>(
            buildWhen: (previous, current) {
              return current is CartContentDefaultState;
            },
            listener: (context, state) {
              if (state is CartContentClearAllSuccessState ||
                  state is CartContentItemRemovedSuccessState) {
                unawaited(context.read<CartCountCubit>().onCartItemChange());
                context.read<RootBloc>().add(RootCartUpdateEvent());
              } else if (state is CartContentQuantityChangedSuccessState) {
                if (state.message != null) {
                  CustomSnackBar.showSnackBarMessage(
                    context,
                    state.message ?? '',
                  );
                }
                unawaited(context.read<CartCountCubit>().onCartItemChange());
                context.read<RootBloc>().add(RootCartUpdateEvent());
              }
            },
            builder: (context, state) {
              switch (state) {
                case CartContentDefaultState():
                  return const CartAllListBody();
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}

class CartAllListBody extends StatelessWidget {
  const CartAllListBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartPageBloc, CartPageState>(
        buildWhen: (previous, current) {
      if (current is CartPageWarningDialogShowState ||
          current is CartProceedToCheckoutState ||
          current is CartPageCheckoutButtonLoadingState) {
        return false;
      }
      return true;
    }, builder: (_, state) {
      switch (state) {
        case CartPageInitialState():
        case CartPageLoadingState():
          return const Center(child: CircularProgressIndicator());
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
                    child: SvgAssetImage(
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
                            context.read<CartPageBloc>().cart?.orderNumber ??
                                '');
                        context.pop();
                        AppRoute.shop.navigate(context);
                      },
                      text: LocalizationConstants.continueShopping.localized(),
                    ),
                  )
                ],
              ),
            ),
          ]);
        case CartPageLoadedState():
          final cartLines = context.watch<CartPageBloc>().getCartLines();
          return Column(
            children: [
              if (state.cartWarningMsg.isNotEmpty)
                BuildCartErrorWidget(cartErrorMsg: state.cartWarningMsg),
              Expanded(
                child: SafeArea(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.cart?.cartLines?.length ?? 0 + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return CartContentHeaderWidget(
                          orderNumber: state.cart?.orderNumber ?? '',
                          cartCount: cartLines.length,
                        );
                      }

                      final cartLineEntity = cartLines[index - 1];
                      return CartLineWidget(
                        navigateWithoutNavbar: true,
                        cartLineEntity: cartLineEntity,
                        showRemoveButton: context
                            .read<CartContentBloc>()
                            .showRemoveButtonForPromotionItem(cartLineEntity),
                        onCartQuantityChangedCallback: (quantity) {
                          context.read<CartContentBloc>().add(
                                CartContentQuantityChangedEvent(
                                  orderNumber: state.cart?.orderNumber ?? '',
                                  cartLineEntity: cartLineEntity.copyWith(
                                      qtyOrdered: quantity),
                                ),
                              );
                        },
                        onCartLineRemovedCallback: (cartLineEntity) {
                          context.read<CartContentBloc>().add(
                              CartContentRemoveEvent(
                                  orderNumber: state.cart?.orderNumber ?? '',
                                  cartLine: CartLineEntityMapper.toModel(
                                      cartLineEntity)));
                        },
                        hidePricingEnable: state.hidePricingEnable,
                        hideInventoryEnable: state.hideInventoryEnable,
                      );
                    },
                  ),
                ),
              ),
            ],
          );

        default:
          return CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                  child: OptiErrorWidget(
                onRetry: () {
                  _reloadCartItemsList(context);
                },
                errorText: LocalizationConstants.errorLoadingCart.localized(),
              )),
            ],
          );
      }
    });
  }
}

void _trackContinueShoppingEvent(BuildContext context, String orderNumber) {
  context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
          AnalyticsConstants.eventContinueShopping,
          AnalyticsConstants.screenNameCart)
      .withProperty(
          name: AnalyticsConstants.eventPropertyOrderNumber,
          strValue: orderNumber)));
}
