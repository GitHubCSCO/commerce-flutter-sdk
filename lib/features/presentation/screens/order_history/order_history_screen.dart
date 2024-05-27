import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/filter_status.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_history/order_history_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/widget/order_history_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:badges/badges.dart' as badges;

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrderHistoryCubit>()..loadOrderHistory(),
      child: OrderHistoryPage(),
    );
  }
}

class OrderHistoryPage extends BaseDynamicContentScreen {
  OrderHistoryPage({super.key});

  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: const Text('My Orders'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Input(
              hintText: LocalizationConstants.search,
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  AssetConstants.iconClear,
                  semanticsLabel: 'search query clear icon',
                  fit: BoxFit.fitWidth,
                ),
                onPressed: () {
                  _textEditingController.clear();
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              textInputAction: TextInputAction.search,
              controller: _textEditingController,
              onSubmitted: (value) {
                CustomSnackBar.showComingSoonSnackBar(context);
              },
            ),
          ),
          BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
            builder: (context, state) {
              switch (state.orderStatus) {
                case OrderStatus.loading || OrderStatus.initial:
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                case OrderStatus.failure:
                  return const Expanded(
                    child: Center(
                      child: Text('Error loading orders'),
                    ),
                  );
                default:
                  return Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: 50,
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${state.orderEntities.pagination?.totalItemCount ?? ' '} Orders',
                                style: OptiTextStyles.header3,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SortToolMenu(
                                    selectedSortOrder: state.orderSortOrder,
                                    availableSortOrders: context
                                        .read<OrderHistoryCubit>()
                                        .availableSortOrders,
                                    onSortOrderChanged:
                                        (SortOrderAttribute sortOrder) async {
                                      await context
                                          .read<OrderHistoryCubit>()
                                          .changeSortOrder(
                                            sortOrder as OrderSortOrder,
                                          );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  const _OrderHistoryFilter(),
                                ],
                              )
                            ],
                          ),
                        ),
                        _OrderHistoryListWidget(
                          orderEntities: state.orderEntities.orders ?? [],
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _OrderHistoryListWidget extends StatefulWidget {
  const _OrderHistoryListWidget({required this.orderEntities});

  final List<OrderEntity> orderEntities;

  @override
  State<_OrderHistoryListWidget> createState() =>
      __OrderHistoryListWidgetState();
}

class __OrderHistoryListWidgetState extends State<_OrderHistoryListWidget> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<OrderHistoryCubit>().loadMoreOrderHistory();
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
    return Expanded(
      child: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
        builder: (context, state) {
          return ListView.separated(
            controller: _scrollController,
            itemCount: state.orderStatus == OrderStatus.moreLoading
                ? widget.orderEntities.length + 1
                : widget.orderEntities.length,
            itemBuilder: (context, index) {
              if (index >= state.orderEntities.orders!.length &&
                  state.orderStatus == OrderStatus.moreLoading) {
                return const Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return OrderHistoryListItem(
                orderEntity: widget.orderEntities[index],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0,
                thickness: 1,
              );
            },
          );
        },
      ),
    );
  }
}

class _OrderHistoryListItem extends StatelessWidget {
  const _OrderHistoryListItem({required this.orderEntity});

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRoute.orderDetails.navigate(
        context,
        pathParameters: {
          'orderNumber': (orderEntity.webOrderNumber.isNullOrEmpty)
              ? (orderEntity.erpOrderNumber ?? '')
              : orderEntity.webOrderNumber!,
        },
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
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
                  orderEntity.orderNumberLabel ?? orderEntity.orderNumber ?? '',
                  style: OptiTextStyles.body,
                ),
                Text(
                  orderEntity.orderDate != null
                      ? DateFormat(CoreConstants.dateFormatShortString)
                          .format(orderEntity.orderDate!)
                      : '',
                  style: OptiTextStyles.body,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              (orderEntity.poNumberLabel ?? 'PO #') +
                  (orderEntity.customerPO ?? ''),
              style: OptiTextStyles.bodySmall,
            ),
            ...(orderEntity.stCompanyName != null
                ? [
                    const SizedBox(height: 4),
                    Text(
                      orderEntity.stCompanyName ?? '',
                      style: OptiTextStyles.bodySmall,
                    ),
                  ]
                : []),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderEntity.orderGrandTotalDisplay ?? '',
                  style: OptiTextStyles.bodySmallHighlight,
                ),
                Text(
                  orderEntity.statusDisplay ?? '',
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

class _OrderHistoryFilter extends StatelessWidget {
  const _OrderHistoryFilter();

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 0),
      badgeStyle: const badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        badgeColor: Colors.black,
        padding: EdgeInsets.all(6),
        elevation: 0,
      ),
      showBadge: context.watch<OrderHistoryCubit>().state.numberOfFilters > 0,
      badgeContent: Text(
        context.watch<OrderHistoryCubit>().state.numberOfFilters.toString(),
        style: OptiTextStyles.badgesStyle,
      ),
      child: IconButton(
        padding: const EdgeInsets.all(10),
        onPressed: () {
          _showOrderHistoryFilter(
            context,
            onApply: context.read<OrderHistoryCubit>().applyFilter,
            onReset: context.read<OrderHistoryCubit>().resetFilter,
            onStatusValueAdded:
                context.read<OrderHistoryCubit>().addFilterValue,
            onStatusValueRemoved:
                context.read<OrderHistoryCubit>().removeFilterValue,
            onShowMyOrdersToggled:
                context.read<OrderHistoryCubit>().toggleShowMyOrders,
          );
        },
        icon: SvgPicture.asset(
          height: 20,
          width: 20,
          AssetConstants.filterIcon,
          semanticsLabel: 'filter icon',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

void _showOrderHistoryFilter(
  BuildContext context, {
  required void Function() onApply,
  required void Function() onReset,
  required void Function(String value) onStatusValueAdded,
  required void Function(String value) onStatusValueRemoved,
  required void Function() onShowMyOrdersToggled,
}) {
  context.read<OrderHistoryCubit>().loadFilterValues();
  showFilterModalSheet(
    context,
    onApply: onApply,
    onReset: onReset,
    child: BlocProvider.value(
      value: BlocProvider.of<OrderHistoryCubit>(context),
      child: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
        builder: (context, state) {
          if (state.filterStatus == FilterStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.filterStatus == FilterStatus.failure) {
            return const Center(
              child: Text('Error loading filter values'),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterOptionSwitch(
                label: LocalizationConstants.showMyOrdersOnly,
                value: state.temporaryShowMyOrdersValue,
                onChanged: (_) => onShowMyOrdersToggled(),
              ),
              FilterOptionsChip(
                label: LocalizationConstants.status,
                values: state.filterValues,
                selectedValueIds: state.temporarySelectedFilterValueIds,
                onSelectionIdAdded: onStatusValueAdded,
                onSelectionIdRemoved: onStatusValueRemoved,
              ),
            ],
          );
        },
      ),
    ),
  );
}
