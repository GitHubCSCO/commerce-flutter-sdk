import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/quick_order/order_list/order_list_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/style.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/quick_order/order_item_pricing_inventory_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/quick_order/order_widgets/order_product_image_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/quick_order/quick_order_screen.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuickOrderItemWidget extends StatelessWidget {
  final Function(BuildContext context, QuickOrderItemEntity,
      OrderCallBackType orderCallBackType) callback;
  final QuickOrderItemEntity quickOrderItemEntity;
  final ProductSettings setting;

  QuickOrderItemWidget(
      {required this.callback,
      required this.quickOrderItemEntity,
      required this.setting});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            _buildProductDetails(),
          ],
        ),
      ),
    );
  }

  void _navigateToProductDetails(BuildContext context) {
    var productId = quickOrderItemEntity.productEntity.id;
    AppRoute.productDetails.navigateBackStack(context,
        pathParameters: {"productId": productId.toString()},
        extra: ProductEntity());
  }

  Widget _buildProductImage() {
    return OrderProductImageWidget(
        imagePath: quickOrderItemEntity.productEntity.smallImagePath ?? "");
  }

  Widget _buildProductDetails() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderProductTitleWidget(
              callback: callback, orderItemEntity: quickOrderItemEntity),
          BlocConsumer<OrderItemPricingInventoryCubit,
              OrderItemPricingInventoryState>(
            listener: (context, state) {
              if (state is OrderItemSubTotalChange) {
                callback(context, quickOrderItemEntity,
                    OrderCallBackType.calculateSubtotal);
              }
            },
            buildWhen: (previous, current) =>
                current is OrderItemPricingInventoryInitial ||
                current is OrderItemPricingInventoryLoading ||
                current is OrderItemPricingInventoryLoaded ||
                current is OrderItemPricingInventoryFailed,
            builder: (context, state) {
              switch (state.runtimeType) {
                case OrderItemPricingInventoryInitial:
                case OrderItemPricingInventoryLoading:
                  return Container(
                    padding: const EdgeInsets.only(left: 20, top: 12),
                    alignment: Alignment.bottomLeft,
                    child: LoadingAnimationWidget.progressiveDots(
                      color: OptiAppColors.iconPrimary,
                      size: 30,
                    ),
                  );
                case OrderItemPricingInventoryLoaded:
                  return OrderProductPricingWidget(
                      orderItemEntity: quickOrderItemEntity);
                case OrderItemPricingInventoryFailed:
                default:
                  return Container();
              }
            },
          ),
          OrderProductQuantityGroupWidget(
              callback, quickOrderItemEntity, setting)
        ],
      ),
    );
  }
}

class OrderProductTitleWidget extends StatelessWidget {
  final Function(BuildContext context, QuickOrderItemEntity,
      OrderCallBackType orderCallBackType) callback;
  final QuickOrderItemEntity orderItemEntity;

