import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_approval/order_approval_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_approval/order_approval_handler/order_approval_handler_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/order_approval_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OrderApprovalScreen extends StatelessWidget {
  const OrderApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrderApprovalCubit>()..loadOrderApprovalList(),
      child: Builder(builder: (context) {
        return BlocListener<OrderApprovalHandlerCubit,
            OrderApprovalHandlerState>(
          listener: (context, state) {
            if (state.status ==
                OrderApprovalHandlerStatus.shouldRefreshOrderApproval) {
              context.read<OrderApprovalCubit>().loadOrderApprovalList();
              context.read<OrderApprovalHandlerCubit>().resetState();
            }
          },
          child: const OrderApprovalPage(),
        );
      }),
    );
  }
}

class OrderApprovalPage extends StatelessWidget {
  const OrderApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: Text(LocalizationConstants.orderApproval.localized()),
        centerTitle: false,
        actions: [
          BottomMenuWidget(
            websitePath: WebsitePaths.orderApprovalWebsitePath,
          )
        ],
      ),
      body: BlocBuilder<OrderApprovalCubit, OrderApprovalState>(
        builder: (context, state) {
          switch (state.status) {
            case OrderStatus.loading || OrderStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case OrderStatus.failure:
              return Center(
                child: Text(
                  SiteMessageConstants.defaultMobileAppAlertCommunicationError,
                ),
              );
            default:
              return Column(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.orderApprovalCollectionModel.pagination
                                      ?.totalItemCount !=
                                  null
                              ? '${state.orderApprovalCollectionModel.pagination?.totalItemCount} ${LocalizationConstants.orders.localized()}'
                              : '',
                          style: OptiTextStyles.header3,
                        ),
                        OrderApprovalFilterWidget(
                          orderApprovalParameters:
                              state.orderApprovalParameters,
                          onApply: ({
                            orderNumber,
                            orderTotal,
                            orderTotalOperator,
                            fromDate,
                            toDate,
                            shipTo,
                          }) {
                            context.read<OrderApprovalCubit>().applyFilter(
                                  orderNumber: orderNumber,
                                  orderTotal: orderTotal,
                                  orderTotalOperator: orderTotalOperator,
                                  fromDate: fromDate,
                                  toDate: toDate,
                                  shipTo: shipTo,
                                );
                          },
                          hasFilter:
                              context.read<OrderApprovalCubit>().hasFilter,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _OrderApprovalListWidget(
                      cartList:
                          state.orderApprovalCollectionModel.cartCollection ??
                              [],
                    ),
                  )
                ],
              );
          }
        },
      ),
    );
  }
}

class _OrderApprovalListWidget extends StatefulWidget {
  final List<Cart> cartList;

  const _OrderApprovalListWidget({
    required this.cartList,
  });

  @override
  State<_OrderApprovalListWidget> createState() =>
      __OrderApprovalListWidgetState();
}

class __OrderApprovalListWidgetState extends State<_OrderApprovalListWidget> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<OrderApprovalCubit>().loadMoreOrderApprovalList();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderApprovalCubit, OrderApprovalState>(
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            if (index >=
                    (state.orderApprovalCollectionModel.cartCollection
                            ?.length ??
                        0) &&
                state.status == OrderStatus.moreLoading) {
              return const Padding(
                padding: EdgeInsets.all(10),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return _OrderApprovalItem(
              cart: widget.cartList[index],
              onTap: () {
                AppRoute.orderApprovalDetails.navigateBackStack(
                  context,
                  pathParameters: {
                    'cartId': widget.cartList[index].id ?? '',
                  },
                  extra: () {
                    context.read<OrderApprovalCubit>().loadOrderApprovalList();
                  },
                );
              },
              hidePricingEnable: state.hidePricingEnable,
            );
          },
          separatorBuilder: (context, index) => const Divider(
            height: 0,
            thickness: 1,
          ),
          itemCount: state.status == OrderStatus.moreLoading
              ? widget.cartList.length + 1
              : widget.cartList.length,
        );
      },
    );
  }
}

class _OrderApprovalItem extends StatelessWidget {
  final Cart cart;
  final bool? hidePricingEnable;
  final void Function()? onTap;

  const _OrderApprovalItem({
    required this.cart,
    this.onTap,
    this.hidePricingEnable,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        color: OptiAppColors.backgroundWhite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cart.orderNumber ?? '',
                  style: OptiTextStyles.body
                      .copyWith(color: OptiAppColors.primaryColor),
                ),
                Text(
                  cart.orderDate != null
                      ? DateFormat(CoreConstants.dateFormatShortString)
                          .format(cart.orderDate!)
                      : '',
                  style: OptiTextStyles.body,
                ),
              ],
            ),
            Text(
              cart.initiatedByUserName ?? '',
              style: OptiTextStyles.bodySmall,
            ),
            Text(
              cart.fulfillmentMethod == 'PickUp'
                  ? (cart.defaultWarehouse?.name ?? '')
                  : (cart.shipToLabel ?? ''),
              style: OptiTextStyles.bodySmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: !(hidePricingEnable ?? false),
                  child: Text(
                    cart.orderGrandTotalDisplay ?? '',
                    style: OptiTextStyles.bodySmallHighlight,
                  ),
                ),
                Text(
                  cart.approverReason ?? '',
                  style: OptiTextStyles.bodySmallHighlight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
