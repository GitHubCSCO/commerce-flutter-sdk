import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/filter_status.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_history/order_history_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/order_history_list_item_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:badges/badges.dart' as badges;

class OrderHistoryScreen extends StatelessWidget {
  final bool? isFromVMI;
  OrderHistoryScreen({super.key, this.isFromVMI});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<OrderHistoryCubit>()..initialize(isFromVMI: isFromVMI ?? false),
      child: OrderHistoryPage(isFromVMI),
    );
  }
}

class OrderHistoryPage extends StatelessWidget with BaseDynamicContentScreen {
  final bool? isFromVMI;
  OrderHistoryPage(this.isFromVMI, {super.key});

  final _textEditingController = TextEditingController();

  late final String websitePath;

  @override
  Widget build(BuildContext context) {
    var vmlLocationId = context.read<OrderHistoryCubit>().vmiLocationId;
    websitePath = isFromVMI == true
        ? WebsitePaths.vmiOrdersPath.format([vmlLocationId ?? ''])
        : WebsitePaths.ordersPath;
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        actions: <Widget>[
          BottomMenuWidget(websitePath: websitePath),
        ],
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
              hintText: LocalizationConstants.search.localized(),
              suffixIcon: IconButton(
                icon: const SvgAssetImage(
                  assetName: AssetConstants.iconClear,
                  semanticsLabel: 'search query clear icon',
                  fit: BoxFit.fitWidth,
                ),
                onPressed: () {
                  _textEditingController.clear();

                  context
                      .read<OrderHistoryCubit>()
                      .searchQueryChanged(_textEditingController.text);
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              textInputAction: TextInputAction.search,
              controller: _textEditingController,
              onChanged: (value) {
                context.read<OrderHistoryCubit>().searchQueryChanged(value);
              },
              onSubmitted: (value) {
                context.read<OrderHistoryCubit>().searchQueryChanged(value);
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
                          hidePricingEnable: state.hidePricingEnable,
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
  final List<OrderEntity> orderEntities;
  final bool? hidePricingEnable;

  const _OrderHistoryListWidget(
      {required this.orderEntities, this.hidePricingEnable});

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

              final orderEntity = widget.orderEntities[index];

              return OrderHistoryListItem(
                orderEntity: orderEntity,
                onTap: () {
                  AppRoute.orderDetails.navigateBackStack(
                    context,
                    extra: context.read<OrderHistoryCubit>().state.isFromVMI,
                    pathParameters: {
                      'orderNumber': (orderEntity.webOrderNumber.isNullOrEmpty)
                          ? (orderEntity.erpOrderNumber ?? '')
                          : orderEntity.webOrderNumber!,
                    },
                  );
                },
                hidePricingEnable: widget.hidePricingEnable,
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
        icon: const SvgAssetImage(
          height: 20,
          width: 20,
          assetName: AssetConstants.filterIcon,
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
                label: LocalizationConstants.showMyOrdersOnly.localized(),
                value: state.temporaryShowMyOrdersValue,
                onChanged: (_) => onShowMyOrdersToggled(),
              ),
              FilterOptionsChip(
                label: LocalizationConstants.status.localized(),
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
