import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/single_selection_swatch_chip.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/style_trait/style_trait_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/style_trait/style_trait_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

mixin ProductListItemMixIn {
  Widget getSwatchesWidget() {
    return BlocBuilder<StyleTraitCubit, StyleTraitState>(
      builder: (context, state) {
        if (state is StyleTraitStateLoaded &&
            state.styleTraitsEntity.isNotEmpty) {
          var styleTrait = context
              .read<StyleTraitCubit>()
              .getProductListColorTrait(state.styleTraitsEntity);

          return Visibility(
              visible: styleTrait != null,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleSelectionSwatchChip<StyleValueEntity>(
                        values: styleTrait?.styleValues
                                ?.map((e) => e.styleValue!)
                                .toList() ??
                            [],
                        shouldIgnoreTitleAndLabelName: true,
                        maxItemsToShow: 4,
                        orientation: ChipOrientation.horizontal,
                        selectedValue: context
                                .read<StyleTraitCubit>()
                                .selectedStyleValues?[
                            styleTrait?.selectedStyleValue?.styleValue
                                ?.styleTraitValueId],
                        isSelectionEnabled: false,
                        onSelectionChanged: (StyleValueEntity? selection) {}),
                    if ((styleTrait?.styleValues?.length ?? 0) > 4)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(LocalizationConstants.viewMore.localized(),
                            style: OptiTextStyles.link),
                      )
                  ]));
        }
        return Container();
      },
    );
  }

  bool showWarehouseInventory(
      ProductEntity product, ProductSettings? productSettings) {
    var warehouseInventoryButtonEnabled =
        InventoryUtils.isInventoryPerWarehouseButtonShownAsync(productSettings);
    var showWarehouseInventoryButton = false;

    if (!(product.isConfigured ?? false) ||
        (product.isFixedConfiguration ?? false) &&
            !(product.isStyleProductParent ?? false)) {
      if (product.availability != null &&
          !(product.availability?.requiresRealTimeInventory ?? false) &&
          (product.availability?.messageType ?? 0) != 0) {
        showWarehouseInventoryButton = (product.trackInventory ?? false) &&
            warehouseInventoryButtonEnabled;
      }
    }

    return showWarehouseInventoryButton;
  }

  Widget getInfoWidget(ProductEntity product) {
    List<Widget> list = [];

    final myPart = _buildRow(
        LocalizationConstants.myPartNumberSign.localized(),
        OptiTextStyles.bodySmall,
        product.customerName ?? '',
        OptiTextStyles.bodyExtraSmall);
    final mfg = _buildRow(
        LocalizationConstants.mFGNumberSign.localized(),
        OptiTextStyles.bodySmall,
        product.manufacturerItem ?? '',
        OptiTextStyles.bodyExtraSmall);

    final pack = _buildRow(
        LocalizationConstants.packSign.localized(),
        OptiTextStyles.bodySmall,
        product.packDescription ?? '',
        OptiTextStyles.bodyExtraSmall);

    if (myPart != null) {
      list.add(myPart);
    }
    if (mfg != null) {
      list.add(mfg);
    }
    if (pack != null) {
      list.add(pack);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget? _buildRow(String title, TextStyle titleTextStyle, String body,
      TextStyle bodyTextStyle) {
    if (title.isEmpty || body.isEmpty) {
      return null;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: titleTextStyle,
          ),
        ),
        Text(
          body,
          textAlign: TextAlign.start,
          style: bodyTextStyle,
        )
      ],
    );
  }
}
