import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/pickup_location/pickup_location_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/pickup_location/pickup_location_state.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/map_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/pick_up_location_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PickUpLocationScreen extends StatelessWidget {
  final Function(WarehouseEntity) onWarehouseLocationSelected;
  const PickUpLocationScreen(
      {super.key, required this.onWarehouseLocationSelected});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return MultiBlocListener(
      listeners: [
        BlocListener<PickupLocationBloc, PickUpLocationState>(
          listener: (_, state) {
            if (state is PickUpLocationLoadedState) {
              context
                  .read<GMapCubit>()
                  .updateMarkersFromPickUpLocation(state.wareHouselist);
              if (scrollController.hasClients) {
                scrollController.jumpTo(0);
              } // Scroll to the top when new data is loaded
            }
          },
        ),
      ],
      child: BlocBuilder<PickupLocationBloc, PickUpLocationState>(
        builder: (_, state) {
          if (state is PickUpLocationInitialState) {
            return const Center(
              child: Text('PickupILocationInitialState'),
            );
          } else if (state is PickUpLocationLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PickUpLocationLoadedState) {
            return Column(
              children: [
                const MapWidget(),
                Expanded(
                  child: ListView(
                    controller:
                        scrollController, // Attach the ScrollController here
                    children: state.wareHouselist
                        .map((wareHouse) => PickupLocationLocationWidgetItem(
                              warehouse: wareHouse,
                              isSelectionOn: true,
                              selectedLocation: state.selectedLocation,
                            ))
                        .toList(),
                  ),
                ),
                ListInformationBottomSubmitWidget(actions: [
                  PrimaryButton(
                    text: LocalizationConstants.selectLocation,
                    onPressed: () async {
                      var selectedLocation =
                          context.read<PickupLocationBloc>().selectedWarehouse;
                      if (selectedLocation != null) {
                        // context
                        //     .read<CurrentLocationCubit>()
                        //     .onLocationSelectEvent(selectedLocation);
                        onWarehouseLocationSelected(selectedLocation);
                      }
                      context.pop();
                    },
                  ),
                ]),
              ],
            );
          } else {
            return const Center(child: Text('Error loading location data'));
          }
        },
      ),
    );
  }
}
