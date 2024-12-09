import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/converter/avalability_color_converter.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/warehouse_inventory/warehouse_inventory_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/warehouse_inventory/warehouse_inventory_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void viewWarehouseWidget(BuildContext context, String? id, String productNumber,
    String unitOfMeasure) {
  var warehouseInventoryCubit = sl<WarehouseInventoryCubit>();
  warehouseInventoryCubit.loadWarehouseInventory(
      id, productNumber, unitOfMeasure);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(LocalizationConstants.warehouseInventory.localized(),
            style: OptiTextStyles.titleLarge),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
              create: (context) => sl<WarehouseInventoryCubit>()
                ..loadWarehouseInventory(
                  id,
                  productNumber,
                  unitOfMeasure,
                ),
              child:
                  BlocBuilder<WarehouseInventoryCubit, WareHouseInventoryState>(
                      builder: (_, state) {
                if (state is WareHouseInventoryLoadingState ||
                    state is WareHouseInventoryInitialState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: LoadingAnimationWidget.progressiveDots(
                          color: OptiAppColors.iconPrimary,
                          size: 30,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: LoadingAnimationWidget.progressiveDots(
                          color: OptiAppColors.iconPrimary,
                          size: 30,
                        ),
                      )
                    ],
                  );
                }
                if (state is WareHouseInventoryLoadedState) {
                  var cellHeight = state.warehouses.length > 1 ? 40 : 20;
                  return SizedBox(
                    height: state.warehouses.length * cellHeight +
                        100.0, // Adjust this value to limit the height of the dialog
                    width: 300.0,
                    child: Column(
                      children: [
                        Flexible(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap:
                                      true, // Important to make ListView scrollable inside a scrollable container
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.warehouses.length,
                                  itemBuilder: (context, index) {
                                    final warehouse = state.warehouses[index];
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 10.0, 0.0, 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text((warehouse
                                                              .description
                                                              ?.isEmpty ??
                                                          true)
                                                      ? (warehouse.name ?? '')
                                                      : warehouse
                                                          .description!)),
                                              Text(
                                                (warehouse.qty ?? 0)
                                                    .toInt()
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                        AvailabilityColorConverter
                                                            .convert(warehouse
                                                                .messageType)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: OptiAppColors.border,
                                          thickness: 1.0,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        PrimaryButton(
                            text: LocalizationConstants.oK.localized(),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })
                      ],
                    ),
                  );
                }
                return Container();
              })),
        ),
      );
    },
  );
}
