import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/vmi/vmi_location_widget_item.dart';
import 'package:commerce_flutter_app/features/presentation/widget/current_location_widget_item.dart';
import 'package:commerce_flutter_app/features/presentation/widget/map_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VMILocationScreen extends StatelessWidget {
  const VMILocationScreen({super.key});

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
                _scrollController
                    .jumpTo(0); // Scroll to the top when new data is loaded
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
            return Center(
              child: Text('VMILocationInitialState'),
            );
          } else if (state is VMILocationLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is VMILocationLoadedState) {
            return Column(
              children: [
                MapWidget(),
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
