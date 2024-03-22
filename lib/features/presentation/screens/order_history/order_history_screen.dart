import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_history/order_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

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
            ),
          ),
          BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
              builder: (context, state) {
            if (state is OrderHistoryLoaded) {
              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 50,
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${state.orderEntities.length} Orders',
                            style: OptiTextStyles.header3,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SvgPicture.asset(
                                  height: 20,
                                  width: 20,
                                  AssetConstants.sortIcon,
                                  semanticsLabel: 'sort icon',
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SvgPicture.asset(
                                  height: 20,
                                  width: 20,
                                  AssetConstants.filterIcon,
                                  semanticsLabel: 'filter icon',
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.orderEntities.length,
                        itemBuilder: (context, index) {
                          return _OrderHistoryListItem(
                            orderEntity: state.orderEntities[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 0,
                            thickness: 1,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}

class _OrderHistoryListItem extends StatelessWidget {
  const _OrderHistoryListItem({required this.orderEntity});

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                orderEntity.orderNumberLabel ?? '',
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
          ...(orderEntity.webOrderNumber != null
              ? [
                  const SizedBox(height: 4),
                  Text(
                    (orderEntity.webOrderNumberLabel ?? '') +
                        (orderEntity.webOrderNumber ?? ''),
                    style: OptiTextStyles.bodySmall,
                  ),
                ]
              : []),
          ...(orderEntity.customerPO != null
              ? [
                  const SizedBox(height: 4),
                  Text(
                    (orderEntity.poNumberLabel ?? '') +
                        (orderEntity.customerPO ?? ''),
                    style: OptiTextStyles.bodySmall,
                  ),
                ]
              : []),
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
    );
  }
}
