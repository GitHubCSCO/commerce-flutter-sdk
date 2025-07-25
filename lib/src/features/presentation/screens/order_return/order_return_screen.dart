import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/style.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/order_return/order_return_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/dropdown_picker.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/order_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: const OrderReturnPage(),
    );
  }
}

class OrderReturnPage extends StatefulWidget {
  const OrderReturnPage({super.key});

  @override
  State<OrderReturnPage> createState() => _OrderReturnPageState();
}

class _OrderReturnPageState extends State<OrderReturnPage> {
  final _returnNotesController = TextEditingController();

  final _qtyController = TextEditingController();

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
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state) {
            case OrderReturnInitial():
              return const Center(child: CircularProgressIndicator());
            case OrderReturnLoaded():
              return Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildItems(context),
                      ),
                    ),
                    _buildReturnBottom(),
                  ],
                ),
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

  List<Widget> _buildItems(BuildContext context) {
    var list = <Widget>[];

    list.add(_buildOrderNotes(context));
    list.add(_buildNumberOfItems(context));
    list.add(_buildReturnReason(context));
    list.add(_buildOrderInfo(context));
    return list;
  }

  Widget _buildOrderNotes(BuildContext context) {
    return Padding(
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

  bool itemsCountError = false;

  Widget _buildNumberOfItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Text(
                  LocalizationConstants.numberOfItems.localized(),
                  style: OptiTextStyles.body,
                ),
                const SizedBox(width: 4.0), // Space between text and star
                const Text(
                  '*',
                  style: TextStyle(
                    color: Colors.red, // Change the color if needed
                  ),
                ),
              ],
            ),
          ),
          NumberTextField(
            min: 1,
            shouldShowIncrementDecrementIcon: false,
            controller: _qtyController,
            onChanged: (value) {},
            focusListener: (hasFocus) {},
            showWarningHighlighted: itemsCountError,
          ),
          Visibility(
            visible: itemsCountError,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Quantity exceeds',
                style: OptiTextStyles.bodySmall
                    .copyWith(color: OptiAppColors.invalidColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int selectedIndex = 0;

  Widget _buildReturnReason(BuildContext context) {
    var reasonList = [LocalizationConstants.selectAReturnReason.localized()];
    final returnReasons = context.read<OrderReturnCubit>().order?.returnReasons;
    if (returnReasons != null) {
      reasonList.addAll(returnReasons.map((reason) => reason.toString()));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              LocalizationConstants.returnRequest.localized(),
              style: OptiTextStyles.body,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppStyle.borderRadius),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownPickerWidget(
                        items: reasonList,
                        callback: (BuildContext context, Object item) {
                          if (item is String) {
                            final isDefaultOption = item == reasonList.first;
                            context
                                .read<OrderReturnCubit>()
                                .setReturnReasonTitle(
                                    isDefaultOption ? '' : item);

                            setState(() {
                              selectedIndex = reasonList.indexOf(item);
                            });
                          }
                        },
                        selectedIndex: selectedIndex,
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
  }

  Widget _buildOrderInfo(BuildContext context) {
    var cubit = context.read<OrderReturnCubit>();

    return OrderPaymentSectionWidget(
      discount: cubit.discountValue,
      discountTitle: cubit.discountTitle,
      otherCharges: cubit.otherChargesValue,
      otherChargesTitle: cubit.otherChargesTitle,
      promotions: [],
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
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: PrimaryButton(
                  isEnabled: true,
                  text: LocalizationConstants.returnRequest.localized(),
                  onPressed: () {
                    final returnItemCount =
                        int.tryParse(_qtyController.text) ?? 0;
                    final availableItems = cubit.order?.orderLines?.length ?? 0;

                    setState(() {
                      itemsCountError = returnItemCount > availableItems;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
