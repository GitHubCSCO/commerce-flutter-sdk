import 'dart:async';
import 'package:commerce_flutter_app/features/presentation/cubit/dealer_location_finder/dealer_location_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: library_prefixes
import 'dart:math' as Math;

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
  late LatLngBounds _visibleRegion;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  void _updateVisibleRegion(Function(double) callback) async {
    final GoogleMapController controller = await _controller.future;
    _visibleRegion = await controller.getVisibleRegion();
    double radius = _getMapVisibleRadius();

    callback(radius);
  }

  double _getMapVisibleRadius() {
    LatLng southwestLatLng = _visibleRegion.southwest;
    LatLng northeastLatLng = _visibleRegion.northeast;

    double lat1 = southwestLatLng.latitude;
    double lon1 = southwestLatLng.longitude;
    double lat2 = northeastLatLng.latitude;
    double lon2 = northeastLatLng.longitude;

    int R = 6371; // Radius of the earth in km
    double dLat = _deg2rad(lat2 - lat1); // deg2rad below
    double dLon = _deg2rad(lon2 - lon1);
    double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(_deg2rad(lat1)) *
            Math.cos(_deg2rad(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    double distance = R * c; // Distance in km

    return distance / 2;
  }

  double _deg2rad(double deg) {
    return deg * (Math.pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GMapCubit, GMapState>(
      listener: (context, state) async {
        if (state is GMapMarkersUpdated) {
          final GoogleMapController controller = await _controller.future;
          final firstMarker = state.focusMarker;
          final CameraPosition newPosition = CameraPosition(
            target: firstMarker.position,
            zoom: 6,
          );
          await Future.microtask(() async {
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
              onCameraIdle: () => _updateVisibleRegion((double radius) {
                context
                    .read<DealerLocationCubit>()
                    .updateVisibleMapRadius(radius);
              }),
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
                controller.setMapStyle('[]');
                if (state is GMapMarkersUpdated) {
                  final firstMarker = state.focusMarker;
                  final CameraPosition newPosition = CameraPosition(
                    target: firstMarker.position,
                    zoom: 6,
                  );

                  if (newPosition != null) {
                    await controller.animateCamera(
                      CameraUpdate.newCameraPosition(newPosition),
                    );
                  }
                }
              },
              markers: (state is GMapMarkersUpdated) ? state.markers : {},
              onCameraMove: (CameraPosition position) {},
            ),
          );
        },
      ),
    );
  }
}