  const OrderProductTitleWidget(
      {Key? key, required this.callback, required this.orderItemEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible:
                      orderItemEntity.productEntity.brand?.name?.isNotEmpty ??
                          false,
                  child: Text(
                    orderItemEntity.productEntity.brand?.name ?? '',
                    style: OptiTextStyles.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible: orderItemEntity
                          .productEntity.shortDescription?.isNotEmpty ??
                      false,
                  child: Text(
                    orderItemEntity.productEntity.shortDescription ?? '',
                    style: OptiTextStyles.body,
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible: orderItemEntity.productEntity
                      .getProductNumber()
                      .isNotEmpty,
                  child: Text(
                    orderItemEntity.productEntity.getProductNumber() ?? '',
                    style: OptiTextStyles.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible:
                      orderItemEntity.productEntity.customerName?.isNotEmpty ??
                          false,
                  child: Row(children: [
                    Text(
                      LocalizationConstants.myPartNumberSign.localized(),
                      style: OptiTextStyles.bodySmallHighlight,
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        orderItemEntity.productEntity.customerName ?? '',
                        style: OptiTextStyles.bodySmall,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ]),
                ),
                Visibility(
                  visible: orderItemEntity
                          .productEntity.manufacturerItem?.isNotEmpty ??
                      false,
                  child: Row(children: [
                    Text(
                      LocalizationConstants.mFGNumberSign.localized(),
                      style: OptiTextStyles.bodySmallHighlight,
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        orderItemEntity.productEntity.manufacturerItem ?? '',
                        style: OptiTextStyles.bodySmall,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          _buildRemoveButton(context)
        ],
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return InkWell(
      onTap: () {
        callback(context, orderItemEntity, OrderCallBackType.itemDelete);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SizedBox(
          width: 30,
          height: 30,
          child: SvgPicture.asset(
            AssetConstants.cartItemRemoveIcon,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}

class OrderProductPricingWidget extends StatelessWidget {
  final QuickOrderItemEntity orderItemEntity;

  const OrderProductPricingWidget({
    required this.orderItemEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 0, 8),
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!(orderItemEntity.hidePricingEnable ?? false)) ...{
                  Visibility(
                    //add showhide pricing logic
                    visible:
                        orderItemEntity.discountValueText?.isNotEmpty ?? false,
                    child: Text(
                      orderItemEntity.discountValueText ?? '',
                      style: OptiTextStyles.bodySmall,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderItemEntity.priceValueText ?? '',
                        style: OptiTextStyles.bodySmallHighlight,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        orderItemEntity.selectedUnitOfMeasureTitle != null
                            ? (' / ${orderItemEntity.selectedUnitOfMeasureTitle}')
                            : '',
                        style: OptiTextStyles.bodySmall,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                },
                if (!(orderItemEntity.hideInventoryEnable ?? false) ||
                    orderItemEntity.showInventoryAvailability == null)
                  Text(
                    orderItemEntity.availability?.message ?? '',
                    style: OptiTextStyles.bodySmall,
                    textAlign: TextAlign.left,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class OrderProductQuantityGroupWidget extends StatefulWidget {
  final Function(BuildContext context, QuickOrderItemEntity,
      OrderCallBackType orderCallBackType) callback;
  final QuickOrderItemEntity quickOrderItemEntity;
  final ProductSettings setting;

  OrderProductQuantityGroupWidget(
      this.callback, this.quickOrderItemEntity, this.setting);

  @override
  State<OrderProductQuantityGroupWidget> createState() =>
      _OrderProductQuantityGroupWidgetState();
}

class _OrderProductQuantityGroupWidgetState
    extends State<OrderProductQuantityGroupWidget> {
  final TextEditingController _textController = TextEditingController();

  String _displayOrderedCount = '';

  @override
  void initState() {
    super.initState();

    _displayOrderedCount =
        widget.quickOrderItemEntity.quantityOrdered.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
      child: LayoutBuilder(builder: (context, constraints) {
        return Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            Container(
                width: (constraints.maxWidth / 2) - 15,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppStyle.borderRadius),
                  color: AppStyle.neutral100,
                ),
                child: TextButton(
                  onPressed: () {
                    _showInputDialog(context);
                  },
                  child: Text(
                    _displayOrderedCount,
                    style: OptiTextStyles.body,
                  ),
                )),
            if (widget.quickOrderItemEntity.productEntity
                        .productUnitOfMeasures !=
                    null &&
                widget.quickOrderItemEntity.productEntity.productUnitOfMeasures!
                        .length >
                    1) ...{
              SizedBox(
                  width: (constraints.maxWidth / 2) - 15,
                  child: _buildUnitOFMeasureChangeWidget(context)),
            },
            if (!(widget.quickOrderItemEntity.hidePricingEnable ?? false)) ...{
              SizedBox(
                width: (constraints.maxWidth / 2) - 15,
                child: BlocBuilder<OrderItemPricingInventoryCubit,
                    OrderItemPricingInventoryState>(
                  buildWhen: (previous, current) =>
                      current is OrderItemPricingInventoryInitial ||
                      current is OrderItemPricingInventoryLoading ||
                      current is OrderItemPricingInventoryLoaded ||
                      current is OrderItemPricingInventoryFailed,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case OrderItemPricingInventoryInitial:
                      case OrderItemPricingInventoryLoading:
                        return Container(
                          padding: const EdgeInsets.only(left: 20, top: 12),
                          alignment: Alignment.center,
                          child: LoadingAnimationWidget.progressiveDots(
                            color: OptiAppColors.iconPrimary,
                            size: 30,
                          ),
                        );
                      case OrderItemPricingInventoryLoaded:
                        return OrderProductSubTitleColumn(
                            LocalizationConstants.subtotal.localized(),
                            widget.quickOrderItemEntity
                                    .extendedPriceValueText ??
                                '');
                      case OrderItemPricingInventoryFailed:
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            }
          ],
        );
      }),
    );
  }

  Widget _buildUnitOFMeasureChangeWidget(BuildContext context) {
    void onUnitOfMeasureSelect(BuildContext context, Object item) {
      widget.quickOrderItemEntity
          .updateSelectedUnitOfMeasure(item as ProductUnitOfMeasureEntity);
      context
          .read<OrderItemPricingInventoryCubit>()
          .getPricingAndInventory(widget.quickOrderItemEntity, widget.setting);
      context
          .read<OrderListBloc>()
          .add(OrderListItemUomChangeEvent(widget.quickOrderItemEntity));
    }

    int getIndexOfUOM(List<ProductUnitOfMeasureEntity>? productUnitOfMeasures,
        ProductUnitOfMeasureEntity? chosenUnitOfMeasure) {
      if (productUnitOfMeasures == null || chosenUnitOfMeasure == null) {
        return 0;
      }

      for (int i = 0; i < productUnitOfMeasures.length; i++) {
        if (productUnitOfMeasures[i].productUnitOfMeasureId ==
            chosenUnitOfMeasure.productUnitOfMeasureId) {
          return i;
        }
      }
      return 0;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppStyle.borderRadius),
        color: AppStyle.neutral100,
      ),
      child: ListPickerWidget(
          items:
              widget.quickOrderItemEntity.productEntity.productUnitOfMeasures ??
                  [],
          selectedIndex: getIndexOfUOM(
              widget.quickOrderItemEntity.productEntity.productUnitOfMeasures,
              widget.quickOrderItemEntity.selectedUnitOfMeasure),
          callback: onUnitOfMeasureSelect,
          showDropDown: true),
    );
  }

  void _showInputDialog(BuildContext context) {
    var focusNode = FocusNode();

    showDialog(
      context: context,
      builder: (BuildContext mContext) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          focusNode.requestFocus();
        });

        return AlertDialog(
          title: Text(
            LocalizationConstants.updateQuantity.localized(),
            style: OptiTextStyles.titleSmall
                .copyWith(color: OptiAppColors.primaryColor),
            textAlign: TextAlign.left,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.quickOrderItemEntity.productEntity.shortDescription ??
                    '',
                style: OptiTextStyles.body,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12.0),
              NumberTextField(
                controller: _textController,
                initialText:
                    widget.quickOrderItemEntity.quantityOrdered.toString(),
                shouldShowIncrementDecrementIcon: false,
                focusNode: focusNode,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(mContext).pop(),
              child: Text(LocalizationConstants.cancel.localized()),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(mContext).pop();
                var quantity = int.tryParse(_textController.text);
                if ((quantity ?? 0) == 0) {
                  _textController.text = '0';
                  widget.quickOrderItemEntity.previousQty =
                      widget.quickOrderItemEntity.quantityOrdered;
                }
                widget.quickOrderItemEntity.quantityOrdered = quantity ?? 0;
                context
                    .read<OrderItemPricingInventoryCubit>()
                    .getPricingAndInventory(
                        widget.quickOrderItemEntity, widget.setting);
                context.read<OrderListBloc>().add(
                    OrderListItemQuantityChangeEvent(
                        widget.quickOrderItemEntity.productEntity.id,
                        widget.quickOrderItemEntity.quantityOrdered));
                setState(() {
                  _displayOrderedCount =
                      widget.quickOrderItemEntity.quantityOrdered.toString();
                });
              },
              child: Text(LocalizationConstants.save.localized()),
            )
          ],
        );
      },
    );
  }
}

class OrderProductSubTitleColumn extends StatelessWidget {
  final String title;
  final String value;

  OrderProductSubTitleColumn(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: OptiTextStyles.bodySmall,
        ),
        Text(
          value,
          style: OptiTextStyles.titleSmall,
        )
      ],
    );
  }
}
