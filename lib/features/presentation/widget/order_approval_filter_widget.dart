import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_approval/order_approval_filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:badges/badges.dart' as badges;

class OrderApprovalFilterWidget extends StatelessWidget {
  final OrderApprovalParameters orderApprovalParameters;
  final bool hasFilter;
  final void Function({
    String? orderNumber,
    String? orderTotal,
    String? orderTotalOperator,
    DateTime? fromDate,
    DateTime? toDate,
    ShipTo? shipTo,
  }) onApply;

  const OrderApprovalFilterWidget({
    super.key,
    required this.orderApprovalParameters,
    required this.onApply,
    required this.hasFilter,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrderApprovalFilterCubit>(),
      child: Builder(
        builder: (context) {
          return badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 0),
            badgeStyle: const badges.BadgeStyle(
              shape: badges.BadgeShape.circle,
              badgeColor: Colors.black,
              padding: EdgeInsets.all(6),
              elevation: 0,
            ),
            showBadge: hasFilter,
            child: IconButton(
              padding: const EdgeInsets.all(10),
              onPressed: () {
                context.read<OrderApprovalFilterCubit>().initialize(
                      orderApprovalParameters: orderApprovalParameters,
                    );

                _showOrderApprovalFilterWidget(
                  context,
                  onReset: () {
                    context.read<OrderApprovalFilterCubit>().reset();
                  },
                  onApply: () {
                    final currentState =
                        context.read<OrderApprovalFilterCubit>().state;
                    onApply(
                      orderNumber: currentState.orderNumber,
                      orderTotal: currentState.orderTotal,
                      orderTotalOperator: currentState.orderTotalOperator,
                      fromDate: currentState.fromDate,
                      toDate: currentState.toDate,
                      shipTo: currentState.shipTo,
                    );
                  },
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
        },
      ),
    );
  }
}

void _showOrderApprovalFilterWidget(
  BuildContext context, {
  required void Function() onReset,
  required void Function() onApply,
}) {
  showFilterModalSheet(
    context,
    onApply: onApply,
    onReset: onReset,
    child: BlocProvider.value(
      value: BlocProvider.of<OrderApprovalFilterCubit>(context),
      child: BlocBuilder<OrderApprovalFilterCubit, OrderApprovalFilterState>(
        builder: (context, state) {
          return _FilterBodyWidget(
            orderNumber: state.orderNumber,
          );
        },
      ),
    ),
  );
}

class _FilterBodyWidget extends StatefulWidget {
  const _FilterBodyWidget({
    required this.orderNumber,
  });

  final String? orderNumber;

  @override
  State<_FilterBodyWidget> createState() => __FilterBodyWidgetState();
}

class __FilterBodyWidgetState extends State<_FilterBodyWidget> {
  final TextEditingController orderNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.orderNumber != null
        ? orderNumberController.text = widget.orderNumber!
        : null;
    orderNumberController.addListener(submit);
  }

  @override
  void dispose() {
    orderNumberController.removeListener(submit);
    orderNumberController.dispose();
    super.dispose();
  }

  void submit() {
    context
        .read<OrderApprovalFilterCubit>()
        .setOrderNumber(orderNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderApprovalFilterCubit, OrderApprovalFilterState>(
      listener: (context, state) {
        if (state.orderNumber != orderNumberController.text) {
          orderNumberController.text = state.orderNumber ?? '';
          orderNumberController.selection = TextSelection.fromPosition(
            TextPosition(offset: orderNumberController.text.length),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Input(
            controller: orderNumberController,
            label: 'Order Number',
            hintText: 'Order #',
          ),
        ],
      ),
    );
  }
}
