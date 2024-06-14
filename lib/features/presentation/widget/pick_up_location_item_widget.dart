import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/mixins/map_mixin.dart';
import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/warehouse_extension.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/pickup_location/pickup_location_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/pickup_location/pickup_location_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/pickup_location/pickup_location_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PickupLocationLocationWidgetItem extends StatelessWidget
    with MapDirection {
  final WarehouseEntity warehouse;
  final LatLong? selectedLocation;
  final bool isSelectionOn;


  PickupLocationLocationWidgetItem(
      {super.key,
      required this.warehouse,
      this.selectedLocation,
      required this.isSelectionOn});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          children: [
            Visibility(
              visible: isSelectionOn,
              child: Radio<LatLong?>(
                value: warehouse.latLong,
                groupValue: selectedLocation,
                onChanged: (LatLong? value) {
                  context.read<PickupLocationBloc>().add(
                      PickUpLocationSelectEvent(selectedWarehouse: warehouse));
                },
              ),
            ),
            Expanded(
                child: InkWell(
                    onTap: () {
                      context.read<PickupLocationBloc>().add(
                          PickUpLocationSelectEvent(
                              selectedWarehouse: warehouse));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!warehouse.description.isNullOrEmpty)
                          Text(
                            warehouse.description ?? '',
                            textAlign: TextAlign.start,
                            style: OptiTextStyles.subtitle,
                          ),
                        if (!warehouse.wareHouseAddress().isNullOrEmpty)
                          Text(
                            warehouse.wareHouseAddress(),
                            textAlign: TextAlign.start,
                            style: OptiTextStyles.body,
                          ),
                        if (!warehouse.wareHouseCity().isNullOrEmpty)
                          Text(
                            warehouse.wareHouseCity(),
                            textAlign: TextAlign.start,
                            style: OptiTextStyles.body,
                          ),
                        if (!warehouse.phone.isNullOrEmpty)
                          Text(
                            warehouse.phone ?? '',
                            textAlign: TextAlign.start,
                            style: OptiTextStyles.body,
                          ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
