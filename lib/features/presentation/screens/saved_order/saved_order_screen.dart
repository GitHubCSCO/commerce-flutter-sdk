import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/saved_order/saved_order_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/saved_order_handler/saved_order_handler_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SavedOrderScreen extends StatelessWidget {
  const SavedOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SavedOrderCubit>()..initialize(),
      child: const SavedOrderPage(),
    );
  }
}

class SavedOrderPage extends StatelessWidget {
  const SavedOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: Text(LocalizationConstants.savedOrders.localized()),
        centerTitle: false,
        actions: [
          BottomMenuWidget(
            websitePath: WebsitePaths.savedOrdersWebsitePath,
          )
        ],
      ),
      body: BlocListener<SavedOrderHandlerCubit, SavedOrderHandlerState>(
        listener: (context, state) {
          if (state.status == SavedOrderHandlerStatus.shouldRefreshSavedOrder ||
              state.status == SavedOrderHandlerStatus.failure) {
            context.read<SavedOrderCubit>().initialize();
            context.read<SavedOrderHandlerCubit>().resetState();
          }
        },
        child: BlocBuilder<SavedOrderCubit, SavedOrderState>(
          builder: (context, state) {
            switch (state.status) {
              case OrderStatus.loading || OrderStatus.initial:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case OrderStatus.failure:
                return Center(
                  child: Text(
                    SiteMessageConstants
                        .defaultMobileAppAlertCommunicationError,
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
                            ((state.cartCollectionModel.pagination
                                            ?.totalItemCount ??
                                        0) !=
                                    0)
                                ? '${state.cartCollectionModel.pagination?.totalItemCount} ${LocalizationConstants.orders.localized()}'
                                : '',
                            style: OptiTextStyles.header3,
                          ),
                          SortToolMenu(
                            availableSortOrders: CartSortOrder.values,
                            onSortOrderChanged: (selectedSortOrder) async {
                              context.read<SavedOrderCubit>().changeSortOrder(
                                    selectedSortOrder as CartSortOrder,
                                  );
                            },
                            selectedSortOrder: state.sortOrder,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: (state.cartCollectionModel.carts ?? []).isNotEmpty
                          ? _SavedOrderListWidget(
                              savedOrders:
                                  state.cartCollectionModel.carts ?? [],
                            )
                          : Center(
                              child: Text(LocalizationConstants.noSavedOrders
                                  .localized()),
                            ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}

class _SavedOrderListWidget extends StatefulWidget {
  const _SavedOrderListWidget({
    required this.savedOrders,
  });

  final List<Cart> savedOrders;

  @override
  State<_SavedOrderListWidget> createState() => _SavedOrderListWidgetState();
}

class _SavedOrderListWidgetState extends State<_SavedOrderListWidget> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<SavedOrderCubit>().loadMoreSavedOrders();
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
    return BlocBuilder<SavedOrderCubit, SavedOrderState>(
      builder: (context, state) {
        return ListView.separated(
          controller: _scrollController,
          itemBuilder: (context, index) {
            if (index >= (state.cartCollectionModel.carts?.length ?? 0) &&
                state.status == OrderStatus.moreLoading) {
              return const Padding(
                padding: EdgeInsets.all(10),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return _SavedOrderItem(
              cart: widget.savedOrders[index],
              onTap: () {
                AppRoute.savedOrderDetails.navigateBackStack(
                  context,
                  pathParameters: {
                    'cartId': widget.savedOrders[index].id ?? '',
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
              ? widget.savedOrders.length + 1
              : widget.savedOrders.length,
        );
      },
    );
  }
}

class _SavedOrderItem extends StatelessWidget {
  final Cart cart;
  final bool? hidePricingEnable;
  final void Function()? onTap;

  const _SavedOrderItem({
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
            Text(
              cart.shipToLabel ?? '',
              style: OptiTextStyles.body,
            ),
            Text(
              cart.orderDate != null
                  ? DateFormat(CoreConstants.dateFormatString)
                      .add_jms()
                      .format(cart.orderDate!)
                  : '',
              style: OptiTextStyles.bodySmall.copyWith(
                color: OptiAppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Visibility(
              visible: !(hidePricingEnable ?? false),
              child: Text(
                cart.orderSubTotalDisplay ?? '',
                style: OptiTextStyles.bodySmall.copyWith(
                  color: OptiAppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
