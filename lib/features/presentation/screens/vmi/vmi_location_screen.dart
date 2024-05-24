import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_state.dart';
import 'package:commerce_flutter_app/features/presentation/widget/current_location_widget_item.dart';
import 'package:commerce_flutter_app/features/presentation/widget/map_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VMILocationScreen extends StatelessWidget {
  const VMILocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VMILocationBloc, VMILocationState>(
        builder: (context, state) {
      if (state is VMILocationInitialState) {
        return Container(
          child: Text('VMILocationInitialState'),
        );
      } else if (state is VMILocationLoadingState) {
        return Container(
          child: CircularProgressIndicator(),
        );
      } else if (state is VMILocationLoadedState) {
        return Column(
          children: [
            MapWidget(),
            Expanded(
              child: ListView(
                children: state.currentLocationDataEntityList
                    .map((e) => CurrentLocationWidgetItem(locationData: e))
                    .toList(),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
