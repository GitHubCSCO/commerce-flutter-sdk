import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_approval/order_approval_filter_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/date_picker_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/list_picker_widget.dart';
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FilterOrderTotalWidget(
                orderNumber: state.orderNumber,
              ),
              const SizedBox(height: 30),
              Text(
                LocalizationConstants.orderTotal,
                style: OptiTextStyles.subtitle,
              ),
              const SizedBox(height: 10),
              const _FilterTotalTypeWidget(),
              const SizedBox(height: 10),
              _FilterTotalAmountWidget(
                orderTotal: state.orderTotal,
              ),
              const SizedBox(height: 30),
              Text(
                LocalizationConstants.dateRange,
                style: OptiTextStyles.subtitle,
              ),
              const SizedBox(height: 10),
              _FilterDatePickerWidget(
                title: LocalizationConstants.from,
                selectedDate: state.fromDate,
                onSelectDate: (innerContext, date) {
                  context.read<OrderApprovalFilterCubit>().setFromDate(date);
                },
              ),
              const SizedBox(height: 10),
              _FilterDatePickerWidget(
                title: LocalizationConstants.to,
                selectedDate: state.toDate,
                onSelectDate: (innerContext, date) {
                  context.read<OrderApprovalFilterCubit>().setToDate(date);
                },
              ),
            ],
          );
        },
      ),
    ),
  );
}

class _FilterOrderTotalWidget extends StatefulWidget {
  const _FilterOrderTotalWidget({
    required this.orderNumber,
  });

  final String? orderNumber;

  @override
  State<_FilterOrderTotalWidget> createState() =>
      _FilterOrderTotalWidgetState();
}

class _FilterOrderTotalWidgetState extends State<_FilterOrderTotalWidget> {
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
            hintText: LocalizationConstants.orderNumberSign,
          ),
        ],
      ),
    );
  }
}

class _FilterTotalTypeWidget extends StatelessWidget {
  const _FilterTotalTypeWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderApprovalFilterCubit, OrderApprovalFilterState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: OptiAppColors.backgroundInput,
            borderRadius: BorderRadius.circular(AppStyle.borderRadius),
          ),
          height: 50,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: OptiAppColors.backgroundInput,
                  borderRadius: BorderRadius.circular(AppStyle.borderRadius),
                ),
                height: 50,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: ListPicker(
                              selectedIndex: context
                                      .watch<OrderApprovalFilterCubit>()
                                      .orderTotalOperators
                                      .contains(state.orderTotalOperator)
                                  ? context
                                      .watch<OrderApprovalFilterCubit>()
                                      .orderTotalOperators
                                      .indexOf(
                                        state.orderTotalOperator ?? '',
                                      )
                                  : 0,
                              items: context
                                  .watch<OrderApprovalFilterCubit>()
                                  .orderTotalOperators,
                              callback: (context, item) {
                                if (item ==
                                    context
                                        .read<OrderApprovalFilterCubit>()
                                        .orderTotalOperators
                                        .first) {
                                  context
                                      .read<OrderApprovalFilterCubit>()
                                      .setOrderTotalOperator(null);
                                  return;
                                }
                                context
                                    .read<OrderApprovalFilterCubit>()
                                    .setOrderTotalOperator(item.toString());
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              AssetConstants.iconArrowDown,
                              fit: BoxFit.fitWidth,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterTotalAmountWidget extends StatefulWidget {
  final String? orderTotal;

  const _FilterTotalAmountWidget({
    required this.orderTotal,
  });

  @override
  State<_FilterTotalAmountWidget> createState() =>
      _FilterTotalAmountWidgetState();
}

class _FilterTotalAmountWidgetState extends State<_FilterTotalAmountWidget> {
  final TextEditingController orderTotalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.orderTotal != null
        ? orderTotalController.text = widget.orderTotal!
        : null;
    orderTotalController.addListener(submit);
  }

  @override
  void dispose() {
    orderTotalController.removeListener(submit);
    orderTotalController.dispose();
    super.dispose();
  }

  void submit() {
    context
        .read<OrderApprovalFilterCubit>()
        .setOrderTotal(orderTotalController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderApprovalFilterCubit, OrderApprovalFilterState>(
      listener: (context, state) {
        if (state.orderTotal != orderTotalController.text) {
          orderTotalController.text = state.orderTotal ?? '';
          orderTotalController.selection = TextSelection.fromPosition(
            TextPosition(offset: orderTotalController.text.length),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Input(
            controller: orderTotalController,
            hintText: LocalizationConstants.orderTotal,
            keyboardType: TextInputType.number,
            onTapOutside: (p0) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ],
      ),
    );
  }
}

class _FilterDatePickerWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final String title;
  final void Function(BuildContext context, DateTime) onSelectDate;

  const _FilterDatePickerWidget({
    required this.selectedDate,
    required this.onSelectDate,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: OptiTextStyles.body,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: DatePickerWidget(
                  key: UniqueKey(),
                  maxDate: null,
                  selectedDateTime: selectedDate,
                  callback: onSelectDate,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
