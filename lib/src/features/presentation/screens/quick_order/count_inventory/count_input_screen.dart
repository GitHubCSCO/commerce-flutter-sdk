import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/date_time_extension.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/count_inventory/count_inventory_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/product_list_with_basicInfo.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/tab_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CountInventoryEntity {
  final VmiBinModelEntity vmiBinEntity;
  final OrderEntity? previousOrder;
  int? qty;

  CountInventoryEntity(
      {required this.vmiBinEntity, this.previousOrder, this.qty});

  factory CountInventoryEntity.fromJson(Map<String, dynamic> json) {
    return CountInventoryEntity(
      vmiBinEntity: VmiBinModelEntity.fromJson(json),
      previousOrder: json['previousOrder'] != null
          ? OrderEntity.fromJson(json['previousOrder'])
          : null,
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vmiBinEntity': vmiBinEntity.toJson(),
      'previousOrder': previousOrder?.toJson(),
      'qty': qty,
    };
  }
}

class CountInventoryScreen extends StatelessWidget {
  final CountInventoryEntity countInventoryEntity;

  const CountInventoryScreen({super.key, required this.countInventoryEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CountInventoryCubit>(),
      child: CountInputPage(countInventoryEntity: countInventoryEntity),
    );
  }
}

class CountInputPage extends StatefulWidget {
  final CountInventoryEntity countInventoryEntity;

  const CountInputPage({super.key, required this.countInventoryEntity});

  @override
  State<CountInputPage> createState() => _CountInputPageState();
}

