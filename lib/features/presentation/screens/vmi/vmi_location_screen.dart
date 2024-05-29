import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/location_search/location_search_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_state.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/current_location_cubit/current_location_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/vmi/vmi_location_widget_item.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VMILocationScreen extends StatelessWidget {
  final Function(CurrentLocationDataEntity) onLocationSelected;
  const VMILocationScreen({Key? key, required this.onLocationSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return MultiBlocListener(
      listeners: [
        BlocListener<VMILocationBloc, VMILocationState>(
          listener: (_, state) {
            var searchedLocation = context.read<VMILocationBloc>().seachPlace;
            if (state is VMILocationLoadedState) {
              if (searchedLocation == null) {
                context
                    .read<GMapCubit>()
                    .updateMarkersFromVMI(state.currentLocationDataEntityList);
                if (_scrollController.hasClients) {
                  _scrollController.jumpTo(0);
                } // Scroll to the top when new data is loaded
              } else {
                context.read<GMapCubit>().onSeachPlaceMarked(searchedLocation);
              }
            }
          },
        ),
      ],
      child: BlocBuilder<VMILocationBloc, VMILocationState>(
        builder: (_, state) {
          if (state is VMILocationInitialState) {
            return const Center(
              child: Text('VMILocationInitialState'),
            );
          } else if (state is VMILocationLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is VMILocationLoadedState) {
            return Column(
              children: [
                const MapWidget(),
                Expanded(
                  child: ListView(
                    controller:
                        _scrollController, // Attach the ScrollController here
                    children: state.currentLocationDataEntityList
                        .map((e) => VMICurrentLocationWidgetItem(
                              locationData: e,
                              selectedLocation: state.selectedLocation,
                              isSelectionOn: true,
                            ))
                        .toList(),
                  ),
                ),
                ListInformationBottomSubmitWidget(actions: [
                  PrimaryButton(
                    text: LocalizationConstants.selectLocation,
                    onPressed: () async {
                      var selectedLocation =
                          context.read<VMILocationBloc>().selectedLocation;
                      if (selectedLocation != null) {
                        // context
                        //     .read<CurrentLocationCubit>()
                        //     .onLocationSelectEvent(selectedLocation);
                        onLocationSelected(selectedLocation);
                      }
                      context.pop();
                    },
                  ),
                ]),
              ],
            );
          } else {
            return Center(child: Text('Error loading location data'));
          }
        },
      ),
    );
  }
}
