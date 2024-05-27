import 'dart:async';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.23232, -122.085749655962),
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition? _pendingCameraPosition;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GMapCubit, GMapState>(
      listener: (context, state) async {
        if (state is GMapMarkesUpdated && state.markers.isNotEmpty) {
          final GoogleMapController controller = await _controller.future;
          final firstMarker = state.markers.first;
          final CameraPosition newPosition = CameraPosition(
            target: firstMarker.position,
            zoom: 14.4746,
          );
          Future.microtask(() async {
            await controller
                .animateCamera(CameraUpdate.newCameraPosition(newPosition));
          });
        }
      },
      child: BlocBuilder<GMapCubit, GMapState>(
        builder: (context, state) {
          return SizedBox(
            height: 220,
            width: double.infinity,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
                controller.setMapStyle('[]');
                if (_pendingCameraPosition != null) {
                  await controller.animateCamera(
                    CameraUpdate.newCameraPosition(_pendingCameraPosition!),
                  );
                  _pendingCameraPosition = null;
                }
              },
              markers: (state is GMapMarkesUpdated) ? state.markers : {},
              onCameraMove: (CameraPosition position) {
                debugPrint(
                  'Camera position: ${position.target.latitude}, ${position.target.longitude}',
                );
              },
            ),
          );
        },
      ),
    );
  }
}
