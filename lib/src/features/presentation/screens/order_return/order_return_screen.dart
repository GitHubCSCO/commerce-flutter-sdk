import 'dart:async';

import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/order_return/order_return_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/order_return/order_return_item.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/order_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReturnInfo {
  int lineNumber;
  int requestCode;
  int numberOfItems;

  ReturnInfo({
    required this.lineNumber,
    required this.requestCode,
    required this.numberOfItems,
  });
}

class OrderReturnScreen extends StatelessWidget {
  final OrderEntity order;

  const OrderReturnScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderReturnCubit>(
      create: (context) => sl<OrderReturnCubit>()..initiateReturn(order),
      child: OrderReturnPage(order: order),
    );
  }
}

class OrderReturnPage extends StatefulWidget {
  final OrderEntity order;
  final List<ReturnInfo> returnInfoList = [];

  OrderReturnPage({
    super.key,
    required this.order,
  });

  @override
  State<OrderReturnPage> createState() => _OrderReturnPageState();
}

class _OrderReturnPageState extends State<OrderReturnPage> {
  final _returnNotesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        centerTitle: false,
        title: Text(LocalizationConstants.returnRequest.localized()),
      ),
      body: BlocConsumer<OrderReturnCubit, OrderReturnState>(
        listener: (context, state) {
          if (state is OrderReturnSuccess) {
            CustomSnackBar.showSnackBarMessage(
              context,
              LocalizationConstants.returnRequestSubmissionIsSuccessful
                  .localized(),
            );
            Navigator.pop(context);
          } else if (state is OrderReturnFailure) {
            CustomSnackBar.showSnackBarMessage(
              context,
              LocalizationConstants.somethingWentWrong.localized(),
            );
          }
        },
        buildWhen: (previous, current) =>
            current is OrderReturnInitial || current is OrderReturnLoaded,
        builder: (context, state) {
          switch (state) {
            case OrderReturnInitial():
              return const Center(child: CircularProgressIndicator());
            case OrderReturnLoaded():
              return Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: _buildOrderNotes(context),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 20)
                                .copyWith(bottom: 8),
                            child: Text(
                              LocalizationConstants.productsToReturn
                                  .localized(),
                              style: OptiTextStyles.titleLarge,
                            ),
                          ),
                        ),
                        _buildOrderReturnItems(
                          context.read<OrderReturnCubit>().order?.orderLines ??
                              [],
                        ),
                        SliverToBoxAdapter(
                          child: _buildOrderInfo(context),
                        ),
                      ],
                    ),
                  ),
                  _buildReturnBottom(),
                ],
              );
            default:
              return const Center(
                child: Text('Unknown state'),
              );
          }
        },
      ),
    );
  }

  Widget _buildOrderNotes(BuildContext context) {
    return Container(
      color: OptiAppColors.backgroundWhite,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Input(
        label: LocalizationConstants.returnNotes.localized(),
        hintText: LocalizationConstants.returnNotesOptional.localized(),
        controller: _returnNotesController,
        onChanged: (value) {},
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onEditingComplete: () {
          FocusManager.instance.primaryFocus?.nextFocus();
        },
      ),
    );
  }

  Widget _buildOrderReturnItems(List<OrderLineEntity> orderLines) {
    widget.returnInfoList.addAll(List.generate(
      orderLines.length,
      (index) => ReturnInfo(
        lineNumber: (orderLines[index].lineNumber ?? 0).toInt(),
        requestCode: 0,
        numberOfItems: 0,
      ),
    ));

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final orderLine = orderLines[index];
          final returnInfo = widget.returnInfoList[index];
          return OrderReturnItem(
            orderLine: orderLine,
            returnInfo: returnInfo,
            onReturnInfoChanged: (int requestCode, int numberOfItems) {
              widget.returnInfoList[index].requestCode = requestCode;
              widget.returnInfoList[index].numberOfItems = numberOfItems;
              context
                  .read<OrderReturnCubit>()
                  .setReturnRequestEnable(widget.returnInfoList);
            },
          );
        },
        childCount: orderLines.length,
      ),
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    var cubit = context.read<OrderReturnCubit>();

    return OrderPaymentSectionWidget(
      discount: cubit.discountValue,
      discountTitle: cubit.discountTitle,
      otherCharges: cubit.otherChargesValue,
      otherChargesTitle: cubit.otherChargesTitle,
      promotions: const [],
      shippingHandling: cubit.shippingHandlingValue,
      shippingHandlingTitle: cubit.shippingHandlingTitle,
      subtotal: cubit.subTotalValue,
      subtotalTitle: cubit.subTotalTitle,
      tax: cubit.taxValue,
      taxTitle: cubit.taxTitle,
      total: cubit.totalValue,
      totalTitle: cubit.totalTitle,
      itemCount: cubit.order!.orderLines?.length,
    );
  }

  Widget _buildReturnBottom() {
    var cubit = context.read<OrderReturnCubit>();

    return BlocBuilder<OrderReturnCubit, OrderReturnState>(
        builder: (context, state) {
      var isEnabled = false;
      if (state is OrderReturnEnable) {
        isEnabled = state.isEnabled;
      }
      return OrderBottomSectionWidget(
        actions: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SecondaryButton(
                    text: LocalizationConstants.cancel.localized(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PrimaryButton(
                    isEnabled: isEnabled,
                    text: LocalizationConstants.returnRequest.localized(),
                    onPressed: () {
                      unawaited(cubit.returnOrder(
                        _returnNotesController.text,
                        widget.returnInfoList,
                      ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
