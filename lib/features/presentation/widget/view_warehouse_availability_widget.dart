import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/warehouse_inventory/warehouse_inventory_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/warehouse_inventory/warehouse_inventory_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

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
        title: Text("Warehouse Details"),
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
                if (state is WareHouseInventoryLoading ||
                    state is WareHouseInventoryInitialState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is WareHouseInventoryLoadedState) {
                  return Container(
                    height: state.warehouses.length * 25 +
                        100, // adjust the value as needed
                    width: 300.0,
                    child: Column(
                      children: [
                        Flexible(
                          child: ListView.builder(
                            itemCount: state.warehouses.length,
                            itemBuilder: (context, index) {
                              final warehouse = state.warehouses[index];
                              return Row(
                                children: [
                                  Text(warehouse.name!),
                                  Text(warehouse.qty.toString()),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              })),
        ),
        actions: [
          ElevatedButton(
            child: const Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class WareHouseInventoryLoading {}