class _CountInputPageState extends State<CountInputPage> {
  final _qtyController = TextEditingController();
  bool isUpdateEnable = true;

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CountInventoryCubit, CountInventoryState>(
      listener: (context, state) {
        if (state is CountInventoryAlert) {
          _showAlertDialog(state.message);
          setState(() {
            isUpdateEnable = !isUpdateEnable;
          });
        } else if (state is CountInventorySuccess) {
          widget.countInventoryEntity.qty = state.qty;
          context.pop(widget.countInventoryEntity);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: OptiAppColors.backgroundWhite,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
              ),
            ),
          ],
        ),
        body: Container(
          color: OptiAppColors.backgroundWhite,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductListItemWithBasicInfo(
                        imageUrl: widget.countInventoryEntity.vmiBinEntity
                            .productEntity?.smallImagePath,
                        title: widget.countInventoryEntity.vmiBinEntity
                            .productEntity?.shortDescription,
                        productNumber: widget
                            .countInventoryEntity.vmiBinEntity.productEntity
                            ?.getProductNumber(),
                      ),
                      const SizedBox(height: 20.0),
                      TabSwitchWidget(
                        tabTitle0: LocalizationConstants.history.localized(),
                        tabTitle1:
                            LocalizationConstants.productInfo.localized(),
                        tabWidget0: _getHistoryWidget(),
                        tabWidget1: _getProductInfoWidget(),
                      ),
                      _getQtyInputWidget()
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: Colors.white),
                child: PrimaryButton(
                  onPressed: () {
                    setState(() {
                      isUpdateEnable = !isUpdateEnable;
                    });
                    context.read<CountInventoryCubit>().updateInventoryQuantity(
                        widget.countInventoryEntity.vmiBinEntity,
                        _qtyController.text);
                  },
                  isEnabled: isUpdateEnable,
                  text: LocalizationConstants.update.localized(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(String message) {
    displayDialogWidget(context: context, message: message, actions: [
      DialogPlainButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(LocalizationConstants.oK.localized()),
      ),
    ]);
  }

  Widget _getQtyInputWidget() {
    int? qty = int.tryParse(_qtyController.text) ??
        widget.countInventoryEntity.vmiBinEntity.lastCountQty?.toInt() ??
        0;
    var previousQty = qty;
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocalizationConstants.qTY.localized(),
              style: OptiTextStyles.body),
          NumberTextField(
            initialText: qty.toString(),
            min: 0,
            shouldShowIncrementDecrementIcon: false,
            controller: _qtyController,
            onChanged: (value) {
              qty = value;
            },
            focusListener: (hasFocus) {
              if (!hasFocus) {
                if (qty != null) {
                  previousQty = qty!;
                } else {
                  qty ??= previousQty;
                  _qtyController.text = (qty ?? 0).toString();
                }
              }
            },
          )
        ],
      ),
    );
  }

  Widget _getHistoryWidget() {
    return Column(
      children: [
        _getPreviousCountWidget(),
        _getPreviousOrderWidget(),
      ],
    );
  }

  Widget _getPreviousCountWidget() {
    List<Widget> list = [];

    final date = _buildRow(
        LocalizationConstants.dateSign.localized(),
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.previousCountDate
            .formatDate(format: 'dd/MM/yyyy'),
        OptiTextStyles.body);
    final countQty = _buildRow(
        LocalizationConstants.countQTYSign.localized(),
        OptiTextStyles.subtitle,
        (widget.countInventoryEntity.vmiBinEntity.previousCountQty?.toInt() ??
                0)
            .toString(),
        OptiTextStyles.body);

    if (date != null) {
      list.add(date);
    }
    if (countQty != null) {
      list.add(countQty);
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocalizationConstants.previousCount.localized(),
              style: OptiTextStyles.titleLarge),
          ...list
        ],
      ),
    );
  }

  Widget _getPreviousOrderWidget() {
    List<Widget> list = [];

    final date = _buildRow(
        LocalizationConstants.dateSign.localized(),
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.previousOrder?.orderDate
                .formatDate(format: 'dd/MM/yyyy') ??
            '',
        OptiTextStyles.body);
    final countQty = _buildRow(
        LocalizationConstants.orderQTYSign.localized(),
        OptiTextStyles.subtitle,
        _getPreviousOrderQty(widget.countInventoryEntity.previousOrder,
            widget.countInventoryEntity.vmiBinEntity),
        OptiTextStyles.body);
    final order = _buildRow(
        LocalizationConstants.orderSign.localized(),
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.previousOrder?.orderNumber ?? '',
        OptiTextStyles.body);

    if (date != null) {
      list.add(date);
    }
    if (countQty != null) {
      list.add(countQty);
    }
    if (order != null) {
      list.add(order);
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocalizationConstants.previouseOrder.localized(),
              style: OptiTextStyles.titleLarge),
          ...list
        ],
      ),
    );
  }

  Widget _getProductInfoWidget() {
    List<Widget> list = [];

    final part = _buildRow(
        LocalizationConstants.partNumberSign.localized(),
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.productEntity
                ?.getProductNumber() ??
            '',
        OptiTextStyles.body);
    final myPart = _buildRow(
        LocalizationConstants.myPartNumberSign.localized(),
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.productEntity?.customerName ??
            '',
        OptiTextStyles.body);
    final mfg = _buildRow(
        LocalizationConstants.mFGNumberSign.localized(),
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.productEntity
                ?.manufacturerItem ??
            '',
        OptiTextStyles.body);
    final bin = _buildRow(
        LocalizationConstants.binSign.localized(),
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.binNumber ?? '',
        OptiTextStyles.body);
    final maxCount = _buildRow(
        LocalizationConstants.maxSign.localized(),
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.maximumQty
                ?.toInt()
                .toString() ??
            '',
        OptiTextStyles.body);
    final minCount = _buildRow(
        LocalizationConstants.minSign.localized(),
        OptiTextStyles.subtitle,
        widget.countInventoryEntity.vmiBinEntity.minimumQty
                ?.toInt()
                .toString() ??
            '',
        OptiTextStyles.body);

    if (part != null) {
      list.add(part);
    }
    if (myPart != null) {
      list.add(myPart);
    }
    if (mfg != null) {
      list.add(mfg);
    }
    if (bin != null) {
      list.add(bin);
    }
    if (maxCount != null) {
      list.add(maxCount);
    }
    if (minCount != null) {
      list.add(minCount);
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: list,
      ),
    );
  }

  Widget? _buildRow(String title, TextStyle titleTextStyle, String body,
      TextStyle bodyTextStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: titleTextStyle,
              ),
            ),
          ),
          Text(
            body,
            textAlign: TextAlign.start,
            style: bodyTextStyle,
          )
        ],
      ),
    );
  }

  String _getPreviousOrderQty(
      OrderEntity? previousOrder, VmiBinModelEntity vmiBinEntity) {
    if (previousOrder?.orderLines?.isNotEmpty ?? false) {
      for (var orderLine in previousOrder?.orderLines ?? []) {
        if (orderLine.productId == (vmiBinEntity.productEntity?.id ?? '')) {
          return orderLine.qtyOrdered.toInt().toString();
        }
      }
    }
    return '';
  }
}
