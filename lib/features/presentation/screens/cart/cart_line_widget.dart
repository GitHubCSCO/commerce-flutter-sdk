import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CartLineWidgetList extends StatelessWidget {
  final CartLineListEntity cartLineEntities;

  CartLineWidgetList({required this.cartLineEntities});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartContentBloc, CartContentState>(
        buildWhen: (previous, current) {
      return current is CartContentDefaultState;
    }, listener: (context, state) {
      if (state is CartContentClearAllSuccessState) {
        context.read<CartPageBloc>().add(CartPageLoadEvent());
        CustomSnackBar.showProductAddedToCart(context);
      }
      if (state is CartContentItemRemovedSuccessState) {
        context.read<CartPageBloc>().add(CartPageLoadEvent());
        CustomSnackBar.showProductAddedToCart(context);
      }
    }, builder: (context, state) {
      switch (state) {
        case CartContentDefaultState():
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartContentHeaderWidget(
                  cartCount: cartLineEntities.cartLines!.length),
              Column(
                children: cartLineEntities.cartLines!
                    .map((cartLineEntity) =>
                        CartLineWidget(cartLineEntity: cartLineEntity))
                    .toList(),
              ),
            ],
          );
        default:
          return Container();
      }
    });
  }
}

class CartLineWidget extends StatelessWidget {
  final CartLineEntity cartLineEntity;

  CartLineWidget({required this.cartLineEntity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var productId = cartLineEntity.productId;
        AppRoute.productDetails.navigateBackStack(context,
            pathParameters: {"productId": productId.toString()},
            extra: ProductEntity());
      },
      child: Container(
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartContentProductImageWidget(
                  imagePath: cartLineEntity.smallImagePath ?? ""),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CartContentProductTitleWidget(
                          cartLineEntity: cartLineEntity),
                      CartContentPricingWidget(cartLineEntity: cartLineEntity),
                      CartContentQuantityGroupWidget(cartLineEntity)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<CartContentBloc>().add(CartContentRemoveEvent(
                      CartLineEntityMapper().toModel(cartLineEntity)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      AssetConstants.cartItemRemoveIcon,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartContentProductImageWidget extends StatelessWidget {
  final String imagePath;
  const CartContentProductImageWidget({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(26.0, 22.0, 0.0, 0.0),
      child: Container(
        width: 65,
        height: 65,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFD6D6D6)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image.network(
            imagePath,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}

class CartContentProductTitleWidget extends StatelessWidget {
  final CartLineEntity cartLineEntity;

  const CartContentProductTitleWidget({Key? key, required this.cartLineEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartLineEntity.shortDescription ?? '',
                  style: OptiTextStyles.body,
                  textAlign: TextAlign.left,
                ),
                if (cartLineEntity.getProductNumber() != '')
                  Text(
                    cartLineEntity.getProductNumber(),
                    style: OptiTextStyles.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                if (cartLineEntity.manufacturerItem != null &&
                    cartLineEntity.manufacturerItem!.isNotEmpty)
                  Row(children: [
                    Text(
                      cartLineEntity.manufacturerItem ?? '',
                      style: OptiTextStyles.bodySmall,
                      textAlign: TextAlign.left,
                    ),
                  ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartContentPricingWidget extends StatelessWidget {
  final CartLineEntity cartLineEntity;

  const CartContentPricingWidget({
    required this.cartLineEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDiscountMessageSection(context, cartLineEntity),
              _buildPricingSection(context, cartLineEntity),
              GestureDetector(
                onTap: () {
                  // TODO: Implement the logic for "View Quantity Pricing"
                  CustomSnackBar.showComingSoonSnackBar(context);
                },
                child: Text(
                  "View Quantity Pricing",
                  style: OptiTextStyles.link,
                ),
              ),
              cartLineEntity.availability?.message != null
                  ? _buildInventorySection(context, cartLineEntity)
                  : Container(),
              // _buildInventorySection(context),
              // For "View Availability by Warehouse"
              GestureDetector(
                onTap: () {
                  // TODO: Implement the logic for "View Quantity Pricing"
                  CustomSnackBar.showComingSoonSnackBar(context);
                },
                child: Text(
                  "View Availability by Warehouse",
                  style: OptiTextStyles.link,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDiscountMessageSection(
    BuildContext context, CartLineEntity cartLineEntity) {
  var discountMessage = cartLineEntity.pricing.getDiscountValue();
  if (discountMessage != null &&
      discountMessage.isNotEmpty &&
      discountMessage != "null") {
    return Text(
      discountMessage,
      style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.italic,
          color: OptiAppColors.textSecondary),
    );
  }
  return Container();
}

Widget _buildPricingSection(
    BuildContext context, CartLineEntity cartLineEntity) {
  return Container(
    child: Row(
      children: [
        Text(cartLineEntity.updatePriceValueText(),
            style: OptiTextStyles.bodySmallHighlight),
        Text(
          cartLineEntity.updateUnitOfMeasureValueText(),
          style: OptiTextStyles.bodySmall,
        ),
      ],
    ),
  );
}

Widget _buildInventorySection(
    BuildContext context, CartLineEntity cartLineEntity) {
  return Container(
    child: Text(
      cartLineEntity.availability?.message ?? '',
      style: OptiTextStyles.body,
    ),
  );
}

class CartContentHeaderWidget extends StatelessWidget {
  final int cartCount;
  const CartContentHeaderWidget({
    super.key,
    required this.cartCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430,
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Cart ',
                  style: OptiTextStyles.titleLarge,
                ),
                TextSpan(
                  text: '($cartCount ${cartCount == 1 ? 'Item' : 'Items'})',
                  style: OptiTextStyles.subtitle,
                )
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              context.read<CartContentBloc>().add(CartContentClearAllEvent());
            },
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    child: SvgPicture.asset(
                      AssetConstants.cartClearIcon,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Text('Clear Cart',
                      textAlign: TextAlign.center, style: OptiTextStyles.body),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartContentQuantityGroupWidget extends StatelessWidget {
  final CartLineEntity cartLineEntity;

  CartContentQuantityGroupWidget(this.cartLineEntity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: NumberTextField(
                initialtText: "1",
                shouldShowIncrementDecermentIcon: false,
                onChanged: (int? quantity) {}),
          ),
          // CartContentTitleSubTitleColumn('U/M', 'E/A'),
          CartContentTitleSubTitleColumn(
              'Subtotal', cartLineEntity.updateSubtotalPriceValueText()),
        ],
      ),
    );
  }
}

class CartContentTitleSubTitleColumn extends StatelessWidget {
  final String title;
  final String value;

  CartContentTitleSubTitleColumn(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Text(
            title,
            style: OptiTextStyles.bodySmall,
          ),
          Text(
            value,
            style: OptiTextStyles.titleLarge,
          )
        ],
      ),
    );
  }
}
