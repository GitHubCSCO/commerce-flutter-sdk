import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/scanning_mode.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quick_order/order_list/order_list_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/quick_order/order_item_pricing_inventory_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/quick_order/count_inventory/count_inventory_item_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/quick_order/quick_order_list/quick_order_item_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/quick_order/quick_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuickOrderListWidget extends StatelessWidget {
  final Function(BuildContext context, QuickOrderItemEntity,
      OrderCallBackType orderCallBackType) callback;
  final ScanningMode scanningMode;

  const QuickOrderListWidget(
      {super.key, required this.callback, required this.scanningMode});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderListBloc, OrderListState>(
        listener: (context, state) {},
        buildWhen: (previous, current) =>
            current is OrderListInitialState ||
            current is OrderListLoadingState ||
            current is OrderListLoadedState ||
            current is OrderListFailedState,
        builder: (context, state) {
          switch (state) {
            case OrderListInitialState():
            case OrderListFailedState():
              return _instructionWidget(context);
            case OrderListLoadingState():
              return const Center(child: CircularProgressIndicator());
            case OrderListLoadedState():
              return state.quickOrderItemList.isEmpty
                  ? _instructionWidget(context)
                  : ListView.builder(
                      itemCount: state.quickOrderItemList.length,
                      itemBuilder: (context, index) {
                        var entity = state.quickOrderItemList[index];
                        var setting = state.productSettings!;
                        return BlocProvider(
                            create: (context) =>
                                sl<OrderItemPricingInventoryCubit>()
                                  ..getPricingAndInventory(entity, setting),
                            child: scanningMode == ScanningMode.count
                                ? CountInventoryItemWidget(
                                    callback: callback,
                                    quickOrderItemEntity: entity,
                                  )
                                : QuickOrderItemWidget(
                                    callback: callback,
                                    quickOrderItemEntity: entity,
                                    setting: setting,
                                  ));
                      },
                    );
            default:
              return Container();
          }
        });
  }

  Widget _instructionWidget(BuildContext context) {
    final message = context.read<OrderListBloc>().instructionsMessage;
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: Text(
            message ?? SiteMessageConstants.defaultValueQuickOrderInstructions,
            style: OptiTextStyles.bodySmall,
          ),
        )
      ],
    );
  }
}
