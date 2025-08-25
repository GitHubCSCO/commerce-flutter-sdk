import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/style.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/order_return/order_return_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/order_return/order_return_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/dropdown_picker.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/line_item/line_item_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderReturnItem extends StatefulWidget {
  final void Function(int requestCode, int numberOfItems) onReturnInfoChanged;
  final OrderLineEntity orderLine;
  final ReturnInfo returnInfo;

  const OrderReturnItem({
    super.key,
    required this.orderLine,
    required this.onReturnInfoChanged,
    required this.returnInfo,
  });

  @override
  State<OrderReturnItem> createState() => _OrderReturnItemState();
}

class _OrderReturnItemState extends State<OrderReturnItem> {
  final _qtyController = TextEditingController(text: '0');
  int returnRequestCode = 0;
  bool itemsCountError = false;
  bool returnReasonRequired = false;

  @override
  void initState() {
    super.initState();
    var numberOfItems = widget.returnInfo.numberOfItems;
    _qtyController.text = numberOfItems.toString();
    returnRequestCode = widget.returnInfo.requestCode;
    itemsCountError =
        numberOfItems > 0 && numberOfItems > (widget.orderLine.qtyOrdered ?? 0);
    returnReasonRequired = numberOfItems > 0 && returnRequestCode == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(),
          _buildReturnInfo(),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return LineItemImageWidget(
        imagePath: widget.orderLine.mediumImagePath ?? '');
  }

  Widget _buildReturnInfo() {
    final returnReasons = context.read<OrderReturnCubit>().order?.returnReasons;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.orderLine.shortDescription ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: OptiTextStyles.body,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
            _buildNumberOfItems(context),
            const SizedBox(height: 8),
            if (returnReasons != null && returnReasons.isNotEmpty)
              _buildReturnReason(context, returnReasons),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberOfItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            children: [
              Text(
                LocalizationConstants.numberOfItems.localized(),
                style: OptiTextStyles.bodySmall,
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
          initialText: _qtyController.text,
          min: 0,
          shouldShowIncrementDecrementIcon: false,
          controller: _qtyController,
          onChanged: (value) {
            final numberOfItems = value ?? 0;
            setState(() {
              itemsCountError = numberOfItems > 0 &&
                  numberOfItems > (widget.orderLine.qtyOrdered ?? 0);
              returnReasonRequired =
                  numberOfItems > 0 && returnRequestCode == 0;
            });
            widget.onReturnInfoChanged(
                returnRequestCode, numberOfItems.toInt());
          },
          focusListener: (hasFocus) {},
          showWarningHighlighted: itemsCountError,
        ),
        Visibility(
          visible: itemsCountError,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              LocalizationConstants.quantityExceeds.localized(),
              style: OptiTextStyles.bodySmall
                  .copyWith(color: OptiAppColors.invalidColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReturnReason(
      BuildContext context, List<String?>? returnReasons) {
    var reasonList = [LocalizationConstants.selectCode.localized()];
    if (returnReasons != null) {
      reasonList.addAll(returnReasons.map((reason) => reason.toString()));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            LocalizationConstants.returnRequest.localized(),
            style: OptiTextStyles.bodySmall,
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
                          var numberOfItems = _qtyController.text.isNotEmpty
                              ? int.parse(_qtyController.text)
                              : 0;

                          setState(() {
                            returnRequestCode = reasonList.indexOf(item);
                            returnReasonRequired =
                                numberOfItems > 0 && returnRequestCode == 0;
                          });

                          widget.onReturnInfoChanged(
                              returnRequestCode, numberOfItems);
                        }
                      },
                      selectedIndex: returnRequestCode,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Visibility(
          visible: returnReasonRequired,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              LocalizationConstants.returnReasonIsRequired.localized(),
              style: OptiTextStyles.bodySmall
                  .copyWith(color: OptiAppColors.invalidColor),
            ),
          ),
        ),
      ],
    );
  }
}
