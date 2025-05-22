import 'package:commerce_flutter_sdk/src/core/mixins/map_mixin.dart';
import 'package:commerce_flutter_sdk/src/core/models/lat_long.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/vmi/vmi_locations/vmi_location_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/vmi/vmi_locations/vmi_location_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/vmi/vmi_locations/vmi_location_state.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/current_location_widget_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VMICurrentLocationWidgetItem extends StatelessWidget with MapDirection {
  final CurrentLocationDataEntity locationData;
  final CurrentLocationDataEntity? selectedLocation;
  final bool isSelectionOn;

  VMICurrentLocationWidgetItem(
      {super.key,
      required this.locationData,
      this.selectedLocation,
      required this.isSelectionOn});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VMILocationBloc, VMILocationState>(
      builder: (_, state) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                Visibility(
                  visible: isSelectionOn,
                  child: Radio<String?>(
                    value: locationData.id,
                    groupValue: selectedLocation?.id,
                    onChanged: (String? value) {
                      context.read<VMILocationBloc>().add(
                          LocationSelectEvent(selectedLocation: locationData));
                    },
                  ),
                ),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          context.read<VMILocationBloc>().add(
                              LocationSelectEvent(
                                  selectedLocation: locationData));
                        },
                        child: CurrentLocationWidgetItem(
                            locationData: locationData,
                            isVMILocationfinder: false)))
              ],
            ),
          ),
        );
      },
    );
  }
}
